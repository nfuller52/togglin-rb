# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Serialize do
  let(:first_organization) { create(:organization) }
  let(:second_organization) { create(:organization) }

  describe '.one' do
    it 'returns nil for nil input' do
      expect(described_class.one(nil)).to be_nil
    end

    it 'serializes an active record object with the default profile' do
      serialized = described_class.one(first_organization)

      expect(serialized).to eq(
        'id' => first_organization.id,
        'name' => first_organization.name,
        'slug' => first_organization.slug,
        'createdAt' => first_organization.created_at.iso8601,
        'updatedAt' => first_organization.updated_at.iso8601
      )
    end

    it 'includes fields in the :only option' do
      serialized = described_class.one(first_organization, only: %i[name])
      expect(serialized).to eq('name' => first_organization.name)
    end

    it 'removes fields from the :except option' do
      serialized = described_class.one(first_organization, except: %i[name slug created_at updated_at])
      expect(serialized).to eq('id' => first_organization.id)
    end

    it 'includes AR model methods' do
      serialized = described_class.one(first_organization, only: %i[name slug], methods: %i[full_name])
      expect(serialized).to eq('name' => first_organization.name, 'slug' => first_organization.slug)
    end

    it 'raises with unsupported types' do
      expect { described_class.one(123) }.to raise_error(ArgumentError)
    end
  end

  describe '.many' do
    it 'serializes an array of active record objects' do
      result = described_class.many([first_organization, second_organization], only: %i[name])
      expect(result).to eq([{ 'name' => first_organization.name }, { 'name' => second_organization.name }])
    end

    it 'serializes an active record relation' do
      result = described_class.many(Organization.where(id: [first_organization.id, second_organization.id]),
                                    only: %i[name])
      expect(result).to eq([{ 'name' => first_organization.name }, { 'name' => second_organization.name }])
    end

    it 'serializes an array of hashes' do
      result = described_class.many([{ first_name: 'Test', password: 'x' }], only: %i[first_name])
      expect(result).to eq([{ 'firstName' => 'Test' }])
    end

    it 'returns an empty array with an empty data set' do
      expect(described_class.many([])).to eq([])
    end

    it 'raises with unsupoprted types' do
      expect { described_class.many(first_organization) }.to raise_error(ArgumentError)
    end
  end
end

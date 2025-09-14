# frozen_string_literal: true

require "rails_helper"

RSpec.describe Serialize do
  before(:all) do # rubocop:disable RSpec/BeforeAfterAll
    ActiveRecord::Schema.define do
      create_table :serializer_spec_users, force: true do |t|
        t.string :email
        t.string :first_name
        t.string :last_name
        t.string :password_digest
        t.json :meta
        t.timestamps
      end
    end

    class SerializerSpecUser < ApplicationRecord # rubocop:disable RSpec/LeakyConstantDeclaration
      self.table_name = "serializer_spec_users"

      SERIALIZER_PROFILES = { # rubocop:disable RSpec/LeakyConstantDeclaration
        default: %i[id email first_name last_name],
        admin: %i[id email first_name last_name meta created_at updated_at]
      }.freeze

      def full_name
        "#{first_name} #{last_name}"
      end
    end
  end

  after(:all) do # rubocop:disable RSpec/BeforeAfterAll
    ActiveRecord::Base.connection.drop_table(:serializer_spec_users, if_exists: true) rescue StandardError
    Object.send(:remove_const, :SerializerSpecUser) if defined?(SerializerSpecUser) # rubocop:disable RSpec/RemoveConst
  end

  let(:alice) {
    SerializerSpecUser.create(email: 'alice@example.com', first_name: 'Alice', last_name: 'Anderson',
                              meta: { user_role: 'admin' }) }

  let(:bob) {
    SerializerSpecUser.create(email: 'bob@example.com', first_name: 'Bob', last_name: 'Brown',
                              meta: { user_role: 'user' }) }

  describe '.one' do
    it 'returns nil for nil input' do
      expect(described_class.one(nil)).to be_nil
    end

    it 'serializes an active record object with the default profile' do
      serialized = described_class.one(alice)

      expect(serialized).to eq(
        "id" => alice.id,
        "email" => "alice@example.com",
        "firstName" => "Alice",
        "lastName" => "Anderson"
      )
    end

    it 'includes fields in the :only option' do
      serialized = described_class.one(alice, only: %i[email])
      expect(serialized).to eq("email" => "alice@example.com")
    end

    it 'removes fields from the :except option' do
      serialized = described_class.one(alice, except: %i[email, last_name])
      expect(serialized).to eq("id" => alice.id, "firstName" => "Alice")
    end

    it 'includes AR model methods' do
      serialized = described_class.one(alice, only: %i[first_name, last_name], methods: %i[full_name])
      expect(serialized).to eq("firstName" => "Alice", "lastName" => "Anderson", "fullName" => "Alice Anderson")
    end

    it 'serializes nested keys' do
      serialized = described_class.one(alice, profile: :admin)
      expect(serialized).to eq(
        "id" => alice.id,
        "email" => "alice@example.com",
        "firstName" => "Alice",
        "lastName" => "Anderson",
        "meta" => {
          "userRole" => "admin"
        },
        "createdAt" => alice.created_at.iso8601,
        "updatedAt" => alice.updated_at.iso8601,
      )
    end

    it 'raises with unsupported types' do
      expect { described_class.one(123) }.to raise_error(ArgumentError)
    end
  end

  describe '.many' do
    it 'serializes an array of active record objects' do
      result = described_class.many([alice, bob], only: %i[email])
      expect(result).to eq([{ "email" => "alice@example.com" }, { "email" => "bob@example.com" }])
    end

    it 'serializes an active record relation' do
      result = described_class.many(SerializerSpecUser.where(id: [alice.id, bob.id]), only: %i[email])
      expect(result).to eq([{ "email" => "alice@example.com" }, { "email" => "bob@example.com" }])
    end

    it 'serializes an array of hashes' do
      result = described_class.many([{ first_name: "Test", password: "x" }], only: %i[first_name])
      expect(result).to eq([{ "firstName" => "Test" }])
    end

    it 'returns an empty array with an empty data set' do
      expect(described_class.many([])).to eq([])
    end

    it 'raises with unsupoprted types' do
      expect { described_class.many(alice) }.to raise_error(ArgumentError)
    end
  end
end

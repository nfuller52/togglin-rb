# frozen_string_literal: true

require 'oj'

class Serialize
  class << self
    def one(record, json: false, **opts)
      return nil unless record

      result = new(opts).one(record)
      json ? Oj.dump(result, mode: :compat) : result
    end

    def many(records, json: false, **opts)
      return nil unless records

      result = new(opts).many(records)
      json ? Oj.dump(result, mode: :compat) : result
    end
  end

  def initialize(opts = {})
    @except = opts.fetch(:except, nil)
    @methods = opts.fetch(:methods, nil)
    @only = opts.fetch(:only, nil)
    @profile = opts.fetch(:profile, nil)

    @camel_case_cache = {}
  end

  def one(resource)
    type = resource_type(resource)
    fields = resolve_fields(resource, type)

    if @except.present?
      exclusions = explicit_fields_list(@except)
      fields = fields.reject { |f| exclusions.include?(f) }
    end

    result = {}

    case type
    when :active_record
      attributes = resource.attributes

      fields.each do |field|
        key = camelize_key(field)
        val = attributes[field.to_s]
        result[key] = traverse_nested_value(val)
      end

      Array(@methods).each do |m|
        next unless resource.respond_to?(m)

        key = camelize_key(m)
        result[key] = traverse_nested_value(resource.public_send(m))
        Rails.logger.debug("\n\n\n#{result[key]}\n\n\n")
      end
    when :hash
      fields.each do |field|
        key = camelize_key(field)
        val = resource.key?(field) ? resource[field] : resource[field.to_s]
        result[key] = traverse_nested_value(val)
      end
    end

    result
  end

  def many(resources)
    raise ArgumentError, 'Enumerable required for Serialize.many' unless resources.is_a?(Enumerable)

    resources.map { |resource| one(resource) }
  end

  private

  def resource_type(resource)
    if resource.is_a?(Hash)
      :hash
    elsif resource.class.ancestors.map(&:name).include?('ApplicationRecord')
      :active_record
    else
      :other
    end
  end

  def resolve_fields(resource, type)
    return explicit_fields_list(@only) if @only.present?

    if type == :active_record
      profiles = begin
        resource.class.const_get(:SERIALIZER_PROFILES)
      rescue StandardError
        nil
      end

      if profiles
        if @profile && profiles[@profile]
          return profiles[@profile].map! { |f| f.is_a?(String) ? f.to_sym : f }
        elsif profiles[:default]
          return profiles[:default].map! { |f| f.is_a?(String) ? f.to_sym : f }
        end
      end

      return resource.attributes.keys.map!(&:to_sym)
    elsif type == :hash
      return resource.keys.map! { |k| k.is_a?(String) ? k.to_sym : k }
    end

    raise ArgumentError, "Unsupported (Hash or Active Record Model) for class: #{resource.class}"
  end

  def explicit_fields_list(list)
    Array(list).compact.map do |k|
      s = k.to_s.strip
      s = s.delete_suffix(',')
      s.to_sym
    end
  end

  def camelize_key(field)
    @camel_case_cache.fetch(field) do
      str = field.to_s
      camelized = str.camelize(:lower)
      @camel_case_cache[field] = camelized.freeze
    end
  end

  def traverse_nested_value(value)
    case value
    when Hash
      result = {}

      value.each do |k, v|
        key = camelize_key(k)
        result[key] = traverse_nested_value(v)
      end

      result
    when ActiveRecord::Associations::CollectionProxy, ActiveRecord::Relation
      self.class.many(value)
    when ActiveRecord::Base
      self.class.one(value)
    when Array
      value.map { |v| traverse_nested_value(v) }
    when Time, DateTime, Date
      value.iso8601
    else
      if value.respond_to?(:iso8601) && value.class.name&.include?('ActiveSupport::TimeWithZone')
        value.iso8601
      else
        value
      end
    end
  end
end

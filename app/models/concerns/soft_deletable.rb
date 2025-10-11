# frozen_string_literal: true

module SoftDeletable
  extend ActiveSupport::Concern

  included do
    class << self
      alias_method :original_delete_all, :delete_all

      def delete_all(conditions = nil)
        where(conditions).update_all(deleted_at: Time.current) # rubocop:disable Rails/SkipsModelValidations
      end

      def delete_all!(conditions = nil)
        conditions ? where(conditions).delete_all! : original_delete_all
      end

      relation_klass = const_defined?(:ActiveRecord_Relation) ? const_get(:ActiveRecord_Relation) : ActiveRecord::Relation
      relation_klass.class_eval do
        alias_method :original_delete_all, :delete_all

        def delete_all(conditions = nil)
          where(conditions).update_all(deleted_at: Time.current) # rubocop:disable Rails/SkipsModelValidations
        end

        def delete_all!(conditions = nil)
          if conditions
            where(conditions).delete_all!
          else
            original_delete_all
          end
        end
      end
    end
  end

  def deleted?
    deleted_at.present?
  end

  def destroy
    return self if deleted?

    with_transaction_returning_status do
      run_callbacks(:destroy) do
        update_attribute(:deleted_at, Time.current) # rubocop:disable Rails/SkipsModelValidations
        self
      end
    end
  end

  def destroy!
    with_transaction_returning_status do
      run_callbacks(:destroy) do
        self.class.delete_all!(self.class.primary_key => id)
        self
      end
    end
  end

  def restore
    return self unless deleted?

    self.class.transaction do
      update_attribute(:deleted_at, nil) # rubocop:disable Rails/SkipsModelValidations
      self
    end
  end
end

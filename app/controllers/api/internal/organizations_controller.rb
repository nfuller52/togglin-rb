# frozen_string_literal: true

module Api
  module Internal
    class OrganizationsController < InternalApiBaseController
      def index
        render_json Serialize.many(Current.user.organizations)
      end

      def create
        org = Organization.onboard(**create_organization_params, owner: Current.user)

        if org.persisted?
          render_json Serialize.one(org), status: :created
        else
          render_json_error(message: "validations", data: org.errors, status: :unprocessable_entity)
        end
      end

      private

      def create_organization_params
        name = params.require(:name)

        { name: name }
      end
    end
  end
end

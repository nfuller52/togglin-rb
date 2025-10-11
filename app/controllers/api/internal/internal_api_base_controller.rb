# frozen_string_literal: true

module Api
  module Internal
    class InternalApiBaseController < ApplicationController
      include Api::Internal::Concerns::Authentication
      include Api::Internal::Responses

      layout false
      protect_from_forgery with: :exception

      before_action :authenticate_user!

      rescue_from StandardError, with: :render_internal_server_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActionController::ParameterMissing, with: :render_bad_request
      rescue_from ActionController::BadRequest, with: :render_bad_request
      rescue_from JSON::ParserError, with: :render_bad_request

      private

      def render_json(data, status: :ok)
        render json: data, status: status
      end

      def render_json_error(message:, data: [], status: :unprocessable_content)
        render json: { message: message, errors: data }, status: status
      end

      def render_internal_server_error(exception)
        Rails.logger.error(exception.full_message)
        render_json_error(**internal_server_error)
      end

      def render_not_found(exception)
        render_json_error(message: exception.message, status: :not_found)
      end

      def render_bad_request(exception)
        render_json_error(message: exception.message, status: :bad_request)
      end
    end
  end
end

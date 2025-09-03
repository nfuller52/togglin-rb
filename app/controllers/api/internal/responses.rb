# frozen_string_literal: true

module Api
  module Internal
    module Responses
      def internal_server_error
        { message: "Internal Server Error", status: :internal_server_error }
      end

      def too_many_requests
        { message: "Too many requests", status: :too_many_requests }
      end
    end
  end
end

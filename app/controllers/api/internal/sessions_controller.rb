# frozen_string_literal: true

module Api
  module Internal
    class SessionsController < InternalApiBaseController
      allow_unauthenticated_access only: %i[create]

      rate_limit(
        to: 10,
        within: 10.minutes,
        only: :create,
        with: -> { render_json_error(**too_many_requests) }
      )

      def create
        if user = User.authenticate_by(session_params)
          session = start_new_session_for(user)
          render_json(session.as_json(only: %i[id created_at]))
        else
          render_json_error(message: "Invalid email or password", status: :unauthorized)
        end
      end

      def destroy
        terminate_session
        render_json({ message: "Logged out successfully" }, status: :ok)
      end

      private

      def session_params
        email = params.require(:email)
        password = params.require(:password)

        { email: email, password: password }
      end
    end
  end
end

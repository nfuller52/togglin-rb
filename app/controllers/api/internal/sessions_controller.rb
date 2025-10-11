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
        if (user = User.authenticate_by(session_params))
          session = start_new_session_for(user)
          render_json(Serialize.one(session, methods: [:organizations]), status: :created)
        else
          render_json_error(message: 'Invalid email or password', status: :unauthorized)
        end
      end

      def destroy
        terminate_session
        render_json({ message: 'Logged out successfully' }, status: :ok)
      end

      def show
        user = Current.user

        if user
          render_json(Serialize.one(user))
        else
          render_json_error(message: 'Internal server error', status: :error)
        end
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

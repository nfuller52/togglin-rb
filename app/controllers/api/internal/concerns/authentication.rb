# frozen_string_literal: true

module Api
  module Internal
    module Concerns
      module Authentication
        extend ActiveSupport::Concern

        included do
          before_action :authenticate_user!
          helper_method :authenticated?
        end

        class_methods do
          def allow_unauthenticated_access(**options)
            skip_before_action :authenticate_user!, **options
          end
        end

        private

        def authenticate_user!
          resume_session || request_authentication
        end

        def authenticated?
          resume_session
        end

        def resume_session
          Current.user_session ||= find_session_by_cookie
        end

        def find_session_by_cookie
          UserSession.find_by(id: cookies.signed[:session_id]) if cookies.signed[:session_id]
        end

        def request_authentication
          session[:return_to_after_authenticating] = request.url
          # TODO: update this path for react
          render_json_error(message: 'Authentication required', status: :unauthorized)
        end

        def after_authentication_url
          session.delete(:return_to_after_authenticating) || root_path
        end

        def start_new_session_for(user)
          user.user_sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
            Current.user_session = session
            cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
          end
        end

        def terminate_sesion
          Current.user_session.destroy
          cookies.delete(:session_id)
        end
      end
    end
  end
end

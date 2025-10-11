# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  after_action :set_csrf_cookie

  private

  def set_csrf_cookie
    cookies['X-CSRF-Token'] = {
      value: form_authenticity_token,
      secure: Rails.env.production?,
      same_site: :lax,
      httponly: false
    }
  end
end

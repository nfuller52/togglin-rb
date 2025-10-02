require 'swagger_helper'

describe 'Session API' do
  path '/api/internal/session' do
    post 'Log in to a new user session' do
      tags API_TAGS[:authentication]
      consumes 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        required: %w[email password],
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }


      response '201', 'session created' do
        before { create(:user, email: email, password: password) }

        let(:email) { 'test@example.com' }
        let(:password) { 'Password1!' }

        let(:payload) { { email:, password: } }

        run_test!
      end
    end
  end
end

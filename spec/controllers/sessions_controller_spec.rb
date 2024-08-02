require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #authenticate' do
    let(:user) { create(:user, name: 'test', email: 'test@example.com', password: 'password123') }

    context 'with valid credentials' do
      before do
        post :authenticate, params: { email: user.email, password: user.password }
      end

      it 'should be return successful' do
        expect(response).to have_http_status(:ok)
      end

      it 'should be return a JSON with user data and a JWT token' do
        response_json = JSON.parse(response.body)

        expect(response_json['id']).to eq(user.id)
        expect(response_json['name']).to eq(user.name)
        expect(response_json['email']).to eq(user.email)
        expect(response_json['token']).to be_present
      end
    end

    context 'when error returned' do
      before do
        post :authenticate, params: { email: user.email, password: 'wrongpassword' }
      end

      it 'should be return a error' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'should be return a message' do
        response_json = JSON.parse(response.body)

        expect(response_json['error']).to eq('Email/Password incorrect.')
      end
    end
  end
end

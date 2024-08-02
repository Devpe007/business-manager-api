require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'when successfully created' do
      let!(:user) { create(:user) }

      it 'should be valid user' do
        expect(user).to be_valid
      end

      it 'create a user' do
        post :create, params: { name: 'test', email: 'test@gmail.com', password: '123123' }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when is not created' do
      let!(:user) { create(:user) }

      before do
        User.create!(name: 'test', email: 'test@gmail.com', password: 'test123123')
      end

      it 'should not be valid user' do
        user.name = nil
        user.valid?

        expect(user).to_not be_valid
      end

      it 'should be unique email' do
        post :create, params: { name: 'test user', email: 'test@gmail.com', password: '123123' }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['message']).to eq('This user already exists.')
      end
    end
  end
end

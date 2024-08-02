require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  let(:user) { create(:user) }
  let(:secret_key) { '<%= ENV["JWT_SECRET"] %>' }
  let(:valid_token) { JWT.encode({ user_id: user.id }, secret_key) }
  let(:valid_headers) { { 'Authorization' => "Bearer #{valid_token}" } }
  let(:invalid_headers) { { 'Authorization' => 'Bearer invalid_token' } }

  describe 'POST #create' do
    let(:customer) { create(:customer) }

    context 'when is successfully returned' do
      before do
        request.headers.merge!(valid_headers)
      end

      it 'should be valid customer' do
        expect(customer).to be_valid
      end

      it 'should be create customer' do
        post :create, params: {
          name: customer.name,
          email: customer.email,
          address: customer.address,
          description: customer.description,
          mobile_number: customer.mobile_number,
          user_id: customer.user_id
        }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when is not successfully returned' do
      it 'should not be valid customer' do
        customer.user_id = nil
        customer.valid?

        expect(customer).to_not be_valid
      end
    end
  end

  describe 'UPDATE #update' do
    let(:customer) { create(:customer) }

    before do
      request.headers.merge!(valid_headers)

      put :update, params: {
        id: customer.id,
        customer: {
          name: customer.name,
          email: customer.email,
          address: customer.address,
          description: customer.description,
          mobile_number: customer.mobile_number
        }
      }
    end

    context 'when is successfully updated' do
      it 'should be valid customer' do
        expect(customer).to be_valid
      end

      it 'should be update customer' do
        expect(response).to have_http_status(:accepted)
      end

      it 'should be return a JSON with customer data' do
        response_json = JSON.parse(response.body)

        expect(response_json['id']).to eq(customer.id)
        expect(response_json['name']).to eq(customer.name)
        expect(response_json['email']).to eq(customer.email)
        expect(response_json['address']).to eq(customer.address)
        expect(response_json['description']).to eq(customer.description)
        expect(response_json['user_id']).to eq(customer.user_id)
      end
    end

    context 'when is not successfully updated' do
      it 'should be not valid customer' do
        customer.name = nil
        customer.valid?

        expect(customer).to_not be_valid
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:customer) { create(:customer) }

    before do
      request.headers.merge!(valid_headers)

      delete :destroy, params: { id: customer.id }
    end

    context 'when is successfully destroyed' do
      it 'should be destroy customer' do
        expect(response).to have_http_status(:accepted)
      end

      it 'should be return a json message' do
        expect(JSON.parse(response.body)['message']).to eq('Customer destroyed successfully.')
      end
    end

    context 'when is not successfully destroyed' do
      it 'should be a invalid customer' do
        customer.name = nil
        customer.valid?

        expect(customer).to_not be_valid
      end
    end
  end
end

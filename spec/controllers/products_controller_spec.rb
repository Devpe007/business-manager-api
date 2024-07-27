require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:user) { create(:user) }
  let(:secret_key) { '<%= ENV["JWT_SECRET"] %>' }
  let(:valid_token) { JWT.encode({ user_id: user.id }, secret_key) }
  let(:valid_headers) { { 'Authorization' => "Bearer #{valid_token}" } }
  let(:invalid_headers) { { 'Authorization' => 'Bearer invalid_token' } }

  describe 'GET #show' do
    let(:product) { create(:product) }

    before do
      request.headers.merge!(valid_headers)

      get :show, params: {
        id: product.id
      }
    end

    context 'when is successfully showed' do
      it 'should be valid product' do
        expect(product).to be_valid
      end

      it 'should be return a JSON with product data' do
        response_json = JSON.parse(response.body)

        expect(response_json['id']).to eq(product.id)
        expect(response_json['name']).to eq(product.name)
        expect(response_json['price']).to eq(product.price)
        expect(response_json['cost']).to eq(product.cost)
        expect(response_json['quantity']).to eq(product.quantity)
        expect(response_json['inventory']).to eq(product.inventory)
        expect(response_json['user_id']).to eq(product.user_id)
      end
    end
  end

  describe 'POST #create' do
    let(:product) { create(:product) }

    before do
      request.headers.merge!(valid_headers)

      post :create, params: {
        name: product.name,
        price: product.price,
        cost: product.cost,
        quantity: product.quantity,
        inventory: product.inventory
      }
    end

    context 'when is successfully returned' do
      it 'should be valid product' do
        expect(product).to be_valid
      end

      it 'should be create product' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when is not successfully returned' do
      it 'should not be valid product' do
        product.user_id = nil
        product.valid?

        expect(product).to_not be_valid
      end
    end
  end

  describe 'PUT #update' do
    let(:product) { create(:product) }

    before do
      request.headers.merge!(valid_headers)

      put :update, params: {
        id: product.id,
        product: {
          name: product.name,
          price: product.price,
          cost: product.cost,
          quantity: product.quantity,
          inventory: product.inventory

        }
      }
    end

    context 'when is successfully updated' do
      it 'should be valid product' do
        expect(product).to be_valid
      end

      it 'should be update product' do
        expect(response).to have_http_status(:accepted)
      end

      it 'should be return a JSON with product data' do
        response_json = JSON.parse(response.body)

        expect(response_json['id']).to eq(product.id)
        expect(response_json['name']).to eq(product.name)
        expect(response_json['price']).to eq(product.price)
        expect(response_json['cost']).to eq(product.cost)
        expect(response_json['quantity']).to eq(product.quantity)
        expect(response_json['inventory']).to eq(product.inventory)
        expect(response_json['user_id']).to eq(product.user_id)
      end
    end

    context 'when is not successfully updated' do
      it 'should be not valid product' do
        product.user_id = nil
        product.valid?

        expect(product).to_not be_valid
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:product) { create(:product) }

    before do
      request.headers.merge!(valid_headers)

      delete :destroy, params: { id: product.id }
    end

    context 'when is successfully destroyed' do
      it 'should be destroy product' do
        expect(response).to have_http_status(:accepted)
      end

      it 'should be return a JSON message' do
        expect(JSON.parse(response.body)['message']).to eq('Product destroyed successfully.')
      end
    end

    context 'when is not successfully destroyed' do
      it 'should be a invalid product' do
        product.user_id = nil
        product.valid?

        expect(product).to_not be_valid
      end
    end
  end
end

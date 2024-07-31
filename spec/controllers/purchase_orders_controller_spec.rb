require 'rails_helper'

RSpec.describe PurchaseOrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:secret_key) { '<%= ENV["JWT_SECRET"] %>' }
  let(:valid_token) { JWT.encode({ user_id: user.id }, secret_key) }
  let(:valid_headers) { { 'Authorization' => "Bearer #{valid_token}" } }
  let(:invalid_headers) { { 'Authorization' => 'Bearer invalid_token' } }

  describe 'POST #create' do
    let(:purchase_order) { create(:purchase_order) }

    before do
      request.headers.merge!(valid_headers)

      post :create, params: {
        user_id: purchase_order.user_id,
        customer_id: purchase_order.customer_id,
        product_id: purchase_order.product_id,
        quantity: purchase_order.quantity,
        description: purchase_order.description
      }
    end

    context 'when is sucessfully created' do
      it 'should be valid purchase_order' do
        expect(purchase_order).to be_valid
      end

      it 'should be create purchase_order' do
        expect(response).to have_http_status(:created)
      end

      it 'should be pass a customer_id param' do
        expect(request.params[:customer_id]).to eq(purchase_order.customer_id.to_s)
      end
    end

    context 'when is not successfully returned' do
      it 'should not be valid purchase_order' do
        purchase_order.customer_id = nil
        purchase_order.valid?

        expect(purchase_order).to_not be_valid
      end
    end
  end

  describe 'PUT #update' do
    let(:purchase_order) { create(:purchase_order) }

    before do
      request.headers.merge!(valid_headers)

      put :update, params: {
        customer_id: purchase_order.customer_id,
        id: purchase_order.id,
        purchase_order: {
          user_id: purchase_order.user_id,
          quantity: purchase_order.quantity,
          description: purchase_order.description,
          product_id: purchase_order.product_id
        }
      }
    end

    context 'when is successfully updated' do
      it 'should be valid purchase_order' do
        expect(purchase_order).to be_valid
      end

      it 'should be update purchase_order' do
        expect(response).to have_http_status(:accepted)
      end

      it 'should be return a JSON with product data' do
        response_json = JSON.parse(response.body)

        expect(response_json['id']).to eq(purchase_order.id)
        expect(response_json['user_id']).to eq(purchase_order.user_id)
        expect(response_json['customer_id']).to eq(purchase_order.customer_id)
        expect(response_json['product_id']).to eq(purchase_order.product_id)
        expect(response_json['quantity']).to eq(purchase_order.quantity)
        expect(response_json['description']).to eq(purchase_order.description)
      end
    end

    context 'when is not successfully updated' do
      it 'should be not valid purchase_order' do
        purchase_order.customer_id = nil

        expect(purchase_order).to_not be_valid
      end
    end
  end
end

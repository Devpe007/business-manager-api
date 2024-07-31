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
end

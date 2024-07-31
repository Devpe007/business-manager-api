require 'rails_helper'

RSpec.describe PurchaseOrder, type: :model do
  let(:purchase_order) { create(:purchase_order) }

  describe 'validate purchase order quantity' do
    context 'when is a valid quantity' do
      it 'should be valid' do
        expect(purchase_order).to be_valid
      end

      it 'should be a integer type' do
        expect(purchase_order.quantity).to be_a(Integer)
      end
    end

    context 'when is a invalid quantity' do
      it 'should not be valid' do
        purchase_order.customer_id = nil

        expect(purchase_order).to_not be_valid
      end
    end
  end

  describe 'validate purchase_order description' do
    context 'when is a valid description' do
      it 'should be valid' do
        expect(purchase_order).to be_valid
      end
    end

    context 'when is a invalid description' do
      it 'should not be valid' do
        purchase_order.customer_id = nil

        expect(purchase_order).to_not be_valid
      end
    end
  end
end

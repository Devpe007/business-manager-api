require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { create :product }

  describe 'validate product name' do
    context 'when is a valid name' do
      it 'should be valid' do
        expect(subject).to be_valid
      end
    end

    context 'when is a invalid name' do
      it 'should not be valid' do
        subject.name = nil

        expect(subject).to_not be_valid
      end

      it 'should be return can not be blank' do
        subject.name = nil
        subject.valid?

        expect(subject.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe 'validate product price' do
    context 'when is a valid price' do
      it 'should be valid' do
        expect(subject).to be_valid
      end

      it 'should be a number' do
        expect(subject.price).to be_a(Integer)
      end
    end

    context 'when is a invalid price' do
      it 'should be invalid price' do
        subject.price = nil

        expect(subject).to_not be_valid
      end

      it 'should be return can not be blank' do
        subject.price = nil
        subject.valid?

        expect(subject.errors[:price]).to include("can't be blank")
      end
    end
  end

  describe 'validate product cost' do
    context 'when is a valid cost' do
      it 'should be valid' do
        expect(subject).to be_valid
      end

      it 'should be a number' do
        expect(subject.cost).to be_a(Integer)
      end
    end
  end

  describe 'validate product quantity' do
    context 'when is a valid quantity' do
      it 'should be valid' do
        expect(subject).to be_valid
      end

      it 'should be a number' do
        expect(subject.cost).to be_a(Integer)
      end
    end
  end

  describe 'validate product inventory' do
    context 'when is a valid inventory' do
      it 'should be valid' do
        expect(subject).to be_valid
      end

      it 'should be false' do
        subject.inventory = false

        expect(subject.inventory).to be(false)
      end

      it 'should be true' do
        expect(subject.inventory).to be(true)
      end
    end

    context 'when is a invalid inventory' do
      it 'should be a invalid inventory' do
        subject.inventory = nil

        expect(subject).to_not be_valid
      end

      it 'should be return can not be blank' do
        subject.inventory = nil
        subject.valid?

        expect(subject.errors[:inventory]).to include("can't be blank")
      end
    end
  end
end

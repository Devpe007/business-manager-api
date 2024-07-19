require 'rails_helper'

RSpec.describe Customer, type: :model do
  subject { create :customer }

  describe 'validate customer name' do
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

  describe 'validate customer email' do
    context 'when is a valid email' do
      it 'should be valid' do
        expect(subject).to be_valid
      end
    end

    context 'when is a invalid email' do
      it 'should not be valid' do
        subject.email = nil

        expect(subject).to_not be_valid
      end

      it 'should be return can not be blank' do
        subject.email = nil
        subject.valid?

        expect(subject.errors['email']).to include("can't be blank")
      end
    end
  end

  describe 'validate customer mobile number' do
    context 'when is a valid mobile number' do
      it 'should be valid' do
        expect(subject).to be_valid
      end
    end
  end

  describe 'validate customer user_id' do
    context 'when user_id is passed' do
      it 'should be valid' do
        expect(subject).to be_valid
      end
    end

    context 'when user_id is not passed' do
      it 'should be not valid' do
        subject.user_id = nil

        expect(subject).to_not be_valid
      end

      it 'should be return can not be blank' do
        subject.user_id = nil
        subject.valid?

        expect(subject.errors['user_id']).to include("can't be blank")
      end
    end
  end

  describe 'validate customer address' do
    context 'when is a valid address' do
      it 'should be valid' do
        expect(subject).to be_valid
      end
    end
  end

  describe 'validate customer description' do
    context 'when is a valid description' do
      it 'should be valid' do
        expect(subject).to be_valid
      end
    end
  end
end

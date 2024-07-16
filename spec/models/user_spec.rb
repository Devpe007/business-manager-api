require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user }

  context 'validate user name' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'should not be valid' do
      subject.name = nil

      expect(subject).to_not be_valid
    end

    it 'return can not be blank' do
      subject.name = nil
      subject.valid?

      expect(subject.errors[:name]).to include("can't be blank")
    end
  end

  context 'validade user email' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'should not be valid' do
      subject.email = nil

      expect(subject).to_not be_valid
    end

    it 'return can not be blank' do
      subject.email = nil
      subject.valid?

      expect(subject.errors[:email]).to include("can't be blank")
    end
  end

  context 'validate user password' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'should be not valid' do
      subject.password = nil

      expect(subject).to_not be_valid
    end

    it 'return can not be blank' do
      subject.password = nil
      subject.valid?

      expect(subject.errors[:password]).to include("can't be blank")
    end
  end
end

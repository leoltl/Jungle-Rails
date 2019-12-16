require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations ' do
    subject { 
      described_class.new(email: 'leo@email', password: '123456789', password_confirmation: '123456789', first_name: 'leo', last_name: 'lee') 
    }

    it "is valid with valid attributes" do
      subject.save
      expect(subject).to be_valid
    end

    it "is not valid when password not match" do
      subject.password_confirmation = '12'
      subject.save
      expect(subject.errors.full_messages[0]).to eq "Password confirmation doesn't match Password"
    end

    it "is not valid with duplicate email" do
      duplicateUser = User.create(email: 'leo@email', password: '123456789', password_confirmation: '123456789', first_name: 'leo', last_name: 'lee')
      subject.save
      expect(subject.errors.full_messages[0]).to eq "Email has already been taken"
    end

    it "is not valid without a email" do
      subject.email = nil
      subject.save
      expect(subject.errors.full_messages[0]).to eq "Email can't be blank"
    end
    
    it "is not valid without a first name" do
      subject.first_name = nil
      subject.save
      expect(subject.errors.full_messages[0]).to eq "First name can't be blank"

    end

    it "is not valid without a last name" do
      subject.last_name = nil
      subject.save
      expect(subject.errors.full_messages[0]).to eq "Last name can't be blank"
    end

    it "is not valid when password is shorter than 8 character" do
      subject.password = '123'
      subject.password_confirmation = '123'
      subject.save
      expect(subject.errors.full_messages[0]).to eq "Password is too short (minimum is 8 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) { 
      @user = User.new(email: 'leo@email', password: '123456789', password_confirmation: '123456789', first_name: 'leo', last_name: 'lee')
    }
    it 'should return user object if correct password is passed in' do
      @user.save
      user = User.authenticate_with_credentials('leo@email', '123456789')
      expect(user).to eq(@user)
    end

    it 'should return nil if incorrect credentials is passed in' do
      @user.save
      user = User.authenticate_with_credentials('leo@email', '1234567')
      expect(user).to eq(nil)
    end

    it 'should return nil if incorrect credentials is passed in' do
      @user.save
      user = User.authenticate_with_credentials('invalid@email.com', '123456789')
      expect(user).to eq(nil)
    end

    it 'should successfully log user in even if extra space is passed in email' do
      @user.save
      user = User.authenticate_with_credentials(' leo@email  ', 123456789)
      expect(user).to eq(@user)
    end

    it 'should successfully log user in with case insensetive email' do
      @user.save
      user = User.authenticate_with_credentials(' lEo@email  ', 123456789)
      expect(user).to eq(@user)
    end
  
  end

end

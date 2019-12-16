require 'rails_helper'

RSpec.describe Product, type: :model do
  
  before(:each) do
    @category = Category.new(name: 'test')
  end

  subject {
    described_class.create(category: @category, name: 'test', price: 50, quantity: 30)
  }
  
  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to_not be_empty
    end
    it "is not valid without a price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to_not be_empty
    end
    it "is not valid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to_not be_empty
    end
    it "is not valid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to_not be_empty
    end
  end
end

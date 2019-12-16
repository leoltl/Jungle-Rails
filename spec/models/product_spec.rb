require 'rails_helper'

RSpec.describe Product, type: :model do
  
  before(:each) do
    @category = Category.new(name: 'test')
  end
  
  describe 'Validations' do
    it "is valid with valid attributes" do
      product = Product.create(category: @category, name: 'test', price: 50, quantity: 30)
      expect(product).to be_valid
    end
    it "is not valid without a name" do
      product = Product.create(category: @category, price: 50, quantity: 30)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to_not be_empty
    end
    it "is not valid without a price" do
      product = Product.create(category: @category, name: 'test', quantity: 30)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to_not be_empty
    end
    it "is not valid without a quantity" do
      product = Product.create(category: @category, name: 'test', price: 50)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to_not be_empty
    end
    it "is not valid without a category" do
      product = Product.create(name: 'test', price: 50, quantity: 30)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to_not be_empty
    end
  end
end

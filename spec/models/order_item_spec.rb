require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  # Associations
  describe "Associations" do
    it { should belong_to(:order) }
  end

  # Validations
  let(:order) { FactoryBot.create(:order) }
  let(:sku) { 'AAA' }
  let(:price) { 5.00 }
  let(:quantity) { 1 }
  let(:order_item) do
    OrderItem.new(
      order: order,
      sku: sku,
      price: price,
      quantity: quantity,
    )
  end

  it "is valid with valid attributes" do
    expect(order_item).to be_valid
  end

  context 'when sku is nil' do
    let(:sku) { nil }
    it "is not valid" do
      expect(order_item).to_not be_valid
    end
  end

  context 'when price is nil' do
    let(:price) { nil }
    it "is not valid" do
      expect(order_item).to_not be_valid
    end
  end

  context 'when quantity is nil' do
    let(:quantity) { nil }
    it "is not valid" do
      expect(order_item).to_not be_valid
    end
  end
end

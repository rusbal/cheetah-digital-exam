require 'rails_helper'

RSpec.describe Order, type: :model do
  # Associations
  describe "Associations" do
    it { should belong_to(:guest) }
    it { should have_many(:order_items) }
  end

  # Validations
  let(:guest) { FactoryBot.create(:guest) }
  let(:store_id) { 'CADE3B168C' }
  let(:transaction_id) { '5AA3C3C7094AF3949E7D' }
  let(:timestamp) { '2021-09-21T08:38:12.830Z' }
  let(:discount) { 2.0 }
  let(:points) { 10 }
  let(:order) do
    Order.new(
      guest: guest,
      store_id: store_id,
      transaction_id: transaction_id,
      timestamp: timestamp,
      discount: discount,
      points: points,
    )
  end

  it "is valid with valid attributes" do
    expect(order).to be_valid
  end

  context "when store_id is nil" do
    let(:store_id) { nil }
    it "is not valid" do
      expect(order).to_not be_valid
    end
  end

  context "when transaction_id is nil" do
    let(:transaction_id) { nil }
    it "is not valid" do
      expect(order).to_not be_valid
    end
  end

  context "when timestamp is nil" do
    let(:timestamp) { nil }
    it "is not valid" do
      expect(order).to_not be_valid
    end
  end

  context "when discount is nil" do
    let(:discount) { nil }
    it "is not valid" do
      expect(order).to_not be_valid
    end
  end

  context "when points is nil" do
    let(:points) { nil }
    it "is not valid" do
      expect(order).to_not be_valid
    end
  end
end

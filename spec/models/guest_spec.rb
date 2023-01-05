require 'rails_helper'

RSpec.describe Guest, type: :model do
  # Associations
  describe "Associations" do
    it { should have_many(:orders) }
  end

  # Validations
  it "is valid with valid attributes" do
    expect(Guest.new(string_id: '54D0D284B0')).to be_valid
  end

  it "is not valid without a string_id" do
    expect(Guest.new(string_id: nil)).to_not be_valid
  end
end

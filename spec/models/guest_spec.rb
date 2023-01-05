require 'rails_helper'

RSpec.describe Guest, type: :model do
  # Associations
  describe "Associations" do
    it { should have_many(:orders) }
  end

  # Validations
  let(:string_id) { '54D0D284B0' }
  let(:first_name) { Faker::Name.first_name }
  let(:last_name) { Faker::Name.last_name }
  let(:guest) do
    Guest.new(
      string_id: string_id,
      first_name: first_name,
      last_name: last_name,
    )
  end

  it "is valid with valid attributes" do
    expect(guest).to be_valid
  end

  context 'when string_id is nil' do
    let(:string_id) { nil }
    it "is not valid" do
      expect(guest).to_not be_valid
    end
  end

  context 'when first_name is nil' do
    let(:first_name) { nil }
    it "is not valid" do
      expect(guest).to_not be_valid
    end
  end

  context 'when last_name is nil' do
    let(:last_name) { nil }
    it "is not valid" do
      expect(guest).to_not be_valid
    end
  end
end

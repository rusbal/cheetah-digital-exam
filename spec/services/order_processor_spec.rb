require 'rails_helper'

describe OrderProcessor do
  let(:inputs) { {} }
  let(:outcome) { described_class.run(inputs) }
  let(:outcome!) { described_class.run!(inputs) }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }

  it 'type checks' do
    expect(outcome).to_not be_valid
    expect(errors[:timestamp]).to include 'is required'
    expect(errors[:store_id]).to include 'is required'
    expect(errors[:guest_id]).to include 'is required'
    expect(errors[:transaction_id]).to include 'is required'
    expect(errors[:items]).to include 'is required'
  end

  it 'type checks!' do
    expect { outcome! }.to raise_error ActiveInteraction::InvalidInteractionError
  end

  it 'validates!' do
    inputs[:string] = ''
    expect { outcome! }.to raise_error ActiveInteraction::InvalidInteractionError
  end

  context 'with valid input' do
    let(:inputs) do
      {
        timestamp: "2021-09-21T08:38:12.830Z",
        store_id: "CADE3B168C",
        guest_id: "54D0D284B0",
        transaction_id: "5AA3C3C7094AF3949E7D",
        items: [
          {
            sku: "AAA",
            price: 5.00,
            quantity: 1
          },
          {
            sku: "BBB",
            price: 8.00,
            quantity: 1
          }
        ]
      }
    end
    let(:expected) do
      {
        :subtotal=>"10.40",
        :discount=>"2.60",
        :points=>20,
        :message=>"Thank you, GuestFirstName GuestLastName!"
      }
    end

    it 'executes' do
      expect(outcome).to be_valid
      expect(result).to eql expected
    end

    it 'executes!' do
      expect { outcome! }.to_not raise_error
      expect(outcome!).to eql expected
    end
  end
end

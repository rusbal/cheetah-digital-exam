require 'rails_helper'

describe OrderDiscountCalculator do
  let(:inputs) { {} }
  let(:outcome) { described_class.run(inputs) }
  let(:outcome!) { described_class.run!(inputs) }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }

  it 'type checks' do
    expect(outcome).to_not be_valid
    expect(errors[:items]).to include 'is required'
  end

  it 'validates!' do
    expect { outcome! }.to raise_error ActiveInteraction::InvalidInteractionError
  end

  context 'with valid input' do
    let(:inputs) do
      {
        timestamp: "2021-09-21T08:38:12.830Z",
        store_id: "CADE3B168C",
        guest_id: "54D0D284B0",
        transaction_id: "5AA3C3C7094AF3949E7D",
        items: items,
      }
    end
    let(:total) do
      items.sum { |x| x[:price] * x[:quantity] }
    end
    let(:subtotal) { total - discount }
    let(:discount) { 0.00 }
    let(:points) { (2 * subtotal).floor }

    context 'total at least 10 USD' do
      let(:discount) { total * 0.20 }
      let(:items) do
        [
          {
            sku: "AAA",
            price: 5.00,
            quantity: 1,
          },
          {
            sku: "BBB",
            price: 8.00,
            quantity: 1,
          },
        ]
      end

      it 'executes' do
        expect(outcome).to be_valid
        expect(result).to eql discount
      end
    end

    context 'total less than 10 USD' do
      let(:items) do
        [
          {
            sku: "AAA",
            price: 4.00,
            quantity: 2,
          },
        ]
      end

      it 'executes' do
        expect(outcome).to be_valid
        expect(result).to eql discount
      end
    end

    context 'purchase contains sku CCC' do
      let(:discount) { 2.0 }
      let(:items) do
        [
          {
            sku: "CCC",
            price: 4.00,
            quantity: 1,
          },
        ]
      end

      it 'executes' do
        expect(outcome).to be_valid
        expect(result).to eql discount
      end

      context 'total at least 10 USD' do
        let(:items) do
          [
            {
              sku: "CCC",
              price: 10.00,
              quantity: 1,
            },
          ]
        end

        it 'executes' do
          expect(outcome).to be_valid
          expect(result).to eql discount
        end
      end
    end
  end
end

require 'rails_helper'

describe 'Orders API', type: :request do
  let(:first_name) { 'Peter' }
  let(:last_name) { 'Goodyear' }
  let(:expected) do
    {
      'subtotal' => '10.40',
      'discount' => '2.60',
      'points' => 20,
      'message' => "Thank you, #{first_name} #{last_name}!",
    }
  end

  before do
    FactoryBot.create(:guest, string_id: '54D0D284B0', first_name: first_name, last_name: last_name)
  end

  it 'creates an order' do
    post '/api/v1/orders', params: {
      timestamp: '2021-09-21T08:38:12.830Z',
      store_id: 'CADE3B168C',
      guest_id: '54D0D284B0',
      transaction_id: '5AA3C3C7094AF3949E7D',
      items: [
        {
          sku: "AAA",
          price: 5.00,
          quantity: 1,
        },
        {
          sku: "BBB",
          price: 8.00,
          quantity: 1
        }
      ]
    }

    expect(response).to have_http_status(:success)
    parsed_body = JSON.parse(response.body)
    expect(parsed_body).to eq expected
  end
end

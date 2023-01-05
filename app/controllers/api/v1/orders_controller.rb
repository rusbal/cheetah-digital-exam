module Api
  module V1
    class OrdersController < ApplicationController
      def create
        @order = OrderProcessor.run!(create_params)
      end

      private

      def create_params
        params.permit(
          :guest_id,
          :store_id,
          :timestamp,
          :transaction_id,
          { :items => [ :sku, :price, :quantity ] }
        )
      end
    end
  end
end

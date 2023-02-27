module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authentication

      def create
        @order = OrderProcessor.run!(create_params)
      rescue ActiveInteraction::InvalidInteractionError => e
        render_422(e.message)
      end

      private

      # Task 1. accepts an API payload (See "Request Payload")
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

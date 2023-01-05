# Task 5. returns an API response (See "Response Payload")
json.subtotal sprintf('%.2f', @order.subtotal)
json.discount sprintf('%.2f', @order.discount)
json.points @order.points
json.message "Thank you, #{@order.guest.first_name} #{@order.guest.last_name}!"

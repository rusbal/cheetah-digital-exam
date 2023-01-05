# Loyalty Exam by Raymond Usbal
raymond@philippinedev.com

# Models
## Order
1.  `guest_id` - Foreign key for Guest table (`1`)
2.  `timestamp` - From request (`2021-09-21T08:38:12.830Z`)
3.  `store_id` - From request (`CADE3B168C`)
4.  `transaction_id` - From request (`5AA3C3C7094AF3949E7D`)
5.  `discount` - Computed value (`2.60`)
6.  `points` - Computed value (`20`)

## OrderItem
1.  `sku` - From request (`AAA`)
2.  `price` - From request (`5.00`)
3.  `quantity` - From request (`1`)

## Guest
1. string_id - From request (`54D0D284B0`)
2. first_name - Generated fake first name
3. last_name - Generated fake last name

# Service Objects
1.  `OrderProcessor` - Creates order, order items. For testing purposes it also creates fake Guest if it does not exist. For production, Guests should already exists before this API endpoint is invoked.
2.  `OrderDiscountCalculator` - This is invoked from `OrderProcessor` and returns the applicable discount based on the discount logic.

# How to test?
```bash
# Install the app
bundle install
rails db:setup

# Run the specs
rspec
...........................

Finished in 1.1 seconds (files took 3.05 seconds to load) 27 examples, 0 failures
```

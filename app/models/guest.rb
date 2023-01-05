class Guest < ApplicationRecord
  validates :string_id, presence: true

  has_many :orders
end

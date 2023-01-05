class Guest < ApplicationRecord
  has_many :orders

  validates :string_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end

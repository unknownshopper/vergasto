class Transaction < ApplicationRecord
  has_one_attached :image
  validates :full_name, presence: true
  validates :amount, presence: true, numericality: true
end

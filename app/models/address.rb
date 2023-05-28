class Address < ApplicationRecord
	validates :address_line_one, :city, :state, :country, presence: true
	
	validates :mobile_number, format: { with: /\A\d{10}\z/, message: "must be a 10-digit number" }
	belongs_to :user
end

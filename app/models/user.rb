class User < ApplicationRecord
	has_secure_password
	validates :name, presence: true
	validates :email, uniqueness: { message: "is already taken" }
	validates :password, presence: true, length: { minimum: 6 }

	has_one :address
	has_many :send_parcels, foreign_key: :sender_id, class_name: 'Parcel'
	has_many :received_parcels, foreign_key: :receiver_id, class_name: 'Parcel'

	accepts_nested_attributes_for :address


	def name_with_address
		@name_with_address ||= [name, address.address_line_one, address.city, address.state, address.country, address.pincode].join('-')
	end
end

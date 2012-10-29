class UserInformation < ActiveRecord::Base
  belongs_to :user
  attr_accessible :address, :company, :country, :name, :phone, :street, :user_id, :zip
end

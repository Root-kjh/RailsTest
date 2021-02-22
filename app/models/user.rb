class User < ApplicationRecord
    has_many :projects, dependent: :destroy
    validates_uniqueness_of :email
    validates :firstName, :lastName , presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } , presence: true
    
    has_secure_password
end

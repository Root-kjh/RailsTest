class User < ApplicationRecord
    has_many :projects, dependent: :destroy
    validates_uniqueness_of :email
    validates :firstName, :lastName, :email, presence: true
    
    has_secure_password
end

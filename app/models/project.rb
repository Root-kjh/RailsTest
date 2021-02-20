class Project < ApplicationRecord
    belongs_to :user
    has_many :contents, dependent: :destroy
    validates :title, :type, :location, :thumbnail, presence: true
end

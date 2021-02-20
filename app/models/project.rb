class Project < ApplicationRecord
    belongs_to :user
    has_many :contents, dependent: :destroy

    mount_uploader :thumbnail, ThumbnailUploader 

    validates :title, :projectType, :location, :thumbnail, presence: true
end

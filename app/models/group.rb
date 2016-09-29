class Group < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  validates :icon, allow_blank: true, image_path: true
end

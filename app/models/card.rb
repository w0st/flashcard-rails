class Card < ApplicationRecord
  belongs_to :group
  validates :front, presence: true
  validates :back, presence: true
  validates :picture, allow_blank: true, image_path: true
end

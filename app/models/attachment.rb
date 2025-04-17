class Attachment < ApplicationRecord
  belongs_to :project

  has_one_attached :file

  validates :name, presence: true
  validates :file, presence: true
end

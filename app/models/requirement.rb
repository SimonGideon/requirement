class Requirement < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  validates :description, presence: true

  enum :priority, [ :low, :medium, :high, :critical ]
  enum :category, [ :functional, :non_functional, :technical, :business, :ux ]
end

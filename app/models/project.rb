class Project < ApplicationRecord
  belongs_to :client
  has_many :requirements, dependent: :destroy
  has_many :attachments, dependent: :destroy
  accepts_nested_attributes_for :requirements, allow_destroy: true
  
  validates :title, presence: true
  validates :description, presence: true
  
  enum :status, [:draft, :active, :submitted, :in_review, :approved, :in_progress, :completed]

  def self.status_options
    statuses.keys.map { |status| [status.humanize, status] }
  end
end
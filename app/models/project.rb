class Project < ApplicationRecord
  belongs_to :client
  has_many :requirements, dependent: :destroy
  has_many :attachments, dependent: :destroy
  has_one_attached :requirements_document
  accepts_nested_attributes_for :requirements, allow_destroy: true

  validates :title, presence: true
  validates :description, presence: true
  validates :desired_completion_date, presence: true
  validates :status, presence: true

  enum :status, { draft: 0, active: 1, completed: 2, cancelled: 3 }, prefix: true

  def self.status_options
    statuses.map { |status, value| [ status.to_s.humanize, value ] }
  end

  def requirements_document_url
    requirements_document.attached? ? Rails.application.routes.url_helpers.rails_blob_path(requirements_document, only_path: true) : nil
  end
end

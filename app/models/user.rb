class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         authentication_keys: [:business_name]

  enum :role, { client: 0, admin: 1 }, prefix: true, default: :client

  SECURITY_QUESTIONS = [
    "What was your first pet's name?",
    "What is your mother's maiden name?",
    "What was the name of your first school?",
    "What city were you born in?",
    "What is your favorite book?",
    "What was your childhood nickname?",
    "What is the name of your favorite teacher?",
    "What is your favorite movie?"
  ].freeze

  belongs_to :client, optional: true
  has_many :projects, through: :client
  has_many :requirements, through: :projects

  validates :business_name, presence: true, uniqueness: true
  validates :security_question, presence: true, inclusion: { in: SECURITY_QUESTIONS }
  validates :security_answer, presence: true
  validates :role, presence: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\+?[\d\s-]+\z/, message: "must be a valid phone number" }

  # Override Devise methods to use business_name instead of email
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  # Methods
  def admin?
    role_admin?
  end

  def client?
    role_client?
  end

  # Custom authentication methods
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if business_name = conditions.delete(:business_name)
      where(conditions.to_h).where(["lower(business_name) = :value", { value: business_name.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  def role_admin?
    role == 'admin'
  end

  def role_client?
    role == 'client'
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parts = full_name.split(' ', 2)
    self.first_name = parts[0]
    self.last_name = parts[1] if parts.size > 1
  end
end

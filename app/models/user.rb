# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :listings, dependent: :destroy, inverse_of: :user

  validates :email, presence: true, uniqueness: true
  validates :is_proprietor, :is_occupant, inclusion: { in: [true, false] }

  validate :either_proprietor_or_occupant
  validate :password_matcher

  before_save :normalize_email_attr
  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d]).{8,}\z/

  def normalize_email_attr
    self.email = email.downcase if email
  end

  private

  def password_matcher
    return if password.match(PASSWORD_REGEX)

    errors.add(:password, 'must include at least one lowercase letter,one uppercase letter,one digit,and one special character.')
  end

  def either_proprietor_or_occupant
    return if is_proprietor ^ is_occupant

    errors.add(:base, 'User must either be a proprietor or an occupant.')
  end
end

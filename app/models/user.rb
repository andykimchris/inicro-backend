# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :listings, dependent: :destroy, inverse_of: :user
  has_many :unit_wishlists # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :units, through: :unit_wishlists

  validates :email, presence: true, uniqueness: true
  validates :is_proprietor, :is_occupant, inclusion: { in: [true, false] }

  validate :either_proprietor_or_occupant
  validate :password_matcher

  normalizes :email, with: ->(email) { email.strip.downcase }

  private

  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d]).{8,}\z/

  def send_devise_notification(notification, *)
    devise_mailer.send(notification, self, *).deliver_later
  end

  def password_matcher
    return if password.match(PASSWORD_REGEX)

    errors.add(:password, 'must include at least one lowercase letter,one uppercase letter,one digit,and one special character.')
  end

  # FIXME: not the case anymore with internal users(admin + support)
  def either_proprietor_or_occupant
    return if is_proprietor ^ is_occupant

    errors.add(:base, 'User must either be a proprietor or an occupant.')
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

 devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
        :omniauthable,
        :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist


  validates :email, presence: :true, uniqueness: :true
  validate :password_matcher

  PASSWORD_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z\d]).{8,}\z/

  private

  def password_matcher
    unless password.match(PASSWORD_REGEX)
      errors.add(:password, "must include at least one lowercase letter, one uppercase letter, one digit, and one special character.")
    end
  end


end


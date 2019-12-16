class User < ActiveRecord::Base
  has_secure_password
  validates :password, length: {minimum: 8}
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  before_save :downcase_email

  def self.authenticate_with_credentials (email, password)
    email = email.strip.downcase
    User.find_by(email: email).try(:authenticate, password) ?
    User.find_by(email: email).try(:authenticate, password) :
    nil
  end

  def downcase_email
    self.email.downcase
  end
end

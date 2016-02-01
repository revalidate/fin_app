class User < ActiveRecord::Base
  has_secure_password
  include FriendlyId
  friendly_id :last_name

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end  

  # validates_uniqueness_of :email

  validates :email, presence: true, uniqueness: true,
            format: { with: /[a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{3}/i,
            				message: 'format is invalid'}

  validates :password, length: { in: 6...255}
end

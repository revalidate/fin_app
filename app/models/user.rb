class User < ActiveRecord::Base
  has_secure_password
  include FriendlyId
  friendly_id :last_name

  has_many :user_mutual_funds
  has_many :mutual_funds, :through => :user_mutual_funds

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end  
  
  validates :email, presence: true, uniqueness: true,
            format: { with: /[a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{3}/i,
            				message: 'format is invalid'}

  validates :password, length: { in: 6...255}
end

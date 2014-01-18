class User < ActiveRecord::Base
  validates :q1, :q2, :q3, :masters, :last_name, :first_name, :presence => true
  validates :optin, :acceptance => { :accept => true }
  validates :email, :presence => true, :uniqueness => true, :format => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
end

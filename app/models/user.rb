class User < ActiveRecord::Base
  validates :q1, :q2, :q3, :masters, :last_name, :first_name, :presence => true
  validates :optin, :acceptance => { :accept => true }
end

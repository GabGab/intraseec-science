class User < ActiveRecord::Base
  validates :uid, :presence => true, :uniqueness => true
  validates :q1, :q2, :q3, :masters, :last_name, :first_name, :presence => true
  validates :optin, :acceptance => { :accept => true }
  validates :email, :presence => true, :uniqueness => true, :format => /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  CORRECT_ANSWERS = {
    :q1 => 0,
    :q2 => 2,
    :q3 => 1
  }

  def has_correct_answers?
    results = [:q1, :q2, :q3].map { |question| self.send(question).to_i == CORRECT_ANSWERS[question] }.uniq
    results.length == 1 && results.first
  end
end

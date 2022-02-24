class User < ApplicationRecord
    attr_accessor :remember_token
    has_secure_password

    # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
 #Returns a random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember a user in the database for use in persistent sessions.
  def Remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end   
end

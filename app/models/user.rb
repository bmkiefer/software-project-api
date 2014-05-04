class User < ActiveRecord::Base

before_save :ensure_authentication_token
 
 devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable,:confirmable, :lockable

has_many :relationships, foreign_key: "follower_id", dependent: :destroy
has_many :followed_users, through: :relationships, source: :followed
has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
has_many :followers, through: :reverse_relationships, source: :follower
has_many :polls
has_many :skipped_elements
has_many :voted_ons

def following?(other_user)
  relationships.find_by(followed_id: other_user.id)
end

def follow!(other_user)
  relationships.create!(followed_id: other_user.id)
end

def unfollow!(other_user)
  relationships.find_by(followed_id: other_user.id).destroy
end

def skip_confirmation!
  self.confirmed_at = Time.now
end

end

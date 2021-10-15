class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followings, class_name: 'Follow', foreign_key: 'recipient_id', dependent: :destroy
  has_many :followers, class_name: 'User', through: :followings, source: :user
  has_many :followed_users, class_name: 'User', through: :follows, source: :recipient 

  # Validations
  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 8, maximum: 30 }
  validate :password_complexity

  def password_complexity
    return if password.nil?

    errors.add :password, 'must include a special character' unless password&.match?(/[#?!@$%^&*-]/)
    errors.add :password, 'must include a capital character' unless password&.match?(/[A-Z]/)
    errors.add :password, 'must include a lowecase character' unless password&.match?(/[a-z]/)
  end

  def follow!(user)
    return if user == self
    follows.create(recipient: user)
  end

  def followed_posts
    Post.where(user: followed_users.push(self))
  end
end

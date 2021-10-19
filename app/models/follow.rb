class Follow < ApplicationRecord
  # ASSOCIATIONS

  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  # VALIDATIONS

  validates :user, uniqueness: { scope: :recipient, message: 'can not be followed twice' }
  validates :recipient
end

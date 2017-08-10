class Contact < ActiveRecord::Base
  # contact form validation
  validates :name, presence: true
  validates :email, presence: true
  validates :comments, presence: true
end
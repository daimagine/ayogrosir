class Contact < ActiveRecord::Base
  attr_accessible :email, :message, :name, :subject

  validates :email, presence: true
  validates :name, presence: true
  validates :message, presence: true
end

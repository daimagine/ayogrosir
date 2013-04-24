class Preference < ActiveRecord::Base
	include Timelinable
  attr_accessible :pref_value, :description, :name, :pref_key, :status

  validates :pref_value, presence: true
end

class Page < ActiveRecord::Base
  include Timelinable

  attr_accessible :content, :name, :page_view, :slug, :status

	validates :name, presence: true
	validates :content, presence: true
	validates :slug, presence: true

end

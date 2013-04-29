class Menu < ActiveRecord::Base
  attr_accessible :name, :parent_id, :sequence, :status, :url

  scope :sequenced, order('sequence ASC, name ASC')
	default_scope sequenced

	has_many 	:childs, 
							:dependent => :destroy, 
							:foreign_key => :parent_id,
							:order => "sequence",
							:class_name => "Menu"

  belongs_to :parent, :class_name => "Menu"
end

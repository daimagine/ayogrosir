class Menu < ActiveRecord::Base
  attr_accessible :name, :parent_id, :sequence, :status, :url

  scope :sequenced, order('sequence ASC, name ASC')
	default_scope sequenced

end

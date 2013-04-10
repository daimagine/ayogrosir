class Counter < ActiveRecord::Base
  attr_accessible :ip_address
  belongs_to :resource, :polymorphic => true
end

module Timelinable
  extend ActiveSupport::Concern

  # you can include other things here
  included do
    scope :active, where(:status => 'A')
    scope :latest, order('updated_at DESC')
    scope :newest, order('created_at DESC')
    scope :popular, order('page_view DESC')

    default_scope active
  end

  # include class methods here
  # like User.most_popular
  module ClassMethods
  end

  # include Instance methods
  # like @user.popularity
  module InstanceMethods
  end
end
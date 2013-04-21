class AdminController < ApplicationController
	layout 'admin/application'

	before_filter :authenticate_user!
end
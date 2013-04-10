class SearchStore < ActiveRecord::Base

	attr_accessible :market_id, :category_id, :keywords, :order_by
  
	def stores
		@stores ||= find_stores
	end

private

	def find_stores
		logger.info "Search Query"
		@stores = Store.find(:all, :joins => :categories, :conditions => conditions, :order => orders)
	end

	def market_conditions
		unless market_id.blank?
			["stores.market_id = ?", market_id]
		else
			["stores.market_id = ?", @current_market.id]
		end
	end

	def category_conditions
	  ["categories.id = ?", category_id] unless category_id.blank?
	end

	def keyword_conditions
  	["stores.name LIKE ?", "%#{keywords}%"] unless keywords.blank?
	end

	def generic_orders
		if !order_by.blank? && order_by.downcase == 'popular'
			["updated_at DESC"]
		elsif !order_by.blank? && order_by.downcase == 'name'
			["name ASC"]
		else
			["name ASC"]
		end
	end

	# do not modify this

	# order clauses

	def orders
		[orders_clauses.join(', '), *orders_options]
	end

	def orders_clauses
		orders_parts.map { |order| order.first }
	end

	def orders_options
		orders_parts.map { |order| order[1..-1] }.flatten
	end

	def orders_parts
		private_methods(false).grep(/_orders$/).map { |m| send(m) }.compact
	end

	#condition clauses

	def conditions
	  [conditions_clauses.join(' AND '), *conditions_options]
	end

	def conditions_clauses
	  conditions_parts.map { |condition| condition.first }
	end

	def conditions_options
	  conditions_parts.map { |condition| condition[1..-1] }.flatten
	end

	def conditions_parts
	  private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
	end

end

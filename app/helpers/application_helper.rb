module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end


  def to_slug(str)
    #strip the string
    ret = str.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
     ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

     #convert double underscores to single
     ret.gsub! /_+/,"_"

     #strip off leading/trailing underscore
     ret.gsub! /\A[_\.]+|[_\.]+\z/,""

     ret
  end

  def navigation_menus
    Proc.new do |primary|
      # dinamic menus
      logger.info "Render dinamic menus"
      @navigation.each  do |nav|
        render_nav_menu(primary, nav, true)
      end
    end
  end

  def render_nav_menu(proc, nav, first=false)
    logger.info "Add parent menu #{to_slug(nav.name)}"

    proc.dom_class = 'nav nav-pills'
    if nav.parent != true && !nav.url.eql?('#category')
      
      proc.item to_slug(nav.name), nav.name, nav.url

    else

      proc.item to_slug(nav.name), "#{nav.name}<b class='caret'></b>".html_safe, nav.url, 
        :class => 'dropdown',
        :link => {:class => 'dropdown-toggle', 'data-toggle' => 'dropdown'} do |sub_proc|

          sub_proc.dom_class = 'dropdown-menu'
          nav.childs.empty? && nav.childs.each do |sub_nav|
            #recursive
            logger.info "Add child menu #{to_slug(sub_nav.name)}"
            render_nav_menu(sub_proc, sub_nav)
          end

          if nav.url.eql?('#category')
            categories = Category.where(:cat_type => 'Store')
            categories.each do |c|
              logger.info "Add child menu #{to_slug(c.name)}"
              sub_proc.item to_slug(c.name), c.name, stores_path(:search_store => { :category_id => c.id })
            end
          end
        end
    end

    # logger.info "Menu : #{proc.to_yaml()}"
  end

end

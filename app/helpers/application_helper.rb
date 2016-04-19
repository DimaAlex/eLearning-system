module ApplicationHelper

  def active_page(active_page)
    @active == active_page ? "active" : ""
  end

  def active_list(active_page)
    active_page == "active_page" ? "active" : ""
  end
end

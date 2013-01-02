module ApplicationHelper

  def amount_to_currency(number, options = {})
    number_to_currency number.to_f / 100, options
  end

  def new_badge
    '<span class="label label-inverse">new</span>'.html_safe
  end
end

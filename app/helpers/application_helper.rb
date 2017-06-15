module ApplicationHelper

  def bool_to_text(attribute)
    attribute ? 'Да' : 'Нет'
  end
end

module DocumentsHelper

  def ellipsis(string)
    truncated_string = truncate(string, length: 80)
    content_tag(:td, truncated_string, title: string)
  end
end

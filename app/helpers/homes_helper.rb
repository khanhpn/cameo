module HomesHelper
  def show_category(categories)
    content_tag(:ul) do
      categories.each do |item|
        concat content_tag(:li, item.name)
      end
    end
  end

  def temporarilyUnavailable?(data)
    data ? "active" : "inactive"
  end
end

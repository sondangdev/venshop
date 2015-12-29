module CategoriesHelper
  def categories_for_select
    Category.all.pluck(:title, :id)
  end
end

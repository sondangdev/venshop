namespace :venshop do
  desc "Create categories"
  task create_categories: :environment do
    Category::CATEGORIES.each { |category, browse_node| Category.create(title: category) }
  end
end

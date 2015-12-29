namespace :venshop do
  desc "Create product categories"
  task categorize: :environment do
    Category::CATEGORIES.each { |category, browse_node| Category.create(title: category) }
  end
end

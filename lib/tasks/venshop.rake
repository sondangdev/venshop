namespace :venshop do
  desc "Create categories"
  task create_categories: :environment do
    Category::CATEGORIES.each do |category, browse_node|
      Category.create(title: category)
      puts "#{category} is created"
    end
  end

  desc "Update products from Amazon"
  task update_amazon: :environment do
    AmazonFetcher.new.update_amazon_products
  end
end

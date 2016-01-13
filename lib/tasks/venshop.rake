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

  desc "Update stock for product"
  task update_stock: :environment do
    products = Product.select { |p| p.stock <= 0 }
    products.each { |product| product.update(stock: rand(2..20)) }
  end
end

class AmazonFetcher
  def initialize()
    @request = Vacuum.new
    @request.configure(aws_access_key_id:     'AKIAIAJR65JO6EIPQWTA',
                       aws_secret_access_key: '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',
                       associate_tag:         'microv')
  end

  def update_amazon_products
    Category.all.each do |category|
      (1..10).each do |page|
        responses = @request.item_search(
          query: {
            "ItemPage" => page.to_s,
            "SearchIndex" => "Books",
            "BrowseNode" => Category::CATEGORIES[category.title],
            "ResponseGroup" => "Medium, Images, Offers, EditorialReview"
          }
        ).to_h

        responses = responses["ItemSearchResponse"]["Items"]["Item"]

        responses.each do |response|
          return "Complete fetching" if response == nil
          Product.find_or_create_by(item_id: response["ASIN"]) do |product|
            product.title = response["ItemAttributes"]["Title"]

            editorial_review = response["EditorialReviews"]["EditorialReview"]
            if editorial_review == nil
              product.description = "This product has no description yet"
            elsif editorial_review.is_a? Array
              product.description = editorial_review.first["Content"]
            else
              product.description = editorial_review["Content"]
            end

            product.price = response["ItemAttributes"]["ListPrice"] != nil ? response["ItemAttributes"]["ListPrice"]["Amount"].to_d / 100 : response["OfferSummary"]["LowestNewPrice"]["Amount"].to_d / 100
            product.category_id = category.id
            if response["LargeImage"] == nil
              product.remote_image_url = response["ImageSets"]["ImageSet"].is_a?(Array) ? response["ImageSets"]["ImageSet"].first["LargeImage"]["URL"] : response["ImageSets"]["ImageSet"]["LargeImage"]["URL"]
            else
              product.remote_image_url = response["LargeImage"]["URL"]
            end
            product.publiscation_date = response["ItemAttributes"]["PublicationDate"]
            product.manufacturer = response["ItemAttributes"]["Manufacturer"]
            puts "#{product.title} is fetched and updated successfully"
          end
        end
      end
    end
  end
end

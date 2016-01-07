## VENSHOP
#### by Son Dang

Please follow these steps after you setup database and before you run `rails server` 

```
rails g sunspot:install
rake venshop:create_categories
rake venshop:update_amazon
rake sunspot:solr:start
```

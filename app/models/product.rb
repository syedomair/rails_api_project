class Product < ActiveRecord::Base
  belongs_to :category, class_name: 'Category', foreign_key: 'categories_id', primary_key: 'id'
end

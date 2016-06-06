class Category < ActiveRecord::Base
  belongs_to :catalog, class_name: 'Catalog', foreign_key: 'catalogs_id', primary_key: 'id'
  has_many :product 
end

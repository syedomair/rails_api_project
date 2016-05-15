namespace :export do
  desc "Prints Catalog.all in a seeds.rb way."
  task :seeds_format => :environment do
    Catalog.order(:id).all.each do |catalog|
        puts "Catalog.create(#{catalog.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    Category.order(:id).all.each do |category|
        puts "Category.create(#{category.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    Product.order(:id).all.each do |product|
        puts "Product.create(#{product.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
  
end

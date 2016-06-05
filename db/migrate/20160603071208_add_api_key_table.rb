class AddApiKeyTable < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :company_name 
      t.string :status
      t.string :api_key 
    end
  end
end

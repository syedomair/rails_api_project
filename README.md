# rails_api_project

###Database Setup
Create a database and its user with the following lines

```SQL
mysql> create database project2;
mysql> GRANT ALL ON `project2`.* TO 'user'@'localhost' IDENTIFIED BY 'testpass';
```


### Download project
```bash
$ git clone https://github.com/syedomair/rails_api_project.git
```

### Setup database for the project
```bash
$ cd rails_api_project
$ rake db:schema:load
$ rake db:seed
```

### Start the project
Please run this project on port 3001 because the client application get connected through this port. 
```bash
$ rails s -p 3001
```

### A Quick Test
Open Postman application 
Set the URL as **GET  http://localhost:3001/api/public/products-featured**

Set the following headers:
*************
so_auth     custom_auth api_key="secret_key", access_type="secured", user_email="public_user", password="public_user"
*************
Content-Type     application/json
*************
Click Send
The output should be this:
```json
{
  "status": "success",
  "data": {
    "list": [
      {
        "id": 1,
        "catalog_name": "Test Catalog Name",
        "category_name": "Men",
        "name": "Men Shirts Dress Khaki",
        "sku": "EW239",
        "price": "46.99",
        "short_description": "The description for Men Shirt Dress Khaki",
        "image": "mens_shirts_dresscas_Dkhaki.gif",
        "featured": true
      },
      {
        "id": 2,
        "catalog_name": "Test Catalog Name",
        "category_name": "Men",
        "name": "Men Pants Dress",
        "sku": "FD320",
        "price": "45.99",
        "short_description": "The description for Men Pants Dress",
        "image": "mens_pants_dress.gif",
        "featured": true
      },
      {
        "id": 5,
        "catalog_name": "Test Catalog Name",
        "category_name": "Men",
        "name": "Men Shirts Dress Stone II",
        "sku": "TY332",
        "price": "67.99",
        "short_description": "The description for Men Shirts Dress Stone II",
        "image": "mens_shirts_dresscas_stone.gif",
        "featured": true
      },
      {
        "id": 6,
        "catalog_name": "Test Catalog Name",
        "category_name": "Women",
        "name": "Women Sleepwear",
        "sku": "BC198",
        "price": "21.99",
        "short_description": "The description for Women Sleepwear",
        "image": "womens_sleepwear_short_Iblue.gif",
        "featured": true
      },
      {
        "id": 8,
        "catalog_name": "Test Catalog Name",
        "category_name": "Women",
        "name": "Women Activewear Soccer",
        "sku": "PO193",
        "price": "23.99",
        "short_description": "The description for Women Activewear Soccer",
        "image": "womens_activewear_soccer_Ob.gif",
        "featured": true
      },
      {
        "id": 11,
        "catalog_name": "Test Catalog Name",
        "category_name": "Women",
        "name": "Women Accessories Belt Nav",
        "sku": "AU0023",
        "price": "11.99",
        "short_description": "The description for Women Accessories Belt Nav",
        "image": "womens_accessories_belt_nav.gif",
        "featured": true
      }
    ],
    "count": 6
  },
  "code": 200
}
```

# Products Endpoints

| HTTP Method | Endpoint                                | Description                                                           |
| ----------- | --------------------------------------- | --------------------------------------------------------------------- |
| GET         | /products                               | [Get all products](#get-all-products)                                 |
| GET         | /products?sortByPrice=<"asc" or "desc"> | [Get all products sorted by price](#get-all-products-sorted-by-price) |
| GET         | /products?sortByName=<"asc" or "desc">  | [Get all products sorted by name](#get-all-products-sorted-by-title)  |
| GET         | /products?offset=x&limit=x              | [Get all products with pagination](#get-all-products-with-pagination) |
| GET         | /products?top=x                         | [Get `x` most purchased products](#get-x-most-purchased-product)      |
| GET         | /products/:id                           | [Get a single product](#get-a-single-product)                         |
| POST        | /products                               | [Create a product](#create-a-product)                                 |
| PATCH       | /products/:id                           | [Update a product](#update-a-product)                                 |
| DELETE      | /products/:id                           | [Delete a product](#delete-a-product)                                 |

## Get All Products

You can access the list of all products by using the /products endpoint.

Request:

```
[GET] https://e-commerce.com/api/v1/products
```

Response:

```
[
  {
    "product_id": 4,
    "title": "Product 1",
    "price": 500,
    "description": "Description of Product 1",
    "category": {
      "category_id": 5,
      "name": "Category 1",
      "image": "https://placeimg.com/640/480/any?r=0.591926261873231"
    },
    "images": [
      "https://placeimg.com/640/480/any?r=0.9178516507833767",
      "https://placeimg.com/640/480/any?r=0.9300320592588625",
      "https://placeimg.com/640/480/any?r=0.8807778235430017"
    ],
    "reviews": [
      {
        "review_id": 1,
        "rating": 3,
        "content": "Review 1",
        "review_date": 01/01/2023 12:00:00 PM,
        "user": {
          "user_id": 1,
          "name": "User 1",
          "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
        }
      },
      {
        "review_id": 2,
        "rating": 4,
        "content": "Review 2",
        "review_date": 01/01/2023 12:50:00 PM,
        "user": {
          "user_id": 2,
          "name": "User 2",
          "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
        }
      }
    ]
  }
  // ...
]
```

| Status Code | Case    |
| ----------- | ------- |
| 200 OK      | Success |

## Get All Products Sorted By Price

By using the /products endpoint and passing `sortByPrice` as a query parameter with either `asc` or `desc` as value, you can sort the products by price ascending or descending.

Request:

```
[GET] https://e-commerce.com/api/v1/products?sortByPrice=<"asc" or "desc">
```

| Status Code     | Case                 |
| --------------- | -------------------- |
| 200 OK          | Success              |
| 400 Bad Request | Invalid sorting type |

## Get All Products Sorted By Title

By using the /products endpoint and passing `sortByTitle` as a query parameter with either `asc` or `desc` as value, you can sort the products by title ascending or descending.

Request:

```
[GET] https://e-commerce.com/api/v1/products?sortByTitle=<"asc" or "desc">
```

| Status Code     | Case                 |
| --------------- | -------------------- |
| 200 OK          | Success              |
| 400 Bad Request | Invalid sorting type |

## Get All Products With Pagination

To fetch the first page of entries in a collection, the API needs to be called with the offset set to 0 and the limit the products that you want in the response.

Request:

```
[GET] https://e-commerce.com/api/v1/products?offset=0&limit=10
```

Response:

```
[
  {
    "product_id": 4,
    "title": "Product 1",
    "price": 500,
    "description": "Description of Product 1",
    "category": {
      "category_id": 5,
      "name": "Category 1",
      "image": "https://placeimg.com/640/480/any?r=0.591926261873231"
    },
    "images": [
      "https://placeimg.com/640/480/any?r=0.9178516507833767",
      "https://placeimg.com/640/480/any?r=0.9300320592588625",
      "https://placeimg.com/640/480/any?r=0.8807778235430017"
    ],
    "reviews": [
      {
        "review_id": 1,
        "rating": 3,
        "content": "Review 1",
        "review_date": 01/01/2023 12:00:00 PM,
        "user": {
          "user_id": 1,
          "name": "User 1",
          "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
        }
      },
      {
        "review_id": 2,
        "rating": 4,
        "content": "Review 2",
        "review_date": 01/01/2023 12:50:00 PM,
        "user": {
          "user_id": 2,
          "name": "User 2",
          "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
        }
      }
    ]
  }
  // ... and 9 items more
]
```

To get the next page of entries, use an offset parameter equal to the sum of the previous offset value and the limit returned to the previous result, `previous_offset + previous_limit`.

```
[GET] https://e-commerce.com/api/v1/products?offset=10&limit=10
```

For example, for a pagination with 10 items per page, it looks like this:

| Request                      | Description                   |
| ---------------------------- | ----------------------------- |
| /products?offset=0&limit=10  | Return the first 10 products. |
| /products?offset=10&limit=10 | Return products from 10 to 20 |
| /products?offset=20&limit=10 | Return products from 20 to 30 |

Or for a pagination with 20 items per page, it looks like this:

| Request                      | Description                   |
| ---------------------------- | ----------------------------- |
| /products?offset=0&limit=20  | Return the first 20 products. |
| /products?offset=20&limit=20 | Return products from 20 to 40 |
| /products?offset=40&limit=20 | Return products from 40 to 60 |

| Status Code     | Case                        |
| --------------- | --------------------------- |
| 200 OK          | Success                     |
| 400 Bad Request | Invalid offset, limit value |

## Get `X` Most Purchased Product

By using the /products endpoint and passing `top` as a query parameter and a number `x` as a value, you can get the `x` most purchased products.

Request:

```
[GET] https://e-commerce.com/api/v1/products?top=5
```

Response:

```
[
  {
    "product_id": 4,
    "title": "Product 1",
    "price": 500,
    "description": "Description of Product 1",
    "category": {
      "category_id": 5,
      "name": "Category 1",
      "image": "https://placeimg.com/640/480/any?r=0.591926261873231"
    },
    "images": [
      "https://placeimg.com/640/480/any?r=0.9178516507833767",
      "https://placeimg.com/640/480/any?r=0.9300320592588625",
      "https://placeimg.com/640/480/any?r=0.8807778235430017"
    ],
    "reviews": [
      {
        "review_id": 1,
        "rating": 3,
        "content": "Review 1",
        "review_date": 01/01/2023 12:00:00 PM,
        "user": {
          "user_id": 1,
          "name": "User 1",
          "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
        }
      },
      {
        "review_id": 2,
        "rating": 4,
        "content": "Review 2",
        "review_date": 01/01/2023 12:50:00 PM,
        "user": {
          "user_id": 2,
          "name": "User 2",
          "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
        }
      }
    ]
  }
  // ... and 4 items more
]
```

| Status Code     | Case              |
| --------------- | ----------------- |
| 200 OK          | Success           |
| 400 Bad Request | Invalid top value |

## Get A Single Product

You can get a single product by adding the product ID as a parameter: `/products/:id`

Request:

```
[GET] https://e-commerce.com/api/v1/products/:id
```

Response:

```
{
  "product_id": 1,
  "title": "Product 1",
  "price": 500,
  "description": "Description of Product 1",
  "category": {
    "category_id": 5,
    "name": "Category 1",
    "image": "https://placeimg.com/640/480/any?r=0.591926261873231"
  },
  "images": [
    "https://placeimg.com/640/480/any?r=0.9178516507833767",
    "https://placeimg.com/640/480/any?r=0.9300320592588625",
    "https://placeimg.com/640/480/any?r=0.8807778235430017"
  ],
  "reviews": [
    {
      "review_id": 1,
      "rating": 3,
      "content": "Review 1",
      "review_date": 01/01/2023 12:00:00 PM,
      "user": {
        "user_id": 1,
        "name": "User 1",
        "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
      }
    },
    {
      "review_id": 2,
      "rating": 4,
      "content": "Review 2",
      "review_date": 01/01/2023 12:50:00 PM,
      "user": {
        "user_id": 2,
        "name": "User 2",
        "avatar": "https://placeimg.com/640/480/any?r=0.591926261873231",
      }
    }
  ]
}
```

| Status Code   | Case              |
| ------------- | ----------------- |
| 200 OK        | Success           |
| 404 Not Found | ID does not exist |

## Create a product

You can create a new product by sending an object in the body with shape like this to `/products`. And since only admins can modify the product collection, you need to also include a token in the header:

Request:

```
[POST] https://e-commerce.com/api/v1/products/

# Body
{
  "title": "New Product",
  "price": 40,
  "description": "A description",
  "categoryId": 1,
  "images": ["https://placeimg.com/640/480/any"]
}

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "product_id": 2,
  "title": "New Product",
  "price": 40,
  "description": "A description",
  "category": {
    "category_id": 1,
    "name": "Category 1",
    "image": "https://placeimg.com/640/480/any?r=0.591926261873231"
  },
  "images": ["https://placeimg.com/640/480/any"],
  "reviews": [],
}
```

| Status Code      | Case                                            |
| ---------------- | ----------------------------------------------- |
| 201 Created      | Success                                         |
| 400 Bad Request  | Part of request body missing, invalid image URL |
| 401 Unauthorized | Invalid token, no authorization token           |
| 403 Forbidden    | Token not belonging to admin                    |

## Update A Product

You can update product by sending an object in the body with shape like this to `/products/:id` (only properties and values that need to be updated) and adding the product ID as a parameter. And since only admins can modify the product collection, you need to also include a token in the header:

Request:

```
[PATCH] https://e-commerce.com/api/v1/products/:id

# Body
{
  "title": "Updated title",
  "price": 30,
  "description": "Updated description",
}

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "product_id": 1,
  "title": "Updated title",
  "price": 30,
  "description": "Updated description",
  "category": {
    "category_id": 1,
    "name": "Category 1",
    "image": "https://placeimg.com/640/480/any?r=0.591926261873231"
  },
  "images": ["https://placeimg.com/640/480/any"],
  "reviews": [],
}
```

| Status Code      | Case                                            |
| ---------------- | ----------------------------------------------- |
| 200 OK           | Success                                         |
| 400 Bad Request  | Part of request body missing, invalid image URL |
| 401 Unauthorized | Invalid token, no authorization token           |
| 403 Forbidden    | Token not belonging to admin                    |
| 404 Not Found    | ID does not exist                               |

## Delete A Product

You can delete a product by adding the product ID as a parameter: `/products/:id`. And since only admins can modify the product collection, you need to also include a token in the header:

```
[DELETE] https://e-commerce.com/api/v1/products/:id

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
true
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 200 OK           | Success                               |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |
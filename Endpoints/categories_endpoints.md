# Categories Endpoints

| HTTP Method | Endpoint                 | Description                                                   |
| ----------- | ------------------------ | ------------------------------------------------------------- |
| GET         | /categories              | [Get all categories](#get-all-categories)                     |
| GET         | /categories/:id          | [Get a single category](#get-a-single-category)               |
| GET         | /categories/:id/products | [Get all products by category](#get-all-products-by-category) |
| POST        | /categories              | [Create a category](#create-a-category)                       |
| PATCH       | /categories/:id          | [Update a category](#update-a-category)                       |
| DELETE      | /categories/:id          | [Delete a category](#delete-a-category)                       |

## Get All Categories

You can access the list of all categories by using the `/categories` endpoint.

Request:

```
[GET] https://e-commerce.com/api/v1/categories
```

Response:

```
[
  {
    "category_id": "f2e28553-2b43-4d61-bb4d-20a2b88048a0"
    "name": "Electronics"
    "image": "https://placekitten.com/200/200"
  },
  {
    "category_id": "2ff524f8-e00a-47d3-b2a4-2fe8ec64987d"
    "name": "Clothing"
    "image": "https://placekitten.com/200/201"
  },
  {
    "category_id": "136d0e79-295b-4cf1-8e86-d7578c637d94"
    "name": "Home and Furniture"
    "image": "https://placekitten.com/200/202"
  }
  // ...
]
```

| Status Code | Case    |
| ----------- | ------- |
| 200 OK      | Success |

## Get A Single Category

You can get a single category by adding the category ID as a parameter: `/categories/:id`.

Request:

```
[GET] https://e-commerce.com/api/v1/categories/:id
```

Response:

```
{
  "category_id": "f2e28553-2b43-4d61-bb4d-20a2b88048a0"
  "name": "Electronics"
  "image": "https://placekitten.com/200/200"
}
```

| Status Code   | Case              |
| ------------- | ----------------- |
| 200 OK        | Success           |
| 404 Not Found | ID does not exist |

## Get All Products By Category

You can get the products by category adding the category ID as a parameter to `/categories/:id/products`.

Request:

```
[GET] https://e-commerce.com/api/v1/categories/:id/products
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
      "category_id": "f2e28553-2b43-4d61-bb4d-20a2b88048a0"
      "name": "Electronics"
      "image": "https://placekitten.com/200/200"
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

| Status Code   | Case              |
| ------------- | ----------------- |
| 200 OK        | Success           |
| 404 Not Found | ID does not exist |

## Create A Category

When logged in as an admin, you can create a new category by sending an object like the following to `/categories/`, with a token in the header:

Request:

```
[POST] https://e-commerce.com/api/v1/categories

# Body
{
    "name": "Food",
    "image": "https://placekitten.com/200/200"
}

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "category_id": "f2e28553-2b43-4d61-bb4d-20a2b88048a0",
  "name": "Food",
  "image": "https://placekitten.com/200/200"
}
```

| Status Code      | Case                                    |
| ---------------- | --------------------------------------- |
| 201 Created      | Success                                 |
| 400 Bad Request  | Part of request body missing or invalid |
| 401 Unauthorized | Invalid token, no authorization token   |
| 403 Forbidden    | Token not belonging to admin            |

## Update A Category

When logged in as an admin, you can update a category by sending an object in the body with the following shape to `/categories` (only properties and values that need to be updated) and adding the `id` as a parameter, with a token in the header.

Request:

```
[PATCH] https://e-commerce.com/api/v1/categories/:id

# Body
{
  "name": "Updated category name",
}

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "category_id": "f2e28553-2b43-4d61-bb4d-20a2b88048a0",
  "name": "Updated category name",
  "image": "https://placekitten.com/200/200"
}
```

| Status Code      | Case                                    |
| ---------------- | --------------------------------------- |
| 200 OK           | Success                                 |
| 400 Bad Request  | Part of request body missing or invalid |
| 401 Unauthorized | Invalid token, no authorization token   |
| 403 Forbidden    | Token not belonging to admin            |
| 404 Not Found    | ID does not exist                       |

## Delete An User

When logged in as an admin, you can delete a category by adding the category ID as a parameter: `/categories/f2e28553-2b43-4d61-bb4d-20a2b88048a0`, with a token in the header.

Request:

```
[DELETE] https://e-commerce.com/api/v1/categories/:id

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
| 404 Not Found    | ID does not exist                     |

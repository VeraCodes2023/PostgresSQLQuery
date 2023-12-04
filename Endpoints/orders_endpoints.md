# Orders Endpoints

| HTTP Method | Endpoint         | Description                                           |
| ----------- | ---------------- | ----------------------------------------------------- |
| GET         | /orders          | [Get all orders](#get-all-orders)                     |
| GET         | /orders/user/:id | [Get all orders by a user](#get-all-orders-by-a-user) |
| GET         | /orders/:id      | [Get a single order](#get-a-single-order)             |
| POST        | /orders          | [Create an order](#create-an-order)                   |
| PATCH       | /orders/:id      | [Update an order](#update-an-order)                   |
| DELETE      | /orders/:id      | [Delete an order](#delete-an-order)                   |

## Get All Orders

When logged in as an admin, you can access the list of all orders by using the `/orders` endpoint, with a token in the header.

Request:

```
[GET] https://e-commerce.com/api/v1/orders

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
[
  {
    "order_id": 1,
    "user": {
      "user_id": 1,
      "name": "User 1",
      "avatar": "https://placeimg.com/640/480/any",
    }
    "order_date": 01/01/2023 12:00:00 PM,
    "order_status": "pending",
    "order_products": [
      {
        "product_id": 1,
        "title": "Product 1",
        "price": 500,
        "description": "Description of Product 1",
        "category_id": 3,
        "quantity": 2,
      },
      {
        "product_id": 2,
        "title": "Product 2",
        "price": 400,
        "description": "Description of Product 2",
        "category_id": 4,
        "quantity": 3,
      }
    ]
  }
  // ...
]
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 200 OK           | Success                               |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |

## Get All Orders By A User

When logged in as an admin or a user, you can access the list of all orders made by that user by using `orders/user/:id` (`id` is the user ID) as a parameter, with a token in the header.

Request:

```
[GET] https://e-commerce.com/api/v1/orders/user/:id

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 200 OK           | Success                               |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |
| 404 Not Found    | ID does not exist                     |

## Get A Single Order

When logged in as an admin or the user that made the order, you can get that single order by adding the order ID as a parameter: `/orders/:id`, with a token in the header.

Request:

```
[GET] https://e-commerce.com/api/v1/orders/:id

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "order_id": 1,
  "user": {
    "user_id": 1,
    "name": "User 1",
    "avatar": "https://placeimg.com/640/480/any",
  }
  "order_date": 01/01/2023 12:00:00 PM,
  "order_status": "pending",
  "order_products": [
    {
      "product_id": 1,
      "title": "Product 1",
      "price": 500,
      "description": "Description of Product 1",
      "category_id": 3,
      "quantity": 2,
    },
    {
      "product_id": 2,
      "title": "Product 2",
      "price": 400,
      "description": "Description of Product 2",
      "category_id": 4,
      "quantity": 3,
    }
  ]
}
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 200 OK           | Success                               |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |
| 404 Not Found    | ID does not exist                     |

## Create An Order

When logged in as a customer, you can create a new order by sending an object in the body with the following shape to `/orders`, with a token in the header:

Request:

```
[POST] https://e-commerce.com/api/v1/orders

# Body
{
  "user_id": 1
  "order_products": [
    {
      "product_id": 1,
      "quantity": 2,
    },
    {
      "product_id": 2,
      "quantity": 3,
    }
  ]
}

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "order_id": 1,
  "user": {
    "user_id": 1,
    "name": "User 1",
    "avatar": "https://placeimg.com/640/480/any",
  }
  "order_date": 01/01/2023 12:00:00 PM,
  "order_status": "pending",
  "order_products": [
    {
      "product_id": 1,
      "title": "Product 1",
      "price": 500,
      "description": "Description of Product 1",
      "category_id": 3,
      "quantity": 2,
    },
    {
      "product_id": 2,
      "title": "Product 2",
      "price": 400,
      "description": "Description of Product 2",
      "category_id": 4,
      "quantity": 3,
    }
  ]
}
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 201 Created      | Success                               |
| 400 Bad Request  | Part of request body missing          |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |

## Update An Order

When logged in as an admin, you can update an order by sending an object in the body with the following shape to `/orders/:id` (only properties and values that need to be updated) and adding the order ID as a parameter, with a token in the header.

Request:

```
[PATCH] https://e-commerce.com/api/v1/orders/:id

# Body
{
  "order_status": "in process",
}

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "order_id": 1,
  "user": {
    "user_id": 1,
    "name": "User 1",
    "avatar": "https://placeimg.com/640/480/any",
  }
  "order_date": 01/01/2023 12:00:00 PM,
  "order_status": "in process",
  "order_products": [
    {
      "product_id": 1,
      "title": "Product 1",
      "price": 500,
      "description": "Description of Product 1",
      "category_id": 3,
      "quantity": 2,
    },
    {
      "product_id": 2,
      "title": "Product 2",
      "price": 400,
      "description": "Description of Product 2",
      "category_id": 4,
      "quantity": 3,
    }
  ]
}
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 200 OK           | Success                               |
| 400 Bad Request  | Part of request body missing          |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |
| 404 Not Found    | ID does not exist                     |

## Delete An Order

When logged in as an admin, you can delete an order by adding the order ID as a parameter: `/orders/:id`, with a token in the header.

Request:

```
[DELETE] https://e-commerce.com/api/v1/orders/:id

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
true
```

| Status Code      | Case                                    |
| ---------------- | --------------------------------------- |
| 200 OK           | Success                                 |
| 400 Bad Request  | Part of request body missing or invalid |
| 401 Unauthorized | Invalid token, no authorization token   |
| 403 Forbidden    | Token not belonging to admin            |
| 404 Not Found    | ID does not exist                       |

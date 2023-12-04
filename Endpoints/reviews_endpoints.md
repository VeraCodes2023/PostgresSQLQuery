# Reviews Endpoints

| HTTP Method | Endpoint             | Description                                               |
| ----------- | -------------------- | --------------------------------------------------------- |
| GET         | /reviews             | [Get all reviews](#get-all-reviews)                       |
| GET         | /reviews/product/:id | [Get all reviews by product](#get-all-reviews-by-product) |
| GET         | /reviews/user/:id    | [Get all reviews by user](#get-all-reviews-by-user)       |
| GET         | /reviews/:id         | [Get a single review](#get-a-single-review)               |
| POST        | /reviews             | [Create a review](#create-a-review)                       |
| PATCH       | /reviews/:id         | [Update a review](#update-a-review)                       |
| DELETE      | /reviews/:id         | [Delete a review](#delete-a-review)                       |

## Get All Reviews

You can access the list of all reviews by using the `/reviews` endpoint.

Request:

```
[GET] https://e-commerce.com/api/v1/reviews
```

Response:

```
[
  {
    "review_id": "e440b850-09b8-4e54-9328-9b29a42d9e7d",
    "rating": 4,
    "content": "Great laptop!"
    "review_date": 01/01/2023 12:00:00 PM,
    "product_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
    "user": {
      "user_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
      "name": "User 1",
      "avatar": "https://placeimg.com/640/480/any",
    }
  },
  // ...
]
```

| Status Code | Case    |
| ----------- | ------- |
| 200 OK      | Success |

## Get All Reviews By Product

You can access the list of all reviews of a product by passing the product ID as parameter in `/reviews/product/:id` endpoint.

Request:

```
[GET] https://e-commerce.com/api/v1/reviews/product/:id
```

| Status Code   | Case              |
| ------------- | ----------------- |
| 200 OK        | Success           |
| 404 Not Found | ID does not exist |

## Get All Reviews By User

You can access the list of all reviews made by a user by passing the user ID as parameter in `/reviews/user/:id` endpoint.

Request:

```
[GET] https://e-commerce.com/api/v1/reviews/user/:id
```

| Status Code   | Case              |
| ------------- | ----------------- |
| 200 OK        | Success           |
| 404 Not Found | ID does not exist |

## Get A Single Review

You can get a single review by passing the review ID as parameter in `/reviews/:id` endpoint.

Request:

```
[GET] https://e-commerce.com/api/v1/reviews/:id
```

Response:

```
{
  "review_id": "e440b850-09b8-4e54-9328-9b29a42d9e7d",
  "rating": 4,
  "content": "Great laptop!"
  "review_date": 01/01/2023 12:00:00 PM,
  "product_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
  "user": {
    "user_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
    "name": "User 1",
    "avatar": "https://placeimg.com/640/480/any",
  }
},
```

| Status Code   | Case              |
| ------------- | ----------------- |
| 200 OK        | Success           |
| 404 Not Found | ID does not exist |

## Create a review

When logged in as a customer, you can create a review by sending an object like the following to `/reviews`, with a token in the header. Rating should be a number from 1 to 5.

Request:

```
[POST] https://e-commerce.com/api/v1/reviews/

# Body

{
  "rating": 4,
  "content": "Great laptop!"
  "product_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
  "user_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
},
```

Response:

```
{
  "review_id": "e440b850-09b8-4e54-9328-9b29a42d9e7d",
  "rating": 4,
  "content": "Great laptop!"
  "review_date": 01/01/2023 12:00:00 PM,
  "product_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
  "user": {
    "user_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
    "name": "User 1",
    "avatar": "https://placeimg.com/640/480/any",
  }
},
```

| Status Code      | Case                                    |
| ---------------- | --------------------------------------- |
| 200 OK           | Success                                 |
| 400 Bad Request  | Part of request body missing or invalid |
| 401 Unauthorized | Invalid token, no authorization token   |
| 404 Not Found    | ID does not exist                       |

## Update a review

When logged in as a customer, you can update a review you have made before by sending an object like the following to `/reviews` (only properties and values that need to be updated) and adding the review ID as a parameter, with a token in the header.

Request:

```
[PATCH] https://e-commerce.com/api/v1/reviews/:id

# Body

{
  "content": "I realized this laptop is not that good"
},
```

Response:

```
{
  "review_id": "e440b850-09b8-4e54-9328-9b29a42d9e7d",
  "rating": 4,
  "content": "I realized this laptop is not that good"
  "review_date": 01/01/2023 12:00:00 PM,
  "product_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
  "user": {
    "user_id": "ef2fe056-1201-4aaf-bc56-0aeb9b6f36ee",
    "name": "User 1",
    "avatar": "https://placeimg.com/640/480/any",
  }
},
```

| Status Code      | Case                                    |
| ---------------- | --------------------------------------- |
| 200 OK           | Success                                 |
| 400 Bad Request  | Part of request body missing or invalid |
| 401 Unauthorized | Invalid token, no authorization token   |
| 404 Not Found    | ID does not exist                       |

## Delete a review

When logged in as a customer, you can delete a review you made before by adding the review ID as a parameter: /review/:id, with a token in the header. Logging in as admin also allows you to delete any review.

Request:

```
[DELETE] https://e-commerce.com/api/v1/reviews/:id
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

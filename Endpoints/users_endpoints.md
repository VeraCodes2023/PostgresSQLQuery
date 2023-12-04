# Users Endpoints

| HTTP Method | Endpoint   | Description                             |
| ----------- | ---------- | --------------------------------------- |
| GET         | /users     | [Get all user](#get-all-users)          |
| GET         | /users/:id | [Get a single user](#get-a-single-user) |
| POST        | /users     | [Create an user](#create-an-user)       |
| PATCH       | /users/:id | [Update an user](#update-an-user)       |
| DELETE      | /users/:id | [Delete an user](#delete-an-user)       |

## Get All Users

When logged in as an admin, you can access the list of all users by using the `/users` endpoint, with a token in the header.

Request:

```
[GET] https://e-commerce.com/api/v1/users

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
[
  {
    "user_id": 1,
    "name": "User 1",
    "email": "user1@mail.com",
    "password": "abc123",
    "avatar": "https://placeimg.com/640/480/any",
    "role": "customer",
  }
  // ...
]
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 200 OK           | Success                               |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |

## Get A Single User

When logged in as an admin, you can get a single user by adding the user ID as a parameter: `/users/:id`, with a token in the header.

Request:

```
[GET] https://e-commerce.com/api/v1/users/:id

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "user_id": 1,
  "name": "User 1",
  "email": "user1@mail.com",
  "password": "abc123",
  "avatar": "https://placeimg.com/640/480/any",
  "role": "customer",
}
```

| Status Code      | Case                                  |
| ---------------- | ------------------------------------- |
| 200 OK           | Success                               |
| 401 Unauthorized | Invalid token, no authorization token |
| 403 Forbidden    | Token not belonging to admin          |
| 404 Not Found    | ID does not exist                     |

## Create An User

You can create a new user by sending an object in the body with the following shape to `/users`. Only customers can be created when calling this API.

Request:

```
[POST] https://e-commerce.com/api/v1/users

# Body
{
  "name": "User 1",
  "email": "user1@mail.com",
  "password": "abc123",
  "avatar": "https://placeimg.com/640/480/any",
}
```

Response:

```
{
  "user_id": 1,
  "name": "User 1",
  "email": "user1@mail.com",
  "password": "abc123",
  "avatar": "https://placeimg.com/640/480/any",
  "role": "customer",
}
```

| Status Code     | Case                                    |
| --------------- | --------------------------------------- |
| 201 Created     | Success                                 |
| 400 Bad Request | Part of request body missing or invalid |

## Update An User

When logged in as an admin or a customer, you can update that customer by sending an object in the body with the following shape to `/users/:id` (only properties and values that need to be updated) and adding the user ID as a parameter, with a token in the header.

Request:

```
[PATCH] https://e-commerce.com/api/v1/users/:id

# Body
{
  "name": "Updated name",
}

# Headers
{
  "Authorization": "Bearer {your access token}"
}
```

Response:

```
{
  "user_id": 1,
  "name": "Updated name",
  "email": "user1@mail.com",
  "password": "abc123",
  "avatar": "https://placeimg.com/640/480/any",
  "role": "customer",
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

When logged in as an admin, you can delete an order by adding the user ID as a parameter: `/users/:id`, with a token in the header.

Request:

```
[DELETE] https://e-commerce.com/api/v1/users/:id

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

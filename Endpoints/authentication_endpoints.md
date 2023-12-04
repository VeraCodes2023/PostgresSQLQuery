# Authentication Endpoints

| HTTP Method | Endpoint      | Description                                     |
| ----------- | ------------- | ----------------------------------------------- |
| POST        | /auth/login   | [Authentication](#authentication)               |
| GET         | /auth/profile | [Get user with session](#get-user-with-session) |

## Authentication

You can do login by sending an object with the following shape to `/auth/login/`:

Request:

```
[POST] https://e-commerce.com/api/v1/auth/login

# Body
{
  "email": "user1@mail.com",
  "password": "123abc"
}
```

Response:

```
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsImlhdCI6MTY3Mjc2NjAyOCwiZXhwIjoxNjc0NDk0MDI4fQ.kCak9sLJr74frSRVQp0_27BY4iBCgQSmoT3vQVWKzJg",
}
```

| Status Code      | Case                         |
| ---------------- | ---------------------------- |
| 200 OK           | Success                      |
| 400 Bad Request  | Part of request body missing |
| 401 Unauthorized | Incorrect email or password  |

## Get User With Session

You can get the profile the current user with session if in the headers include the Authorization key with the value Bearer {your access token} to `/auth/profile`.

Request:

```
[GET] https://e-commerce.com/api/v1/auth/profile

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

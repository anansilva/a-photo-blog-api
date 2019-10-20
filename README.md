# Photo Blog - Api 📷

This API allows you to store your photos. Four HTTP endpoints are available for use.

## Create a user

```bash
verb POST
url: https://photo-blog-api.herokuapp.com/api/v1/users
```

Send your credentials in the body:

You can skip this step and use an existing test user. Check the next endpoint - Login user.

## Login user

```bash
verb POST
url: https://photo-blog-api.herokuapp.com/auth/login
```

Send your credentials in the body of the request, e.g.:


For testing purposes you can use a test user already available for you:

```bash
email: 'user@test.com'
password: 'test'
```

! The response will return a token, keep it, you will need it to authorize future requests !

```bash
{
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX2VtYWlsIjoidXNlckB0ZXN0LmNvbSIsImV4cCI6MTU3MTY1NDM0OX0.5N24zRk4v1POAG2a8kuv1RRLqT4xbNRVy76JgARDmRc",
    "exp": "2019-10-21T10:39:09.984Z",
    "user_id": 1,
    "user_email": "user@test.com"
}
```

## List Posts

```bash
verb GET
url: https://photo-blog-api.herokuapp.com/api/v1/posts
headers: <your-token>
```

## Create a Post

```bash
verb POST
url: https://photo-blog-api.herokuapp.com/api/v1/posts
headers: <your-token>
```

Send the photo file in the body of the request, e.g.:
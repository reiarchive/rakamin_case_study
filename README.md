# RESTful API Documentation

## Introduction

Welcome to the documentation for the Todo List RESTful API application. This API was developed as a case study project for the Rakamin Academy application. This application allows users to create and manage todo lists and items within those lists. The API implements JSON Web Tokens (JWT) for authentication and authorization and utilizes bcrypt for secure password hashing.

Tech Stack Used :

- Rails version             7.0.4.3
- Ruby version              3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]
- RubyGems version          3.4.10
- Rack version              2.2.7

## Table of Contents

- [Authentication](#authentication)
  - [Register](#register)
  - [Login](#login)
- [API Versioning](#api-versioning)
- [Paginating](#paginating)
- [Todo Lists](#todo-lists)
  - [Create a Todo List](#create-a-todo-list)
  - [Retrieve Todo Lists](#retrieve-todo-lists)
  - [Retrieve Todo by ID](#retrieve-todo-by-id)
  - [Update Todo](#update-todo)
  - [Delete Todo](#delete-todo)
- [Todo Items](#todo-items)
  - [Create a Todo Item](#create-a-todo-item)
  - [Retrieve Todo Items](#retrieve-todo-items)
  - [Retrieve Todo Item by ID](#retrieve-todo-item-by-id)
  - [Update Todo Item](#update-todo-item)
  - [Delete Todo Item](#delete-todo-item)

## Authentication

To access the API's protected endpoints, users need to authenticate themselves. Authentication is done using JWT. Upon successful authentication, the API will provide the user with a token that should be included in the headers **Authorization** of requests.

## Register

- Endpoint: `/signup`
- Method: `POST`
- Description: Allows users to register an account.
- Request Body:
  - `name` (string, required): The name for the account.
  - `email` (string, required): The username for the account.
  - `password` (string, required): The password for the account.
  - `password_confirmation` (string, required): should be same as `password`.
- Response:
  - `auth_token` (string): A JWT Token for authentication.
  - `message` (string): A success message indicating the account has been created.
- Testing using httpie:
  - ```http POST :3000/signup name="name" email="email@email.com" password="pswd123" password_confirmation="pswd123"```
  
## Login

- Endpoint: `/auth/login`
- Method: `POST`
- Description: Allows users to log into their account.
- Request Body:
  - `email` (string, required): The email for the account.
  - `password` (string, required): The password for the account.
- Response:
  - `token` (string): The JWT token to be used for subsequent authenticated requests.



# API Versioning

To change the API version, you can specify the version using the `Accept` header in your requests. The API version is indicated by the `v1` in the `Accept` header value.

Example:
```
Accept: 'application/vnd.todos.v1+json'
```

This header informs the server that you want to use version 1 of the API.

# Paginating

To retrieve todos API with pagination, you can use the `page` query parameter. The `page` parameter allows you to specify the page number for fetching a specific set of todos. Each page contain 20 todos.

Example using HTTPie:
```
http :3000/todos page==1 Accept:'application/vnd.todos.v1+json' Authorization:'eyJ0...nLw2bYQbK0g'
```

In the example request, the `page==1` query parameter is set to `1`, indicating that you want to retrieve the first page of todos.

To retrieve another pages, simply update the value of the `page` parameter. For example, to retrieve the second page, you should set `page==2`.

# Todo Lists

## Create A Todo List

- Endpoint: `POST /todos`
- Description: Creates a new todo.
- Request body:
  - `title` (string): The title of the todo.
- Response: 
  - Status: 201 Created
  - Body: The created todo object.

## Retrieve Todo Lists

- Endpoint: `GET /todos`
- Description: Retrieves all todo lists.
- Response:
  - Status: 200 OK
  - Body: An array of todo objects and it items.

## Retrieve Todo by ID

- Endpoint: `GET /todos/:id`
- Description: Retrieves a specific todo based on the provided ID.
- Response:
  - Status: 200 OK
  - Body: The requested todo object.

## Update Todo

- Endpoint: `PUT /todos/:id`
- Description: Updates the title of a specific todo.
- Request body:
  - `title` (string): The updated title of the todo.
- Response:
  - Status: 204 No Content
 
## Delete Todo

- Endpoint: `DELETE /todos/:id`
- Description: Deletes a specific todo based on the provided ID. All the items within this todo id will also be deleted.
- Response:
  - Status: 204 No Content

# Todo Items

## Create a Todo Item

- Endpoint: `POST /todos/:todos_id/items`
- Description: Creates a new todo item within a specific todo list.
- Request body:
  - `name` (string): The description of the todo item.
  - `done` (boolean): Is it done or not yet.
- Response:
  - Status: 201 Created
  - Body: The created todo item object.

## Retrieve Todo Items

- Endpoint: `GET /todos/:todos_id/items`
- Description: Retrieves all todo items within a specific todo list.
- Response:
  - Status: 200 OK
  - Body: An array of todo item objects.

## Retrieve Todo Item by ID

- Endpoint: `GET /todos/:todos_id/items/:items_id`
- Description: Retrieves a specific todo item within a specific todo list based on the provided item ID.
- Response:
  - Status: 200 OK
  - Body: The requested todo item object.

## Update Todo Item

- Endpoint: `PUT /todos/:todos_id/items/:items_id`
- Description: Updates a specific todo item within a specific todo list.
- Request body:
  - `name` (string): The description of the todo item.
  - `done` (boolean): Is it done or not yet.
- Response:
  - Status: 204 No Content

## Delete Todo item

- Endpoint: `DELETE /todos/:todos_id/items/:items_id`
- Description: Deletes a specific todo item within a specific todo list based on the provided item ID.
- Response:
  - Status: 204 No Content


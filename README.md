# GraphQL Blog

Welcome to the GraphQL Blog project! This project is a simple blog application built with GraphQL.

## Features

- Create, read, update, and delete blog posts
- User authentication and authorization
- Comment on posts
- Like and unlike posts

## Technologies Used

- Ruby on Rails
- Sqlite3
- GraphQL

## Getting Started
  This project will be developed in multiple stages. Currently following stages are done.
  - Initialisation of project
  - User creation through seed and GraphQl setup.
  - GraphQl Engine mount and testing on localhost.
  - Added JWT to perform token based authorixation in application.
  - Added Login and SignUp methods as mutations and token generation.
  - Handled Errors.
  - Added validations in User model.
  - Added encoding and decoding of jwt for session control.
  - Added token handling for user crud operation.
  - Added CRUD operations and model for Blogs.
### Prerequisites

- Ruby on Rails
- Sqlite3
- GraphQL
- JWT for token based authentication.

### Installation

1. Clone the repository:
  ```sh
  git clone https://github.com/your-username/graphql_blog.git
  ```
2. Navigate to the project directory:
  ```sh
  cd graphql_blog
  ```
3. Install dependencies:
  ```sh
  bundle install
  ```

### Running the Application

1. Start the rails server:
  ```sh
  rails server or rails s
  ```


### Usage

- Open your browser and navigate to `http://localhost:3000/graphiql` to access the GraphQL playground.
- Use the playground to interact with the GraphQL API.

## Contributing

Currently not accepting any contribution. Please do not create any PR

## License

This project is licensed under the MIT License.

## Contact

- Author: Abhishek Jaiswal
- Email: jaiswalabhishek0802@gmail.com

Enjoy using the GraphQL Blog!
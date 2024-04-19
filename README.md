# Treasure Hunt

## Problem

```
Objective:
Design and implement a Ruby on Rails-based Treasure Hunt game that revolves around a
RESTful API. The primary goal is to evaluate your ability to create an interactive game, handle
user input, implement game logic, and ensure security within the Ruby on Rails framework.

User Interaction:
Users can submit guesses for the treasure's location through the REST API.

Game Logic:
Calculate the distance between user-submitted coordinates and the actual treasure location.
If the distance is less than 1000 meters, mark the user as a winner.
Send an email confirmation to the user when they become a winner.
A user can become a winner only once.

Winner List Endpoint:
Implement an API endpoint allowing users to fetch a list of winners sorted by distance.
Optionally include sorting options (ascending, descending) and pagination.

Technology Stack:
Use Ruby on Rails as the web framework.
Choose a suitable database or data store (e.g., PostgreSQL, MySQL) for storing game data
securely.
You can use any library.

Submission:
Upload your implementation to a GitHub repository
```

## Rules

- The map size is 10,000 meters x 10,000 meters.
- The treasure is placed randomly on the map.
- The user can submit any number of guesses for the treasure's location.
- The user can become a winner only once.
- The user wins if the distance between the user's guess and the treasure's location is less than 1000 meters.

## Booting the application

For this application you're going to need a Ruby 3+ installed in your machine.

1. Clone the repository.
2. Run `bundle install`.
3. Run `rails db:create db:migrate`.
5. Set the api_key as a credential using `rails credentials:edit`. This is going to be used to authenticate the requests to the API.
4. Run `rails s`.
5. Access `http://localhost:3000` in your browser.

## API Documentation

In order to interact with the API you're going to need to authenticate your requests using the header `API_KEY`. It refers to the `api_key` that you've set in the credentials.

### GET /api/winners

Lists the winners of the game.
It's paginated, 10 per page.
You can pass the `page` parameter to navigate through the pages.
You can use the `order` parameter to sort the results. The default order is `asc`, but you can pass `desc` to get the results in descending order.

## What can be improved

- Improve the unprocessable entity response when submitting guesses so in the UI the user can see the errors discriminated.
- The last commit refactored the GuessesController#create to take an hexagonal architecture approach. The specs still cover all the scenarios, but the specs for the MakeGuess service are missing, so for the new controller methods.
- Implement a better way to authenticate the requests in the API. This could be a bearer token or a JWT.
- Use a pagination library to handle the pagination in the API.

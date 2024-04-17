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


# migracode-extra-exercise-02-07-2022

## Description

Glivo, a company that provides delivery of food in Barcelona to users using his flee or riders, hired you as backend developer. You've been working at the company for 6 months and things are going well.

The company is managing a legacy system that is not suited for high scalability and availability and tasks you to redesign the backend system from scratch.

They don't have specific technical requirements. They only want it to be fast, simple and easy to maintain.

You decide to go with a backend application mainly with: NodeJs + PostgreSql. Before going crazy, you decide to sit down in your desk and list the [requirements](#requirements).

## Assumptions

To simplify the problem, we are going to assume that Barcelona is like Eixample. Both users and restaurants can be located by a pair of coordinates. Examples: User with name 'Eduard B.' lives in (3,95), restaurant with name 'El pájaro loco' is located in (54,81), etc.

We are going to assume that ALL streets have 1 road on each direction.

Also, we are going to assume that each restaurant:

- takes a certain amount of time to prepare a specific type of food
- and that the time to transport the food is proportional to the distance between the restaurant and the user that ordered it.

## Requirements

- As a user, I can see a the list of restaurants that are close to me.
  - I want to see the restaurant name, the type of food it provides and the location where the restaurant is.
- As a user, I can FILTER the restaurants by DISTANCE and TYPE OF FOOD they offer.
  - I want to see the restaurant sorted by the time it takes to receive the food.

![diagram.png](images/diagram.png)

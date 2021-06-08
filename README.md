# Cryptonite

  A Ruby/Rails public Crypto Currency API in which users can search and filter through results. This app is hosted using Heroku and database is scheduled to update every 10 minutes with the latest data from shrimpy API. Highlights of the application include endpoints that return paginated results and 100% test coverage.
  
## Authors
    
  - **Khoa Nguyen** 
  
    - [GitHub](https://github.com/omegaeye)
    - [Link'd In](https://www.linkedin.com/in/khoa-n323)
    
## Summary

  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Reflection](#reflection)

## Getting Started

### For Using Endpoints

Go to [Endpoints](#endpoints) and use `/coins` and `coins/searches` endpoints to recieve crypto currency information.

### Gemfile
![fj-gemfile](https://user-images.githubusercontent.com/46826902/120928594-7b443000-c6a2-11eb-9007-3a0f11408cb5.png)

### Installing

- Fork and clone this repo
- Run `bundle install`
- Run `rails db:{create,migrate,seed}`

## Running the tests

- `bundle exec rspec` to run the test suite

### Sample of Tests Across the App

#### Search Happy Path

![Search happy path](https://user-images.githubusercontent.com/46826902/120930053-e1cc4c80-c6a8-11eb-8979-7baade5b3e86.png)


#### Search Sad Path

![Search sad path](https://user-images.githubusercontent.com/46826902/120930155-64550c00-c6a9-11eb-96c8-f2a0fb2b4944.png)

#### Search pagination

![Search pagination](https://user-images.githubusercontent.com/46826902/120933019-80f74100-c6b5-11eb-9591-f179f347f1e3.png)

#### Search pagination sad path and edge case

![Search sad path and edge case](https://user-images.githubusercontent.com/46826902/120932963-31b11080-c6b5-11eb-9b51-c5065edebec3.png)

## Endpoints

### Post https://crypton-ite.herokuapp.com/api/v1/coins/searches
Search through the database with valid params

### Get https://crypton-ite.herokuapp.com/api/v1/coins
Returns of all crypto coins in list of 20

## Built With

<p align="left"> <a href="https://circleci.com" target="_blank"> <img src="https://www.vectorlogo.zone/logos/circleci/circleci-icon.svg" alt="circleci" width="40" height="40"/> </a> <a href="https://heroku.com" target="_blank"> <img src="https://www.vectorlogo.zone/logos/heroku/heroku-icon.svg" alt="heroku" width="40" height="40"/> </a> <a href="https://www.postgresql.org" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/postgresql/postgresql-original-wordmark.svg" alt="postgresql" width="40" height="40"/> </a> <a href="https://rubyonrails.org" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/rails/rails-original-wordmark.svg" alt="rails" width="40" height="40"/> </a> <a href="https://www.ruby-lang.org/en/" target="_blank"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a> </p>

## Versioning

This is version 1 of Cryptonite, for any updated versions please check back here. New versions will be linked below:

    
## Reflection 

  - This project has given me great insights on how an advance search engine works. 

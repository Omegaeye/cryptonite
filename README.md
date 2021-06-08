# Cryptonite

  This API was created for users to search and filter Cryto Currency data provided by Shrimpy API. The data is programmed to update every 10 minutes, ensuring the users have the latest crypto currency information available. A few highlights for this application are the Circle CI, endpoints and test suite. The endpoints return paginated results and the included test suite has 100% coverage. 
This application was created with Ruby on Rails and is currently being auto deployed to Heroku after successfully passing Circle CI checks.
  
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
  - [Acknowledgement](#acknowledgement)

## Getting Started

### For Using Endpoints

Go to [Endpoints](#endpoints) and use `/coins` and `coins/searches` endpoints to recieve crypto currency information.

### Gemfile
![fj-gemfile](https://user-images.githubusercontent.com/46826902/120928594-7b443000-c6a2-11eb-9007-3a0f11408cb5.png)

### Installing

- Fork and clone this repo
- Run `bundle install`
- Run `rails db:{create,migrate,seed}`
- To seed test database
  - Run `rails db:seed RAILS_ENV=test`

## Running the tests

- `bundle exec rspec` to run the test suite

### Sample of Tests Across the App
  
  - Testing includes coverage of all endpoint with happy and sad path and edge case.

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

  - Following the process of TDD allowed me to thoroughly organized my thoughts and planned out the algorithm of this project.
    - writing the tests and using the errors to guide me on what code to write has increase my understanding in different aspects of the app that I would never have thought of. 
      - reading and understanding errors
      - flow of data
      - better security   
  - In previous projects, I was more focused on the functionality, structure, and implementation of codes. This project allowed me to dive deep into an area that I've always been curious about, advance search and filtering. 
  - Creating and saving the search request into the database as a model allow future implementation of caching to further optimize the performance of the app. 
  - currently, the request params are being pushed to the model which compile data from the database then response back to the controller.
    - I do understand that having the model compile data from the database on every request will have a slower response.
  - In order to increase user experience I made sure that the app is protected against Shrimpy API failing by consuming the API and create a coin model that has attributes with the data as values.
    - The database is being updated by destroying all the coin data and reseeded with the help of Heroku Scheduler, set to every 10 minutes, which is designed with the limitation of Heroku storage in mind.
    - for future iteration, I would implement that the data is being sort through and if there's a change in the value, then create another instance of coin. That way, I have the ability to store previous values for further algorithm research.
  - One way that I optimize for speed is to implement pagination. It default to return only 20 records per request unless params is given. The limitation on the return of records help split the data into smaller chunks so the app doesn't have to process such a large amount of data.
  - to reduce the negative user experience, sad path and edge case was included and tested thoroughly. Test coverage in 100%.

## Acknowledgement

  - This app data is being provided by [Shrimpy.io](https://dev-api.shrimpy.io), crypto trading and market data API.

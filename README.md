# Cryptonite

  A Ruby/Rails public Crypto Currency API in which users can search and filter through results.

## Summary

  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Versioning](#versioning)
  - [Authors](#authors)
  - [Acknowledgments](#acknowledgments)

## Getting Started

### For Using Endpoints

Go to [Endpoints](#endpoints) and use `/coins` and `/searches` endpoints to recieve crypto currency information.

### Gemfile
![fj-gemfile](https://user-images.githubusercontent.com/46826902/120928594-7b443000-c6a2-11eb-9007-3a0f11408cb5.png)

### Installing

- Fork and clone this repo
- Run `bundle install`
- Run `rails db:{create,migrate,seed}`

## Running the tests

- `bundle exec rspec` to run the test suite

## Endpoints

### Post https://crypton-ite.herokuapp.com/api/v1/searches
Search through the database with valid params

### Get https://crypton-ite.herokuapp.com/api/v1/coins
Returns of all crypto coins in list of 20

## Built With

  - Rails API
  - BCrypt
  - FastJsonApi
  - RSpec
  - Capybara
  - VCR
  - SimpleCov

## Versioning

This is version 1 of Cryptonite, for any updated versions please check back here. New versions will be linked below:

## Authors
    
  - **Khoa Nguyen** - 
    [GitHub](https://github.com/omegaeye)

## Acknowledgments

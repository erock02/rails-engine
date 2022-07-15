# README


## Ruby/Rails version
* Ruby v 2.7.4
* Rails v. 5.2.6

## Database creation

In the terminal, first run the command
`Rails db:{drop,create,migrate,seed}`
After disregarding all the PG warnings, run 
`rails db:schema:dump`

## How to run the test suite

In the terminal, run the command
`Bundle exec rspec`
To run the entire test suite

## Functionality

This project allows users to query an API using endpoints.
Run `rails s` in the terminal.
The following endpoints are available on LOCALHOST

`get api/v1/merchants` Will return a list of all merchants and their attributes
`get api/v1/merchants/{merchant_id}` replacing merchant ID with an integer will return a merchant with that ID and their attributes
`get api/v1/items` Will return a list of all items and their attributes
`get api/v1/items/{item_id}` replacing item ID with an integer will return an item with that ID and it's attributes
`post /api/v1/items` will create an item given a JSON body that contains an items attributes
`patch /api/v1/items/:id` will update an item given a JSON body containing item attributes 
`destroy /api/v1/items/:id` will delete an item with the given ID
`get /api/v1/merchants/:id/items` given a merchant ID, this will send a list of a merchants items and their attributes 
`get /api/v1/items/:id/merchant` given an item ID, this will send the item's merchant and their attributes 

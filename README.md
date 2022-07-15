# README


Ruby version
* Ruby v 2.7.4
* Rails v. 5.2.6

Database creation

In the terminal, first run the command
Rails db:{drop,create,migrate,seed}
After disregarding all the PG warnings, run 
rails db:schema:dump

How to run the test suite

In the terminal, run the command
Bundle exec rspec
To run the entire test suite

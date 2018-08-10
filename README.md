# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation
Grab latest CardDefs.xml from https://github.com/HearthSim/hsdata
Check everything is OK:
- Run 'rake xml:readtags' for all tag values
- Run 'rake xml:missing_enums' when getting a new CardDefs.xml (enums values: https://github.com/HearthSim/python-hearthstone/blob/master/hearthstone/enums.py)

* Database initialization
Run 'rake db:migrate'
Run 'rake db:populate' all at once, or step by step:
- 'rake db:populate_enums' to fill sets, classes, types and rarities
- 'rake db:populate_cards' to fill cards

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

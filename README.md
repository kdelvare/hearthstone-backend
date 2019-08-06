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
- For correct FR sorting, change cards.name_fr collation to utf8_unicode_ci

* Database update with new CardDefs.xml
Run 'rake db:populate_cards'

* Find wanteddecks from deleted decks
Wanteddeck.where('NOT EXISTS (SELECT * FROM decks WHERE decks.id = wanteddecks.deck_id)')
* Find wantedcards from deleted wanteddecks
Wantedcard.where('wantedcards.wanteddeck_id IS NOT NULL').where('NOT EXISTS (SELECT * FROM wanteddecks WHERE wanteddecks.id = wantedcards.wanteddeck_id)')
* Find decks from deleted deckgroups
Deck.where('decks.deckgroup_id IS NOT NULL').where('NOT EXISTS (SELECT * FROM deckgroups WHERE deckgroups.id = decks.deckgroup_id)')
* Find deckcards from deleted decks
Deckcard.where('NOT EXISTS (SELECT * FROM decks WHERE decks.id = deckcards.deck_id)')
* Find wantedcards that do not belong to the original deck anymore
Wantedcard.where('wantedcards.wanteddeck_id IS NOT NULL').where('NOT EXISTS (SELECT * FROM wanteddecks INNER JOIN deckcards ON wanteddecks.deck_id = deckcards.deck_id WHERE wantedcards.wanteddeck_id = wanteddecks.id AND deckcards.card_id = wantedcards.card_id)')

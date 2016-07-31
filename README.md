# Hashbot

A Slack bot for Hashbang.  Built with Sinatra, DataMapper + Postgres, and slack-ruby-bot.

## Configuration

Make sure you have a .env file locally which contains the bot's `SLACK_API_TOKEN`.

## Pre-requisites

* Postgres

## Developing

To spin up a local instance, first provision a database:

`createdb hashbot`

Then you can start the bot and webapp via foreman:

`foreman start`
 
## Deployment

The "production" instance is running on Heroku, so:

`git push heroku master`

Maintenance mode on Heroku won't actually stop the bot, it will only prevent access to the website itself.  To disable the bot, you will need to run:

`heroku ps:scale web=0`

Don't forget to set it back to 1 when you are ready to run again!

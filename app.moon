lapis = require "lapis"

import respond_to from require "lapis.application"
import json_params from require "lapis.application"

mongo = require 'mongo'
client = mongo.Client('mongodb://127.0.0.1')
characters = client\getCollection('treestats-dev', 'characters')

-- globals?
servers = { "TestServer" }

class App extends lapis.Application
  @enable "etlua"

  [index: "/"]: =>
    render: true

  [characters: "/characters"]: respond_to {
    GET: =>
      @characters = characters\find(mongo.BSON('{}'))
      render: true

    POST: json_params => {
      {
        json: {
          character: @url_for Characters\create @params
        }
      }
    }
  }

  [servers: "/servers"]: =>
    @servers = servers
    render: true

  [server: "/server/:server"]: =>
    @characters = characters\find(mongo.BSON('{ "s" : "TestServer" }'))
    render: true

  [character: "/server/:server/:name"]: =>
    @character = characters\findOne(mongo.BSON('{ "s" : "TestServer", "n" : "TestCharacter"}'))\value()
    render: true

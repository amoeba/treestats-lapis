lapis = require "lapis"
import respond_to from require "lapis.application"
import json_params from require "lapis.application"

db = require "lapis.db"


import Model, enum from require "lapis.db.model"

class Characters extends Model
  @primary_key: { "server", "name" }
  @timestamp: true
  url_params: (req, ...) =>
    "character", { server: @server, name: @name }

-- TODO: Factor out
servers = {
  'WintersEbb'
}

class App extends lapis.Application
  @enable "etlua"

  [index: "/"]: =>
    @html ->
      h2 "Index"
      a href: @url_for("servers"), "List servers"

  [characters: "/characters"]: respond_to {
    GET: =>
      @characters = db.query "select * from characters"
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
    @servers = db.query "select distinct server from characters limit 100"
    render: true

  [server: "/server/:server"]: =>
    res = db.query "select * from characters where server = ?", @params.server

    @html ->
      h2 "Character Listing for #{@params.server}"
      ul ->
        for i = 1, #res
          li ->
            a href: @url_for("character", server: @params.server, name: res[i].name), res[i].name

  [character: "/server/:server/:name"]: =>
    @character = db.query "select server, name from characters where server = ? and name = ? limit 1", @params.server, @params.name
    print "@character is #{@character}"
    render: true

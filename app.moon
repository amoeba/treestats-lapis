lapis = require "lapis"
db = require "lapis.db"

-- TODO: Factor out
servers = {
	'WintersEbb'
}

import Model from require "lapis.db.model"

class Character extends Model

class App extends lapis.Application
  [index: "/"]: =>
  	@html ->
  		h2 "Index"
  		a href: @url_for("list_servers"), "List servers"

  [list_servers: "/servers"]: =>
    @html ->
      ul ->
        for i = 1, #servers
          li ->
            a href: @url_for("server", server: servers[i]), servers[i]

  [server: "/server/:server"]: =>
    res = db.query "select * from characters"
    
    @html ->
    	h2 "Character Listing for #{@params.server}"
    	ul ->
        for i = 1, #res
          li ->
            a href: @url_for("character", server: @params.server, name: res[i].name), res[i].name

  [character: "/server/:server/:name"]: =>
  	@html ->
  		h2 "#{@params.server}/#{@params.name}"
  		span "Not implemented yet..."
local lapis = require("lapis")
local respond_to
respond_to = require("lapis.application").respond_to
local json_params
json_params = require("lapis.application").json_params
local mongo = require('mongo')
local client = mongo.Client('mongodb://127.0.0.1')
local characters = client:getCollection('treestats-dev', 'characters')
local servers = {
  "TestServer"
}
local App
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    [{
      index = "/"
    }] = function(self)
      return {
        render = true
      }
    end,
    [{
      characters = "/characters"
    }] = respond_to({
      GET = function(self)
        self.characters = characters:find(mongo.BSON('{}'))
        return {
          render = true
        }
      end,
      POST = json_params(function(self)
        return {
          {
            json = {
              character = self:url_for(Characters:create(self.params))
            }
          }
        }
      end)
    }),
    [{
      servers = "/servers"
    }] = function(self)
      self.servers = servers
      return {
        render = true
      }
    end,
    [{
      server = "/server/:server"
    }] = function(self)
      self.characters = characters:find(mongo.BSON('{ "s" : "TestServer" }'))
      return {
        render = true
      }
    end,
    [{
      character = "/server/:server/:name"
    }] = function(self)
      self.character = characters:findOne(mongo.BSON('{ "s" : "TestServer", "n" : "TestCharacter"}')):value()
      return {
        render = true
      }
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "App",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self:enable("etlua")
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  App = _class_0
  return _class_0
end

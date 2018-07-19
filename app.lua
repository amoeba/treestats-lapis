local lapis = require("lapis")
local respond_to
respond_to = require("lapis.application").respond_to
local json_params
json_params = require("lapis.application").json_params
local db = require("lapis.db")
local servers = {
  'WintersEbb'
}
local Model
Model = require("lapis.db.model").Model
local Character
do
  local _class_0
  local _parent_0 = Model
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Character",
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
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Character = _class_0
end
local App
do
  local _class_0
  local _parent_0 = lapis.Application
  local _base_0 = {
    [{
      index = "/"
    }] = function(self)
      return self:html(function()
        h2("Index")
        return a({
          href = self:url_for("list_servers")
        }, "List servers")
      end)
    end,
    [{
      characters = "/characters"
    }] = respond_to({
      GET = function(self)
        return self:html(function()
          h2("Characters")
          return p("Not implemented")
        end)
      end,
      POST = json_params(function(self)
        return {
          json = {
            params = self.params,
            success = true,
            message = "hello world"
          }
        }
      end)
    }),
    [{
      list_servers = "/servers"
    }] = function(self)
      return self:html(function()
        return ul(function()
          for i = 1, #servers do
            li(function()
              return a({
                href = self:url_for("server", {
                  server = servers[i]
                })
              }, servers[i])
            end)
          end
        end)
      end)
    end,
    [{
      server = "/server/:server"
    }] = function(self)
      local res = db.query("select * from characters")
      return self:html(function()
        h2("Character Listing for " .. tostring(self.params.server))
        ul(function() end)
        for i = 1, #res do
          li(function()
            return a({
              href = self:url_for("character", {
                server = self.params.server,
                name = res[i].name
              })
            }, res[i].name)
          end)
        end
      end)
    end,
    [{
      character = "/server/:server/:name"
    }] = function(self)
      return self:html(function()
        h2(tostring(self.params.server) .. "/" .. tostring(self.params.name))
        return span("Not implemented yet...")
      end)
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
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  App = _class_0
  return _class_0
end

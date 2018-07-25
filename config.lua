local config
config = require("lapis.config").config
return config("development", function()
  return postgres(function()
    host("127.0.0.1")
    user("lapispktest")
    password("lapispktest")
    return database("lapispktest")
  end)
end)

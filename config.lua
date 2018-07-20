local config
config = require("lapis.config").config
return config("development", function()
  return postgres(function()
    host("127.0.0.1")
    user("postgres")
    password("")
    return database("treestats")
  end)
end)

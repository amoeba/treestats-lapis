local create_table, types
do
  local _obj_0 = require("lapis.db.schema")
  create_table, types = _obj_0.create_table, _obj_0.types
end
return {
  [1] = function(self)
    return create_table("characters", {
      {
        "name",
        types.text
      },
      {
        "server",
        types.text
      },
      {
        "created_at",
        types.time
      },
      {
        "updated_at",
        types.time
      },
      "PRIMARY KEY (name, server)"
    })
  end
}

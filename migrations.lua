local create_table, types
do
  local _obj_0 = require("lapis.db.schema")
  create_table, types = _obj_0.create_table, _obj_0.types
end
return {
  [1] = function(self)
    return create_table("characters", {
      {
        "id",
        types.serial
      },
      {
        "name",
        types.text
      },
      {
        "server",
        types.text
      },
      {
        "race",
        types.enum
      },
      {
        "gender",
        types.enum
      },
      {
        "level",
        types.integer
      },
      {
        "created_at",
        types.date
      },
      {
        "updated_at",
        types.date
      },
      "PRIMARY KEY (id)"
    })
  end
}

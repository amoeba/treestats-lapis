-- migrations.moon

import create_table, types from require "lapis.db.schema"

{
  [1]: =>
    create_table "characters", {
      { "name", types.text }
      { "server", types.text }
      { "created_at", types.time }
      { "updated_at", types.time }

      "PRIMARY KEY (name, server)"
    }
}
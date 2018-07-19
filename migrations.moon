-- migrations.moon

import create_table, types from require "lapis.db.schema"

{
  [1]: =>
    create_table "characters", {
      { "id", types.serial }
      { "name", types.text }
      { "server", types.text }
      { "race", types.enum }
      { "gender", types.enum }
      { "level", types.integer }
      { "created_at", types.date }
      { "updated_at", types.date }

      "PRIMARY KEY (id)"
    }
}
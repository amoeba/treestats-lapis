import Model, enum from require "lapis.db.model"

class Characters extends Model
  @primary_key: { "server", "name" }
  @timestamp: true
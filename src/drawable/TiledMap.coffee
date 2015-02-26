class Rotten.Drawables.TiledMap

    constructor: (@name, @tile_width, @tile_height) ->
        @map = Rotten.MapCache[@name] or throw new Error "[Rotten.Drawables.TiledMap] You did not preloaded one of your assets (name: " + @name + ")"

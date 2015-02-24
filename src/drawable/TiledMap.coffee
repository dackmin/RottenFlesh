class Rotten.Drawable.TiledMap

    constructor: (@name, @tile_width, @tile_height) ->
        @map = Rotten.MapCache[@name] or throw new Error "[Rotten.Drawable.TiledMap] You did not preloaded one of your assets (name: " + @name + ")"

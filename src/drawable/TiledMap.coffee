# A drawable Tiled map
# ie. Make the most beautiful map you can on Tiled, export it as JSON,
# and add it here : the end.
#
# @example How to create a TiledMap
#   var map = new Rotten.Drawables.TiledMap("my_beautiful_map", 32, 32)
#
class Rotten.Drawables.TiledMap extends Rotten.Drawable


    # Constructs a new TiledMap
    #
    # @param {String} name Your map name
    # @param {int} tile_width Width of a tile in your map
    # @param {int} tile_height Height of a tile in your map
    constructor: (@name, @tile_width, @tile_height) ->
        super

        # Your actual map object
        @map = Rotten.MapCache[@name] or throw new Error "[Rotten.Drawables.TiledMap] You did not preloaded one of your assets (name: " + @name + ")"

        # Your tilesets images
        @tilesets_images = {}

        # Map position on X
        @x = 0

        # Map position on Y
        @y = 0


    # Setup your TiledMap
    setup: ->

        # Setup tile positions on tileset to avoid intensive usage of CPU
        for tileset in @map.tilesets
            tileset.positions = []
            z = 1
            for y in [0...tileset.imageheight] by tileset.tileheight
                for x in [0...tileset.imagewidth] by tileset.tilewidth
                    tileset.positions[z] =
                        x : x
                        y : y
                    z++


    # Update your TiledMap
    update: ->


    # Draw your TiledMap
    draw: ->

        # Save context
        @game.render.save()

        # Draw each layer
        for layer in @map.layers
            for x in [0...layer.width]
                for y in [0...layer.height]

                    # And in each layer, draw every tile
                    @.drawImageFromGID x, y, layer.data[x+(y*layer.width)], "tile" # if layer.data[x][y] not 0

        # Restore context
        @game.render.restore()


    # Draw a tile
    drawImageFromGID: (x, y, GID, type) ->
        #if isNaN GID then return;

        tileset = @getTilesetFromGID GID
        tile_position = tileset.positions[GID];

        # Double check to see if tileset image has been loaded
        if Rotten.TextureCache[@tilesets_images[tileset.name]] is undefined
            throw new Error "[Rotten.Drawables.TiledMap] You are using a non-loaded asset"

        # Draw the tile
        @game.render.drawSubImage Rotten.TextureCache[@tilesets_images[tileset.name]],
            tile_position.x,
            tile_position.y,
            tileset.tilewidth,
            tileset.tileheight,
            if type is "object" then x else @x + (x * tileset.tilewidth),
            if type is "object" then y else @y + (y * tileset.tileheight),
            tileset.tilewidth,
            tileset.tileheight


    getTilesetFromGID: (GID) ->
        tileset = {}

        if @map.tilesets.length is 1
            return @map.tilesets[0]

        for own key, tileset of @map.tilesets
            if GID >= tileset.firstgid and @map.tilesets[key + 1] is not undefined and GID < tileset.firstgid
                return tileset


    # Add a tileset image
    # @param {String} tilesetName Name of your tileset INSIDE your map
    # @param {String} assetName Name of your preloaded asset INSIDE rotten
    addTileset: (tilesetName, assetName) ->
        @tilesets_images[tilesetName] = assetName

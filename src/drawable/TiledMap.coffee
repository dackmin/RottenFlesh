###*
 # A drawable Tiled map
 # ie. Make the most beautiful map you can on Tiled, export it as JSON,
 # and add it here : the end.
 # @class Rotten.Drawables.TiledMap
 # @extends Rotten.Drawable
 #
 # @example How to create a TiledMap
 #   var map = new Rotten.Drawables.TiledMap("my_beautiful_map", 32, 32)
 #
###
class Rotten.Drawables.TiledMap extends Rotten.Drawable


    ###*
     # Constructs a new TiledMap
     # @constructor
     # @param {String} name Your map name
     # @param {int} tile_width Width of a tile in your map
     # @param {int} tile_height Height of a tile in your map
    ###
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

        # Setup physics for map
        @world = new p2.World
            gravity: [0 ,0]

        # Map obstacles
        @obstacles = []

    ###*
     # Setup your TiledMap
     # @method setup
    ###
    setup: () ->

        # Register tile positions on tileset to avoid intensive usage of CPU
        for tileset in @map.tilesets
            tileset.positions = []
            z = 1
            for y in [0...tileset.imageheight] by tileset.tileheight
                for x in [0...tileset.imagewidth] by tileset.tilewidth
                    tileset.positions[z] =
                        x : x
                        y : y
                    z++

        # Set obstacles from tiledmap content
        for layer in @map.layers
            if layer.type is "objectgroup"
                for object in layer.objects
                    if object.type is "obstacle"
                        _shape = new p2.Rectangle object.width, object.height
                        _body = new p2.Body
                            mass: 0
                            position: [object.x + object.width / 2, object.y + object.height / 2]

                        _body.addShape _shape
                        @world.addBody _body
                        @obstacles.push object


    ###*
     # Update your TiledMap
     # @method update
    ###
    update: () ->

        # Update world physics
        @world.step 1/60


    ###*
     # Draw your TiledMap
     # @method draw
    ###
    draw: () ->

        # Save context
        @game.render.save()

        # Draw each layer
        for layer in @map.layers
            if layer.type is "tilelayer"
                for x in [0...layer.width]
                    for y in [0...layer.height]

                        # And in each layer, draw every tile
                        @.drawImageFromGID x, y, layer.data[x+(y*layer.width)], "tile" # if layer.data[x][y] not 0


        # Draw obstacles for debug purposes
        if Rotten.Settings.DEBUG is true
            for obstacle in @obstacles
                @game.render.rect obstacle.x, obstacle.y, obstacle.width, obstacle.height, "rgba(0, 0, 255, 0.4)"

        # Restore context
        @game.render.restore()


    ###*
     # Draws a tile
     # @method drawImageFromGID
     # @param {int} x - Position of tile on map (in tiles, not px)
     # @param {int} y - Position of tile on map (in tiles, not px)
     # @param {int} GID - Tileset clipping position ID
     # @param {String} type - Determine if your image is an object or a tile
    ###
    drawImageFromGID: (x, y, GID, type) ->
        if isNaN GID then return

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


    ###*
     # Get a tileset from a given GID
     # @method getTilesetFromGID
     # @param {int} GID - Tileset clipping position ID
    ###
    getTilesetFromGID: (GID) ->
        tileset = {}

        if @map.tilesets.length is 1
            return @map.tilesets[0]

        for own key, tileset of @map.tilesets
            if GID >= tileset.firstgid and @map.tilesets[key + 1] is not undefined and GID < tileset.firstgid
                return tileset


    ###*
     # Add a tileset image
     # @method addTileset
     # @param {String} tilesetName Name of your tileset INSIDE your map
     # @param {String} assetName Name of your preloaded asset INSIDE Rotten
    ###
    addTileset: (tilesetName, assetName) ->
        @tilesets_images[tilesetName] = assetName


    ###*
     # Map rect
     # @method rect
     # @return {Object}
    ###
    rect: ->
        x: @x
        y: @y
        width: @map.width * @tile_width
        height: @map.height * @tile_height

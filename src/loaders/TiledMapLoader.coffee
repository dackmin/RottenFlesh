# Tiled map loader
# Using JSON format is a pure generic choice : wanting to avoid FreshFlesh
# mistakes with TMX format parsing
class Rotten.Loaders.TiledMapLoader extends Rotten.EventManager


    # Constructs a tiled map loader
    #
    # @param {String} url Map url
    constructor: (asset) ->
        super

        # Name of your map
        @name = asset.name

        # URL of your tilemap file
        @mapUrl = asset.url


    # Loads the tiled map
    load: ->
        Rotten.Utils.ajax
            url: @mapUrl
            complete: (data) =>
                Rotten.MapCache[@name] = data
                @.fire "loaded", {}

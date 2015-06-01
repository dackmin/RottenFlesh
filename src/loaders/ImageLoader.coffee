###
 # Simple image loader
 # @class Rotten.Loaders.ImageLoader
 # @extends Rotten.EventManager
###
class Rotten.Loaders.ImageLoader extends Rotten.EventManager


    ###*
     # Loader constructor
     # @constructor
     # @param {Object} asset - Asset infos (name: String, url: String)
    ###
    constructor: (asset) ->
        super

        # Name of your image
        @name = asset.name

        # URL of your image
        @imageUrl = asset.url


    ###*
     # Actually loads your image
     # @method load
    ###
    load: () ->
        img = new Image()
        img.src = @imageUrl
        img.onload = () => @fire "loaded", {}
        Rotten.TextureCache[@name] = img

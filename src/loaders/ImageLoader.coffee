# Simple image loader
class Rotten.Loaders.ImageLoader extends Rotten.EventManager


    # Loader constructor
    # @param {String} url Image url
    constructor: (asset) ->
        super

        # Name of your image
        @name = asset.name

        # URL of your image
        @imageUrl = asset.url


    # Actually load your image
    load: () ->

        img = new Image()
        img.src = @imageUrl
        img.onload = () => @fire "loaded", {}
        Rotten.TextureCache[@name] = img

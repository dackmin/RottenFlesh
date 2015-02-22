# Simple image loader
class Rotten.Loaders.ImageLoader extends Rotten.EventManager


    # Loader constructor
    # @param {String} url Image url
    constructor: (url) ->
        super

        # URL of your image
        @imageUrl = url


    # Actually load your image
    load: () ->

        img = new Image()
        img.src = @imageUrl
        img.onload = () => @fire "loaded", {}
        Rotten.TextureCache[@imageUrl] = img

class Rotten.Loaders.TiledMapLoader extends Rotten.EventManager

    constructor: (url) ->
        super

        @mapUrl = url

    load: () ->
        Rotten.Utils.ajax
            url: @mapUrl
            complete: (data) =>
                Rotten.MapCache[@mapUrl] = data
                @.fire "loaded", {}

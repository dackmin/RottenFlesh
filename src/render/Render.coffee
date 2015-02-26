class Rotten.Engine

    @CANVAS = 0
    @WEBGL = 1

    constructor: (view) ->
        if not view
            @view = document.createElement "canvas"
            @view.style.position = "absolute"
            @view.style.top = "0px"
            @view.style.left = "0px"
            @view.width = FF.Util.screenWidth()
            @view.height = FF.Util.screenHeight()
            document.body.appendChild @view
        else
            @view = view

        @width = @view.width
        @height = @view.height


    getContext: ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    getWidth: ->
        @width

    getHeight: ->
        @height

    setBackgroundColor: (color) ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    clearRect: ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    save: ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    restore: ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    translate: (x,y) ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    rotate: (angle) ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    setAlpha: (alpha) ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    drawImage: (image, x, y, width, height)->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

    drawSubImage: (image, sub_x, sub_y, sub_width, sub_height, x, y, width, height) ->
        throw new Error "[Rotten.Engine] abstract method should be implemented"

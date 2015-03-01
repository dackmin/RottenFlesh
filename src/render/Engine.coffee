class Rotten.Engine

    @CANVAS = 0
    @WEBGL = 1

    constructor: (view) ->
        if not view
            @view = document.createElement "canvas"
            @view.style.position = "absolute"
            @view.style.top = "0px"
            @view.style.left = "0px"
            @view.width = Rotten.Utils.screenWidth()
            @view.height = Rotten.Utils.screenHeight()
            document.body.appendChild @view
        else
            @view = view

        @width = @view.width
        @height = @view.height


    getContext: ->
        throw new Error "[Rotten.Engine] Your render should override getContext() method"

    getWidth: ->
        @width

    getHeight: ->
        @height

    setBackgroundColor: (color) ->
        throw new Error "[Rotten.Engine] Your render should override setBackgroundColor() method"

    clearRect: (x, y, width, height) ->
        throw new Error "[Rotten.Engine] Your render should override clearRect() method"

    save: ->
        throw new Error "[Rotten.Engine] Your render should override save() method"

    restore: ->
        throw new Error "[Rotten.Engine] Your render should override restore() method"

    translate: (x,y) ->
        throw new Error "[Rotten.Engine] Your render should override translate() method"

    rotate: (angle) ->
        throw new Error "[Rotten.Engine] Your render should override rotate() method"

    setAlpha: (alpha) ->
        throw new Error "[Rotten.Engine] Your render should override setAlpha() method"

    drawImage: (image, x, y, width, height)->
        throw new Error "[Rotten.Engine] Your render should override drawImage() method"

    drawSubImage: (image, sub_x, sub_y, sub_width, sub_height, x, y, width, height) ->
        throw new Error "[Rotten.Engine] Your render should override drawSubImage() method"

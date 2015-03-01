class Rotten.Renders.CanvasRender extends Rotten.Engine

    constructor: (view) ->
        super view

    getContext: ->
        @view.getContext "2d"

    setBackgroundColor: (color) ->
        if color is undefined or "transparent" then return

        @.getContext().save()
        @.getContext().fillStyle = color
        @.getContext().fillRect 0, 0, @width, @height
        @.getContext().restore()

    clearRect: (x, y, width, height) ->
        @.getContext().clearRect x, y, width, height

    save: ->
        @.getContext().save()

    restore: ->
        @.getContext().restore()

    translate: (x, y) ->
        @.getContext().translate x, y

    rotate: (angle) ->
        @.getContext().rotate angle

    setAlpha: (alpha) ->
        @.getContext().globalAlpha alpha

    drawImage: (image, x, y, width, height)->
        @.getContext().drawImage image, x, y, width, height

    drawSubImage: (image, sub_x, sub_y, sub_width, sub_height, x, y, width, height) ->
        @.getContext().drawImage image, sub_x, sub_y, sub_width, sub_height, x, y, width, height

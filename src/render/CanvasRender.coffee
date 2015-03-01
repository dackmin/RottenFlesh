# Basic HTML5 Canvas render
class Rotten.Renders.CanvasRender extends Rotten.Engine


    # Constructs a new graphical engine based on Canvas
    #
    # @param {String} view HTLM tag of an existing canvas
    constructor: (view) ->
        super view


    # Get the current drawing context
    #
    # @return {Object} The current context
    getContext: ->
        @view.getContext "2d"


    # Set context background color
    #
    # @param {String} color Hex color or keyword
    setBackgroundColor: (color) ->
        if color is undefined or "transparent" then return

        @.getContext().save()
        @.getContext().fillStyle = color
        @.getContext().fillRect 0, 0, @width, @height
        @.getContext().restore()


    # Clear a given zone
    #
    # @param {int} x X position of cleaning rectangle
    # @param {int} y Y position of cleaning rectangle
    # @param {int} width Width of cleaning rectangle
    # @param {int} height Height of cleaning rectangle
    clearRect: (x, y, width, height) ->
        @.getContext().clearRect x, y, width, height


    # Save current context
    save: ->
        @.getContext().save()


    # Restore saved context
    restore: ->
        @.getContext().restore()


    # Translate whole current context
    #
    # @param {int} x X translation value
    # @param {int} y Y translation value
    translate: (x, y) ->
        @.getContext().translate x, y


    # Rotate whole current context
    #
    # @param {int} angle Degrees angle
    rotate: (angle) ->
        @.getContext().rotate angle


    # Set alpha for current context
    #
    # @param {float} alpha Alpha value (from .0 to 1.0)
    setAlpha: (alpha) ->
        @.getContext().globalAlpha = alpha


    # Draw an image on context
    #
    # @param {Image} image The image you want to draw
    # @param {int} x X position of your image
    # @param {int} y Y position of your image
    # @param {int} width Width of your image
    # @param {int} height Height of your image
    drawImage: (image, x, y, width, height)->
        @.getContext().drawImage image, x, y, width, height


    # Draw a clipped image on context
    #
    # @param {Image} image Image you want to draw
    # @param {int} sub_x X position of clipping rectangle on image
    # @param {int} sub_y Y position of clipping rectangle on image
    # @param {int} sub_width Width of clipping rectangle on image
    # @param {int} sub_height Height of clipping rectangle on image
    # @param {int} x X position of clipped image on context
    # @param {int} y Y position of clipped image on context
    # @param {int} width Width of clipped image
    # @param {int} height Height of clipped image
    drawSubImage: (image, sub_x, sub_y, sub_width, sub_height, x, y, width, height) ->
        @.getContext().drawImage image, sub_x, sub_y, sub_width, sub_height, x, y, width, height


    # Used to begin a path in context
    beginPath: ->
        @.getContext().beginPath()


    # Used to clip a region defined by a path
    clip: ->
        @.getContext().clip()


    # Draw an arc (commonly used to draw circles)
    #
    # @param {int} centerX X position of the center of your arc
    # @param {int} centerY Y position of the center of your arc
    # @param {float} radius Your arc radius
    # @param {int} startAngle Radian angle on a circle where to draw your arc
    # @param {int} endAngle Radian angle where to finish your angle
    # @param {boolean} counterClockwise Optional. Specifies whether the drawing
    #                   should be counterclockwise or clockwise. False is
    #                   default, and indicates clockwise, while true indicates
    #                   counter-clockwise.
    arc: (centerX, centerY, radius, startAngle, endAngle, counterClockwise) ->
        @.getContext().arc centerX, centerY, radius, startAngle, endAngle, counterClockwise


    # Draw a rectangle
    #
    # @param {int} x X position of your rectangle
    # @param {int} y Y position of your rectangle
    # @param {int} width Width of your rectangle
    # @param {int} height Height of your rectangle
    rect: (x, y, width, height) ->
        @.getContext().rect x, y, width, height

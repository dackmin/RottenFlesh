###*
 # Represents a clipping viewport of the current scene
 # Really useful when you got a playable character and want your world to move
 # around him
 # @class Rotten.Viewport
###
class Rotten.Viewport


    ###*
     # Constructs your viewport
     # @constructor
     # @param {Rotten.Game} game - Your current game
     # @param {Object} options - { x: int, y: int, max_x: int, max_y: int, width: int, height: int }
    ###
    constructor: (@game, options) ->
        if not options then options = {}

        # X position of your viewport
        @x = options.x or 0

        # Y position of your viewport
        @y = options.y or 0

        # Max possible x position of viewport (usually end of current map)
        @max_x = options.max_x or @game.render.getWidth()

        # Max possible y position of viewport (usually end of current map)
        @max_y = options.max_y or @game.render.getHeight()

        # Viewport width
        @width = options.width or @game.render.getWidth()

        # Viewport height
        @height = options.height or @game.render.getHeight()

        # Whether viewport should actually move or not :
        # When approaching walls, viewport should not show empty zone after map
        # so basically, this avoid viewport to move if there's nothing behind
        # the current max_x & max_y
        @moving = false


    ###*
     # Move to a relative position
     # @method move
     # @param {int} x - X relative position
     # @param {int} y - Y relative position
    ###
    move: (x, y) ->
        @x+= x or 0
        @y+= y or 0

        @check()


    ###*
     # Move to an absolute position
     # @method moveTo
     # @param {int} x - X absolute position
     # @param {int} y - Y absolute position
    ###
    moveTo: (x, y) ->
        @x = x or @x
        @y = y or @y

        @check()


    centerAround: (object) ->
        @x = Math.floor object.x - @width / 2
        @y = Math.floor object.y - @height / 2

        @check()


    ###*
     # Check whether viewport should be moving or not
     # Cannot think of something more accurate than this for now
     # @TODO Find a way to make it better, lol
     # @method check
    ###
    check: ->
        moving_axis = 0

        offset_x = @max_x - @width
        offset_y = @max_y - @height

        # Check x axis
        if @x < 0 then @x = 0
        else moving_axis++

        if @x > offset_x then @x = offset_x
        else moving_axis++

        # Check y axis
        if @y < 0 then @y = 0
        else moving_axis++

        if @y > offset_y then @y = offset_y
        else moving_axis++

        # Then
        @moving = if moving_axis > 2 then true else false


    ###*
     # Draw object in viewport
     # @method draw
     # @param {Rotten.Drawable} object - Stuff to draw
    ###
    draw: (object) ->
        @game.render.save()
        @game.render.translate -@x, -@y

        if @isPartlyInside object
            object.draw()
        @game.render.restore()


    isPartlyInside: (object) ->
        rect = object.rect()
        rect.right = rect.x + rect.width
        rect.bottom = rect.y + rect.height

        return (rect.right >= @x) and (rect.x <= @x + @width) and (rect.bottom >= @y) and (rect.y <= @y + @height)

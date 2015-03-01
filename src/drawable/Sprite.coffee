# A totally classic Sprite logic made especially for games (lol)
class Rotten.Drawables.Sprite extends Rotten.Drawable


    # Constructs a new sprite
    #
    # @param {String} asset_name Name of your asset in texture cache
    # @param {Object} options Sprite options
    # @option options {int} x X position of your sprite
    # @option options {int} y Y position of your sprite
    # @option options {float} scale Scale of your sprite
    # @option options {float} rotate Angle of rotation (in degrees)
    # @option options {Object} roundClip Clipping circle
    # @option options {Object} rectClip Clipping rectangle
    # @option options {Array} anchor X & Y positions of your sprite anchor
    # @option options {float} alpha Opacity of your sprite
    # @option options {boolean} hidden Whether to show your sprite or not
    constructor: (asset_name, options) ->
        super

        # Image of your sprite
        @image = Rotten.TextureCache[asset_name] or throw new Error "[Rotten.Drawables.Sprite] You did not preloaded one of your assets (name: #{asset_name})"

        # Width of your sprite
        @width = @image.width

        # Height of your sprite
        @height = @image.height

        # X position of your sprite
        @x = options.x or 0

        # Y position of your sprite
        @y = options.y or 0

        # Scale of your sprite
        @scale = options.scale or 1.0

        # Rotation of your sprite (in degrees)
        @rotate = options.rotate or 0

        # Clipping round region from your sprite
        @roundClip = options.roundClip or false

        # Clipping rectangle region from your sprite
        @rectClip = options.rectClip or false

        # Anchor position of your sprite
        @anchor = options.anchor or [0,0]

        # Opacity of your sprite
        @alpha = options.alpha or 1.0

        # Whether your sprite is shown or not
        @hidden = options.hidden or false

        # Whether user's mouse is over your sprite or not
        @hover = false


    # Setup your sprite
    setup: ->
        # Setup is useful when you don't use class stuff with constructors
        # Only here, in sprite class, to avoid warning on missing setup override


    # Update logic of your sprite
    update: ->
        # TODO : Add hover mouse event


    # Draw your sprite
    draw: ->
        if @hidden is true then return

        # Save context
        @game.render.save()

        # Set alpha
        @game.render.setAlpha @alpha

        # Clip sprite
        if @roundClip is not false
            @game.render.beginPath()
            @game.render.arc @roundClip.x + @roundclip.width / 2, @roundClip.y + @roundClip.height / 2, @roundClip.width / 2, 0, Math.PI * 2, false
            @game.render.clip()

        else if @rectClip is not false
            @game.render.beginPath()
            @game.render.rect @rectClip.x, @rectClip.y, @rectClip.width, @rectClip.height
            @game.render.clip()

        # Rotate sprite
        @game.render.translate @x + @anchor[0], @y + @anchor[1]
        @game.render.rotate @rotate * (Math.PI / 180)
        @game.render.translate -(@x + @anchor[0]), -(@y + @anchor[1])

        # Draw sprite
        @game.render.drawImage @image, @x, @y, @width * @scale, @height * @scale

        # Restore context
        @game.render.restore()


    # Active region of your sprite
    #
    # @return {Object} Rectangle region representing your sprite
    rect: ->
        x: @x
        y: @y
        width: @width * @scale
        height: @height * @scale

###*
 # An easy to use SpriteSheet class with friendly animation system
 # @class Rotten.Drawables.SpriteSheet
 # @extends Rotten.Drawable
###
class Rotten.Drawables.SpriteSheet extends Rotten.Drawable


    ###*
     # Constructs a new spritesheet
     # @constructor
     # @param {String} asset_name - Name of your asset in texture cache
     # @param {int} frame_width - Width of one frame on your spritesheet
     # @param {int} frame_height - Height of one frame on your spritesheet
     # @param {Object} options - Spritesheet options
     # @option options {int} x - X position of your spritesheet
     # @option options {int} y - Y position of your spritesheet
     # @option options {float} scale - Scale of your spritesheet
     # @option options {float} rotate - Angle of rotation (in degrees)
     # @option options {Array} anchor - X & Y positions of your spritesheet anchor
     # @option options {float} alpha - Opacity of your spritesheet
     # @option options {boolean} hidden - Whether to show your spritesheet or not
    ###
    constructor: (asset_name, frame_width, frame_height, options) ->
        super
        if options is undefined then options = {}

        # Image of your spritesheet
        @image = Rotten.TextureCache[asset_name] or throw new Error "[Rotten.Drawables.SpriteSheet] You did not preloaded one of your assets (name: #{asset_name})"

        # Width of your spritesheet
        @sheet_width = @image.width

        # Width of your spritesheet frame
        @width = frame_width

        # Height of your spritesheet
        @sheet_height = @image.height

        # Height of your spritesheet
        @height = frame_height

        # X position of your spritesheet
        @x = options.x or 0

        # Y position of your spritesheet
        @y = options.y or 0

        # Scale of your spritesheet
        @scale = options.scale or 1.0

        # Rotation of your spritesheet (in degrees)
        @rotate = options.rotate or 0

        # Clipping round region from your spritesheet
        @roundClip = options.roundClip or false

        # Clipping rectangle region from your spritesheet
        @rectClip = options.rectClip or false

        # Anchor position of your spritesheet
        @anchor = options.anchor or [0,0]

        # Opacity of your spritesheet
        @alpha = options.alpha or 1.0

        # Whether your spritesheet is shown or not
        @hidden = options.hidden or false

        # Whether user's mouse is over your spritesheet or not
        @hover = false

        # Your spritesheet frames
        @frames = {}

        # Your spritesheet current frame
        @current_frame = 0

        # Set physics shape
        @shape = new p2.Rectangle @rect().width, @rect().height

        # Set physics body
        @body = new p2.Body
            mass: 1
            position: [@rect().x + @rect().width / 2, @rect().y + @rect().height / 2]
        @body.addShape @shape


    ###*
     # Setup your spritesheet
     # @method setup
    ###
    setup: () ->

        # Setup frames
        z = 0
        for y in [0...@sheet_height] by @height
            for x in [0...@sheet_width] by @width
                @frames[z] =
                    x: x
                    y: y
                z++


    ###*
     # Update logic of your sprite
     # @method update
    ###
    update: ->

        # Update physics
        @x = @body.position[0] - @body.shapes[0].width / 2
        @y = @body.position[1] - @body.shapes[0].height / 2
        @body.velocity[0] = @body.velocity[1] = 0

        # TODO : Add hover mouse event


    ###*
     # Draw your sprite
     # @method draw
    ###
    draw: () ->
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

        # Draw body for debug purposes
        if Rotten.Settings.DEBUG is true
            @game.render.rect @rect().x, @rect().y, @rect().width, @rect().height, "rgba(255,0,0,0.4)"

        # Draw sprite
        @game.render.drawSubImage @image,
            @frames[@current_frame].x,
            @frames[@current_frame].y,
            @width * @scale,
            @height * @scale,
            @x,
            @y,
            @width * @scale,
            @height * @scale

        # Restore context
        @game.render.restore()


    ###*
     # Active region of your sprite
     # @method rect
     # @return {Object} - Rectangle region representing your sprite
    ###
    rect: () ->
        x: @x
        y: @y
        width: @width * @scale
        height: @height * @scale

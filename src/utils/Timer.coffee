###*
 # A classic millisecond timer
 # @class Rotten.Timer
 # @extends Rotten.EventManager
 #
 # @example How to create a new timer
 #   var timer = new Rotten.Timer({ timeout: 1000, interval: 100 })
 #
###
class Rotten.Timer extends Rotten.EventManager


    ###*
     # Constructs a new timer
     # @constructor
     # @param {Object} options - Timer options
     # @option options {int} timeout - Your timeout (in milliseconds)
     # @option options {int} interval - Your interval (in milliseconds)
     # @option options {boolean} autostart - Whether you want your timer to
     #                                      autostart or not
    ###
    constructor: (options) ->

        # The timeout of your timer
        @timeout = options.timeout or 10000

        # The interval between two ticks or your timer
        @interval = options.interval or 1000

        # Whether your timer should start automatically when initialized
        @autostart = options.autostart or true

        # Whether your timer is active or not
        @active = options.autostart or true

        # Current time of your timer
        @time = 0

        # Last tick of your timer
        @lastTick = new Date()

        @.fire "start", { timeout: @timeout } if @autostart is true


    ###*
     # Updates your timer
     # If your timer was not added to a scene, update() should be called on every
     # round of your game loop (in the update queue)
     # @method update
    ###
    update: () ->
        if @active is true

            if @time >= @timeout
                @.fire "timeout", {}
                @.reset()

            if new Date() - @lastTick >= @interval
                @time+= @interval
                @.fire "tick", { current: @time, remaining: @timeout - @time, completion: parseFloat @time / @timeout }


    ###*
     # Resets your timer : Put it back to 0 & fire a "timeout" event
     # @method reset
    ###
    reset: () ->
        @time = 0
        @lastTick = new Date()
        @.fire "timeout", {}

        if @autostart is true then @.restart() else @active = false


    ###*
     # Stops your timer : nothing is counting time anymore. We are doomed.
     # @method stop
    ###
    stop: () ->
        @time = 0
        @lastTick = new Date()
        @.fire "stop", {}


    ###*
     # Restarts your timer & fires a "start" event
     # @method restart
    ###
    restart: () ->
        @time = 0
        @lastTick = new Date()
        @.fire "start", { timeout: @timeout }
        @active = true


    ###*
     # Get the remaining time of your timer
     # Useful when you're making a timed game
     # @method getRemainingTime
     # @return {float} - Remaining time
    ###
    getRemainingTime: () ->
        @timeout - @time

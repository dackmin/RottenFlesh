class Rotten.Timer extends Rotten.EventManager

    constructor: (options) ->

        @timeout = options.timeout or 10000

        @interval = options.interval or 1000

        @autostart = options.autostart or true

        @active = options.autostart or true

        @time = 0

        @lastTick = new Date()

        @.fire "start", { timeout: @timeout } if @autostart is true


    update: ->
        if @active is true

            if @time >= @timeout
                @.fire "timeout", {}
                @.reset()

            if new Date() - @lastTick >= @interval
                @time+= @interval
                @.fire "tick", { current: @time, remaining: @timeout - @time, completion: parseFloat @time / @timeout }


    reset: ->
        @time = 0
        @lastTick = new Date()
        @.fire "timeout", {}

        if @autostart is true then @.restart() else @active = false


    stop: ->
        @time = 0
        @lastTick = new Date()
        @.fire "stop", {}


    restart: ->
        @time = 0
        @lastTick = new Date()
        @.fire "start", { timeout: @timeout }
        @active = true


    getRemainingTime: ->
        @timeout - @time

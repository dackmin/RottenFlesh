###*
 # Easy-to-use animation helper for all objects extending Drawable class
 # @class Rotten.Animation
 # @extends Rotten.EventManager
###
class Rotten.Animation extends Rotten.EventManager


    ###*
     # Animation constructor
     # @constructor
     # @param {Object} item - Drawable to animate
     # @param {Object} options - Constructor options
     # @param options {int} duration - Animation easing duration
     # @param options {String} ease - Easing function
    ###
    constructor: (item, options) ->

        # Item to animate
        @item = item

        # Original item properties to be modified by animation
        @original =
            x: @item.x
            y: @item.y
            width: @item.width
            height: @item.height
            scale: @item.scale
            alpha: @item.alpha

        # Animation duration
        @duration = options.duration or 400

        # Stop animation by default (overrided by options.autostart)
        @stoped = false

        # Default easing option
        @ease = options.ease or "easeOutQuad"

        # Animation ticking timer
        @timer = new Rotten.Timer
            timeout: @duration
            interval: options.step or 10
            autostart: options.autostart or true

        # Save options in case of... an emergency. Don't ask stupid questions
        # for fuck sake.
        @options = options

        # Listen to all animation event
        @.registerEvents()


    ###*
     # Register all animation event, before it was cool
     # @method registerEvents
    ###
    registerEvents: () ->

        @timer.listen "start", (e) =>
            @.reset()
            @.fire "start", e

        @timer.listen "tick", (e) =>
            @.animate e
            @.fire "step", e

        @timer.listen "timeout", (e) =>
            @.fire "end", e

        @timer.listen "stop", (e) =>
            @.fire "stop", e


    ###*
     # Update method called after every game loop to update animations timers
     # @method update
    ###
    update: () ->
        if @stoped is false
            @timer.update()


    ###*
     # Actual method called to run an animation
     # @method animate
     # @param {Object} e - Timer event object
    ###
    animate: (e) ->
        @item.x = @.ease e.current, @original.x, (@options.x - @original.x), @duration, @ease if @options.x or @options.x is 0
        @item.y = @.ease e.current, @original.y, (@options.y - @original.y), @duration, @ease if @options.y or @options.y is 0
        @item.width = @.ease e.current, @original.width, (@options.width - @original.width), @duration, @ease if @options.width or @options.width is 0
        @item.height = @.ease e.current, @original.height, (@options.height - @original.height), @duration, @ease if @options.height or @options.height is 0
        @item.scale = @.ease e.current, @original.scale, (@options.scale - @original.scale), @duration, @ease if @options.scale or @options.scale is 0
        @item.alpha = @.ease e.current, @original.alpha, (@options.alpha - @original.alpha), @duration, @ease if @options.alpha or @options.alpha is 0


    ###*
     # Animation easing (see: http://gizma.com/easing)
     # @method ease
     # @param {int} t - Current time
     # @param {int} b - Start value
     # @param {int} c - Change in value
     # @param {int} d - Duration
     # @param {String} ease - Wanted easing method
    ###
    ease: (t, b, c, d, ease) ->
        s = 1.70158

        switch ease

            case "easeInQuad"
                c * (t/= d) * t + b

            case "easeOutQuad"
                -c * (t/= d) * (t - 2) + b

            case "easeInOutQuad"
                if (t/= d / 2) > 1
                    c  / 2 * t * t + b
                else
                    -c / 2 * ((--t) * (t - 2) - 1) + b

            case "easeInCubic"
                c * (t/= d) * t * t + b

            case "easeOutCubic"
                c * ((t = t / d - 1) * t * t + 1) + b

            case "easeInOutCubic"
                if (t/= d / 2) < 1
                    c / 2 * t * t * t + b
                else
                    c / 2 * ((t-= 2) * t * t + 2) + b

            case "easeInQuart"
                c * (t/= d) * t * t * t + b

            case "easeOutQuart"
                -c * ((t = t / d - 1) * t * t * t -1) + b

            case "easeInOutQuart"
                if (t/= d / 2) < 1
                    c / 2 * t * t * t * t + b
                else
                    -c / 2 * ((t-= 2) * t * t * t - 2) + b

            case "easeInQuint"
                c * (t/= d) * t * t * t * t + b

            case "easeOutQuint"
                c * ((t = t / d - 1) * t * t * t * t + 1) + b

            case "easeInOutQuint"
                if (t/= d / 2) < 1
                    c / 2 * t * t * t * t * t + b
                else
                    c / 2 * ((t-= 2) * t * t * t * t + 2) + b

            case "easeInSine"
                -c * Math.cos(t / d (Math.PI / 2)) + c + b

            case "easeOutSine"
                c * Math.sin(t / d * (Math.PI / 2)) + b

            case "easeInOutSine"
                -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b

            case "easeInExpo"
                if t is 0
                    b
                else
                    c * Math.pow(2, 10 * (t / d - 1)) + b

            case "easeOutExpo"
                if t is d
                    b + c
                else
                    c * (-Math.pow(2, -10 * t / d) + 1) + b

            case "easeInOutExpo"
                if t is 0 then b
                if t is d then b + c
                if (t/= d / 2) < 1 then c / 2 * Math.pow(2, 10 * (t - 1)) + b
                c / 2 * (-Math.pow(2, -10 * --t) + 2) + b

            case "easeInElastic"
                p = 0
                a = c
                if t is 0 then b
                if (t/= d) < 1 then b + c
                if not p then p = d * .3

class Rotten.Animation extends Rotten.EventManager

    constructor: (item, options) ->

        @item = item

        @original =
            x: @item.x
            y: @item.y
            width: @item.width
            height: @item.height
            scale: @item.scale
            alpha: @item.alpha

        @duration = options.duration or 400

        @stoped = false

        @ease = options.ease or "easeOutQuad"

        @timer = new Rotten.Timer
            timeout: @duration
            interval: options.step or 10
            autostart: options.autostart or true

        @options = options

        @.registerEvents()


    registerEvents: ->

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


    update: ->
        if @stoped is false
            @timer.update()


    animate: (e) ->
        @item.x = @.ease e.current, @original.x, (@options.x - @original.x), @duration, @ease if @options.x or @options.x is 0
        @item.y = @.ease e.current, @original.y, (@options.y - @original.y), @duration, @ease if @options.y or @options.y is 0
        @item.width = @.ease e.current, @original.width, (@options.width - @original.width), @duration, @ease if @options.width or @options.width is 0
        @item.height = @.ease e.current, @original.height, (@options.height - @original.height), @duration, @ease if @options.height or @options.height is 0
        @item.scale = @.ease e.current, @original.scale, (@options.scale - @original.scale), @duration, @ease if @options.scale or @options.scale is 0
        @item.alpha = @.ease e.current, @original.alpha, (@options.alpha - @original.alpha), @duration, @ease if @options.alpha or @options.alpha is 0


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

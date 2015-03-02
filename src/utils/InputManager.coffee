# A powerful input manager for all Rotten input events (even gamepads !)
class Rotten.InputManager


    # Constructs a new input manager
    #
    # @param {Rotten.Game} game Current game
    constructor: (@game) ->

        # X mouse position on screen
        @mouse_x = 0

        # Y mouse position on screen
        @mouse_y = 0

        # Currentely pressed keys
        @pressed_keys = {}

        # Previously pressed keys
        @previous_pressed_keys = {}

        # Keyboard keys as key_code => key_name
        @keyboard =
            8: "backspace"
            9: "tab"
            13: "enter"
            16: "shift"
            17: "ctrl"
            18: "alt"
            19: "pause"
            20: "capslock"
            27: "esc"
            32: "space"
            33: "pageup"
            34: "pagedown"
            35: "end"
            36: "home"
            37: "left"
            38: "up"
            39: "right"
            40: "down"
            45: "insert"
            46: "delete"
            48: "0"
            49: "1"
            50: "2"
            51: "3"
            52: "4"
            53: "5"
            54: "6"
            55: "7"
            56: "8"
            57: "9"
            65: "a"
            66: "b"
            67: "c"
            68: "d"
            69: "e"
            70: "f"
            71: "g"
            72: "h"
            73: "i"
            74: "j"
            75: "k"
            76: "l"
            77: "m"
            78: "n"
            79: "o"
            80: "p"
            81: "q"
            82: "r"
            83: "s"
            84: "t"
            85: "u"
            86: "v"
            87: "w"
            88: "x"
            89: "y"
            90: "z"
            91: "left_window_key leftwindowkey"
            92: "right_window_key rightwindowkey"
            93: "select_key selectkey"
            96: "numpad0"
            97: "numpad1"
            98: "numpad2"
            99: "numpad3"
            100: "numpad4"
            101: "numpad5"
            102: "numpad6"
            103: "numpad7"
            104: "numpad8"
            105: "numpad9"
            106: "multiply *"
            107: "add plus +"
            109: "subtract minus -"
            110: "decimalpoint"
            111: "divide /"
            112: "f1"
            113: "f2"
            114: "f3"
            115: "f4"
            116: "f5"
            117: "f6"
            118: "f7"
            119: "f8"
            120: "f9"
            121: "f10"
            122: "f11"
            123: "f12"
            144: "numlock"
            145: "scrollock"
            186: "semicolon "
            187: "equalsign ="
            188: "comma ,"
            189: "dash -"
            190: "period ."
            191: "forwardslash /"
            192: "graveaccent `"
            219: "openbracket ["
            220: "backslash \\"
            221: "closebracket ]"
            222: "singlequote '"

        # Mouse buttons as button_code => button_name
        @mouse =
            common:
                0: "left_mouse_button"
                1: "right_mouse_button"
                2: "middle_mouse_button"
            ie:
                1: "left_mouse_button"
                2: "right_mouse_button"
                4: "middle_mouse_button"

        # Gamepad buttons as button_code => button_name
        @gamepad =
            buttons:
                0: "gamepad_face_button_1"
                1: "gamepad_face_button_2"
                2: "gamepad_face_button_3"
                3: "gamepad_face_button_4"
                4: "gamepad_top_left_shoulder"
                5: "gamepad_top_right_shoulder"
                6: "gamepad_bottom_left_shoulder"
                7: "gamepad_bottom_right_shoulder"
                8: "gamepad_select"
                9: "gamepad_start"
                10: "gamepad_left_analogue_click"
                11: "gamepad_right_analogue_click"
                12: "gamepad_top"
                13: "gamepad_bottom"
                14: "gamepad_left"
                15: "gamepad_right"
            axis:
                0: "gamepad_left_x"
                1: "gamepad_left_y"
                2: "gamepad_right_x"
                3: "gamepad_right_y"

        # Registered keyboard callbacks
        @keyboard_callbacks =
            key_up: {}
            key_down: {}

        # Registered mouse callbacks
        @mouse_callbacks =
            mouse_up: {}
            mouse_down: {}
            mouse_move: (->)
            touch_start: (->)
            touch_end: (->)

        # You can set a bunch of keys for which Rotten will prevent default actions
        @prevented_keys = {}


    # Setup input manager
    setup: ->

        # Register keyboard & mice events
        window.addEventListener "keydown", @.handleKeyDown
        window.addEventListener "keyup", @.handleKeyUp
        window.addEventListener "mousedown", @.handleMouseDown, false
        window.addEventListener "mouseup", @.handleMouseUp, false
        window.addEventListener "mousemove", @.handleMouseMove, false
        window.addEventListener "touchstart", @.handleTouchStart, false
        window.addEventListener "touchend", @.handleTouchEnd, false
        window.addEventListener "blur", @.resetPressedKeys, false

        # Disable contextual menu on right click
        document.oncontextmenu = -> return false


    # Reset all pressed keys
    resetPressedKeys: ->
        @pressed_keys = {}


    # Key up event handler
    #
    # @param {Object} e Window event object
    handleKeyUp: (e) =>
        e = e or window.event

        # Keys can have several names, so we split them to see if we got smthng
        human_names = @keyboard[e.keyCode].split " "

        for key in human_names

            # Set pressed_key on false as default value for a released key
            @pressed_keys[key] = false

            # Then execute key callback if it exists
            if @keyboard_callbacks.key_up[key]
                @keyboard_callbacks.key_up[key] key
                e.preventDefault()

            # We then prevent default key action if user said so (not the same
            # than previous lines: it was prevented because there was a callback)
            if @prevented_keys[key]
                e.preventDefault()


    # Key down event handler
    #
    # @param {Object} e Window event object
    handleKeyDown: (e) =>
        e = e or window.event

        # Keys can have several names, so we split them to see if we got smthng
        human_names = @keyboard[e.keyCode].split " "

        for key in human_names

            # Set pressed_key on true as default value for a pressed key
            @pressed_keys[key] = true

            # Then execute key callback if it exists
            if @keyboard_callbacks.key_down[key]
                @keyboard_callbacks.key_down[key] key
                e.preventDefault()

            # We then prevent default key action if user said so (not the same
            # than previous lines: it was prevented because there was a callback)
            if @prevented_keys[key]
                e.preventDefault()


    # Mouse up event handler
    #
    # @param {Object} e Window event object
    handleMouseUp: (e) =>
        e = e or window.event

        # Mouse buttons too have several names
        human_name = if Rotten.Utils.getBrowserName() is "Microsoft Internet Explorer" then @mouse.ie[e.button] else @mouse.common[e.button]

        # Set the mouse button to released state
        @pressed_keys[human_name] = false

        # Then execute callback if there is one
        if @mouse_callbacks.mouse_up[human_name]
            @mouse_callbacks.mouse_up[human_name] human_name
            e.preventDefault()

        # See handleKeyDown handler for more infos
        if @prevented_keys[human_name]
            e.preventDefault()


    # Mouse down event handler
    #
    # @param {Object} e Window event object
    handleMouseDown: (e) =>
        e = e or window.event

        # Mouse buttons too have several names
        human_name = if Rotten.Utils.getBrowserName() is "Microsoft Internet Explorer" then @mouse.ie[e.button] else @mouse.common[e.button]

        # Set the mouse button to released state
        @pressed_keys[human_name] = true

        # Then execute callback if there is one
        if @mouse_callbacks.mouse_down[human_name]
            @mouse_callbacks.mouse_down[human_name] human_name
            e.preventDefault()

        # See handleKeyDown handler for more infos
        if @prevented_keys[human_name]
            e.preventDefault()


    # Mouse move event handler
    #
    # @param {Object} e Window event object
    handleMouseMove: (e) =>
        e = e or window.event

        # Update mouse position
        if e.pageX or e.pageY
            @mouse_x = e.pageX
            @mouse_y = e.pageY
        else
            @mouse_x = e.clientX + (document.documentElement.scrollLeft or document.body.scrollLeft) - document.documentElement.clientLeft
            @mouse_y = e.clientY + (document.documentElement.scrollTop or document.body.scrollTop) - document.documentElement.clientTop

        # Execute callback
        @mouse_callbacks.mouse_move { x: @mouse_x, y: @mouse_y } if @mouse_callbacks.mouse_move is not null


    # Touche start handle
    #
    # @param {Object} e Window event object
    handleTouchStart: (e) =>
        e = e or window.event

        # Force left mouse button to be pressed (see it as a finger here)
        @pressed_keys["left_mouse_button"] = true

        # Update mouse position with finger position on screen
        @mouse_x = e.touches[0].pageX - @game.render.view.offsetLeft
        @mouse_y = e.touches[0].pageY - @game.render.view.offsetTop


    # Touche end handle
    #
    # @param {Object} e Window event object
    handleTouchEnd: (e) =>
        e = e or window.event

        # Force left mouse button to be released
        @pressed_keys["left_mouse_button"] = false

        # Reset mouse position
        @mouse_x = undefined
        @mouse_y = undefined


    # Manually prevent default behavior for some keys
    #
    # @param {Array} keys Array of human key names (ie. "left_mouse_button")
    preventDefaultKeys: (keys) ->
        @prevented_keys[key] = true for key in keys


    # Check if a key or button is pressed
    #
    # @param {Array} keys Array of human key names (ie. "left_mouse_button")
    # @param {boolean} every Whether you want all the keys to be checked or only some of them
    # @return {boolean} true if your key(s) is(are) pressed, false otherwise
    pressed: (keys, every) ->
        if every is true
            keys.every ( (key) => @pressed_keys[key] )
        else
            keys.some ( (key) => @pressed_keys[key] )


    # Same as pressed() but for a non repeated call to a key
    # TODO : Better handle of every & some
    #
    # @param {Array} keys Array of human key names (ie. "left_mouse_button")
    # @param {boolean} every Whether you want all the keys to be checked or only some of them
    # @return {boolean} true if your key(s) is(are) pressed, false otherwise
    pressedWithoutRepeat: (keys, every) ->
        if @pressed keys,every is true
            @previous_pressed_keys[key] = true for key in keys
            true
        else
            @previous_pressed_keys[keys] = false for key in keys
            false


    # Register on key up event callback
    #
    # @param {Array} keys Array of human key names (ie. "left_mouse_button")
    # @param {Function} cb Callback handler
    onKeyUp: (keys, cb) ->
        @keyboard_callbacks.key_up[key] = cb for key in keys


    # Register on key down event callback
    #
    # @param {Array} keys Array of human key names (ie. "left_mouse_button")
    # @param {Function} cb Callback handler
    onKeyDown: (keys, cb) ->
        @keyboard_callbacks.key_down[key] = cb for key in keys


    # Register mouse up event callback
    #
    # @param {Array} buttons Array of human button names (ie. "left_mouse_button")
    # @param {Function} cb Callback handler
    onMouseUp: (buttons, cb) ->
        @mouse_callbacks.mouse_up[button] = cb for button in buttons


    # Register mouse down event callback
    #
    # @param {Array} buttons Array of human button names (ie. "left_mouse_button")
    # @param {Function} cb Callback handler
    onMouseDown: (buttons, cb) ->
        @mouse_callbacks.mouse_down[button] = cb for button in buttons


    # Register mouse move event callback
    #
    # @param {Function} cb Callback handler
    onMouseMove: (cb) ->
        @mouse_callbacks.mouse_move = cb


    # Register touch start event callback
    #
    # @param {Function} cb Callback handler
    onTouchStart: (cb) ->
        @mouse_callbacks.touch_start = cb


    # Register touch end event callback
    #
    # @param {Function} cb Callback handler
    onTouchEnd: (cb) ->
        @mouse_callbacks.touch_end = cb


    # TODO
    getGamepads: ->


    # TODO
    checkGamepadButtons: ->


    # TODO
    getCurrentConnectedGamepad: ->


    # TODO
    isThereAGamepadDoctor: ->

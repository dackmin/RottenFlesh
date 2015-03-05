# Static class containing all Rotten utilities
# You can use them as much as you need, but be careful they are only made for
# Rotten stuff to work as intended. They are not bulletproof.
class Rotten.Utils


    # Used by ajax() method to get a polyfilled ajax request
    #
    # @return {Object} working XMLHttpRequest object
    @getXMLHttpRequest: ->
        if window.XMLHttpRequest then new XMLHttpRequest() else new ActiveXObject "Microsoft.XMLHTTP"


    # Same ajax method than the one you know from jQuery - maybe a bit condensed
    #
    # @param {Object} options Request options
    # @option options {String} type HTTP Request type (default: GET)
    # @option options {boolean} async Whether you want to do an async request or not (default: true)
    # @option options {String} url Request URL (default: "")
    # @option options {boolean} json If you want a JSON parsed response (default: true)
    # @option options {Function} complete What to do when response is here
    @ajax: (options) ->
        type = options.type or "GET"
        async = options.async or true
        url = options.url or ""
        json = options.json or true
        complete = options.complete or (->)
        xhr = Rotten.Utils.getXMLHttpRequest()

        xhr.onreadystatechange = () ->
            if xhr.readyState is 4
                complete if json then JSON.parse xhr.responseText else xhr.responseText

        xhr.open type, url, async
        xhr.send()


    # Polyfill for actual browser viewport size
    #
    # @return {Object} Width and height of screen
    @screenSize: ->
        if not window.innerWidth
            if document.documentElement.clientWidth is not 0
                width: document.documentElement.clientWidth
                height: document.documentElement.clientHeight

            else
                width: document.body.clientWidth
                height: document.body.clientHeight

        else
            width: window.innerWidth;
            height: window.innerHeight;


    # Get screen width
    #
    # @return {int} Screen width
    @screenWidth: ->
        Rotten.Utils.screenSize().width


    # Get screen height
    #
    # @return {int} Screen height
    @screenHeight: ->
        Rotten.Utils.screenSize().height


    # Get your browser app name (not bulletproof at all, fell free to do better)
    #
    # @return {String} Browser app name
    @getBrowserName: ->
        navigator.appName


    # Extends any class properties or methods simply
    #
    # @param {Object} child The one that receives everything
    # @param {Object} child The one that gives everything
    # @return {Object} The child, extended
    @extends: (child, parent) ->
        for key in parent
            if parent.hasOwnProperty key
                child[key] = parent[key]
        ctor = ->
            @constructor = child

        ctor.prototype = parent.prototype
        child.prototype = new ctor()
        child.__super__ = parent.prototype

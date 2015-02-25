class Rotten.Utils

    @getXMLHttpRequest: () ->
	    if window.XMLHttpRequest then new XMLHttpRequest() else new ActiveXObject "Microsoft.XMLHTTP"

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

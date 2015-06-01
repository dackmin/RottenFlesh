# http://paulirish.com/2011/requestanimationframe-for-smart-animating/
# http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating
#
# requestAnimationFrame polyfill by Erik Möller
# fixes from Paul Irish and Tino Zijdel
lastTime = 0
vendors = ['ms', 'moz', 'webkit', 'o']
x = 0

for vendor in vendors
    break if window.requestAnimationFrame is not undefined
    window.requestAnimationFrame = window["#{vendor}RequestAnimationFrame"]
    window.cancelAnimationFrame = window["#{vendor}CancelAnimationFrame"] or window["#{vendor}CancelRequestAnimationFrame"]

if window.requestAnimationFrame is undefined
    window.requestAnimationFrame = (callback, element) ->
        currTime = new Date().getTime()
        timeToCall = Math.max 0, 16 - (currTime - lastTime)
        lastTime = currTime + timeToCall
        window.setTimeout (-> callback currTime + timeToCall), timeToCall

if window.cancelAnimationFrame is undefined
    window.cancelAnimationFrame = (id) ->
        clearTimeout id

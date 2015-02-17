# http://paulirish.com/2011/requestanimationframe-for-smart-animating/
# http://my.opera.com/emoller/blog/2011/12/20/requestanimationframe-for-smart-er-animating
#
# requestAnimationFrame polyfill by Erik Möller
# fixes from Paul Irish and Tino Zijdel
#
lastTime = 0
vendors = ['ms', 'moz', 'webkit', 'o']
x = 0

loop
	window.requestAnimationFrame = window["#{vendors[x]}RequestAnimationFrame"]
	window.cancelAnimationFrame = window["#{vendors[x]}CancelAnimationFrame"] or window["#{vendors[x]}CancelRequestAnimationFrame"]
	++x
	break if x >= vendors.length or window.requestAnimationFrame is not undefined


if window.requestAnimationFrame is undefined then
	window.requestAnimationFrame = (callback, element) ->
		currTime = new Date().getTime()
		timeToCall = Math.max 0, 16 - (currTime - lastTime)
		id = window.setTimeout (-> callback currTime + timeToCall) timeToCall
		lastTime = currTime + timeToCall
		return id

if window.cancelAnimationFrame is undefined then
	window.cancelAnimationFrame = (id) ->
		clearTimeout id

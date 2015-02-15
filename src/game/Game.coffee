# Main RottenFlesh entry point
# Everything happens here, beware of watcha doin here mate
#
# @example How to create a new game
#	game = new Rotten.Game({ render: Rotten.Render.CANVAS });
#
class Rotten.Game


	# Constructs a new RottenFlesh game
	#
	# @param {Object} options Game options
	# @option options {String} render Render (default: Rotten.Render.CANVAS)
	# @option options {String} background Background color (default: #000)
	# @option options {Object} canvas You can use a custom canvas to draw in
	#
	constructor: (options) ->

		# Represents all the scenes (or game states) of the game
		@scenes = {}

		# The current played scene
		@currentScene = null

		# The previous used scene (in case you called switchScene)
		@lastScene = null

		# The game background color
		@backgroundColor = options.background || "#000"

		# Current game fps
		@fps = 0

		# Custom canvas
		@render = new Rotten.Render options.render||Rotten.Render.CANVAS options.canvas


	# Add a scene to your game (a config screen, a start screen, ...)
	# and set it as default if default scene is null
	#
	# @param {String} name The name of your scene (to retrieve it later)
	# @param {Rotten.Scene} scene Your scene
	#
	addScene: (name, scene) ->
		@scenes[name] = scene
		if @currentScene is null then @currentScene = @scenes[name]


	# Start your game with a scene name. If no scene name is provided,
	start: (sceneName) ->
		if sceneName is not null then @currentScene = @scenes[name]
		if @currentScene is not null then return

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
	constructor: (options) ->

		# Represents all the scenes (or game states) of the game
		@scenes = {}

		# The current played scene
		@currentScene = null

		# The previous used scene (in case you called switchScene)
		@lastScene = null

		# The game background color
		@backgroundColor = if options and options.background then options.background else "#000"

		# Current game fps
		@fps = 0

		# Last game loop
		@lastLoop = null

		# Custom canvas
		@render = if options and options.render is Rotten.Engine.WEBGL2D then Rotten.Renders.WebGL2DRender else Rotten.Renders.CanvasRender
		@render = new @render if options and options.canvas then options.canvas else null

		# Game assets manager
		@assetManager = new Rotten.AssetLoader()

		# Main game loop : Due to coffee script scope problems, I had to put
		# that here
		@requestAnimation = () =>
			@currentScene.update()
			@currentScene.draw()

			if @lastLoop is null
				@lastLoop = new Date().getTime()
				requestAnimationFrame @requestAnimation
				return

			delta = (new Date().getTime() - @lastLoop) / 1000
			@lastLoop = new Date().getTime()
			@fps = (1 / delta).toFixed 1

			requestAnimationFrame @requestAnimation


	# Add a scene to your game (a config screen, a start screen, ...)
	# and set it as default if default scene is null
	#
	# @param {String} name The name of your scene (to retrieve it later)
	# @param {Rotten.Scene} scene Your scene
	addScene: (name, scene) ->
		if scene.update is undefined then console.warn "[Rotten.Game.addScene] You should add an .update() method in your scene to update objects"
		if scene.draw is undefined then console.warn "[Rotten.Game.addScene] You should add a .draw() method in your scene to draw objects"

		@scenes[name] = scene
		if @currentScene is null then @currentScene = @scenes[name]


	# Start your game with a scene name. If no scene name is provided, then
	# the first scene in game is used
	#
	# @param {String} sceneName Your scene name
	start: (sceneName) ->
		if sceneName is not undefined then @currentScene = @scenes[name]
		if @currentScene is undefined or null then return

		@currentScene.setup()
		@requestAnimation()

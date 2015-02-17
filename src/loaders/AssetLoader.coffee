# Global asset loader
#
# @example How to create an asset loader lol
#   loader = new Rotten.AssetLoader([
#		"img/sprite.png"
#   ]);
class Rotten.AssetLoader extends Rotten.EventManager


	# Constructs an asset loader
	# @param {Array} assets The assets you want to load
	constructor: (assets) ->

		# Assets to load
		@assets = assets

		# Loaded assets count
		@loaded = 0

		# Supported assets types
		@assetsTypes =
			jpg: Rotten.Loaders.ImageLoader
			jpeg: Rotten.Loaders.ImageLoader
			gif: Rotten.Loaders.ImageLoader
			png: Rotten.Loaders.ImageLoader
			fnt: Rotten.Loaders.BitmapFontLoader
			json: Rotten.Loaders.TiledMapLoader
			mp3: Rotten.Loaders.AudioLoader


	# Starts to load all the assets
	load: () ->
		for asset in @assets
			filetype = (asset.split ".").pop().toLowerCase()
			loader = @assetsTypes[filetype] or throw new Error "[Rotten.AssetLoader] Filetype '#{filetype}' is not supported"
			loader = new loader asset
			loader.listen "loaded", (-> @.assetLoaded asset)


	# Called when an asset has just been loaded
	# @param {String} filename Name of the current loaded file
	assetLoaded: (filename) ->
		@loaded++
		@.fire "progress", { loaded: @loaded, total: @assets.length, current: filename }
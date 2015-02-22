module.exports = function(grunt) {

	grunt.initConfig({

		// Coffee build
		coffee: {
			build: {
				options: {
					join: true,
					bare: true
				},
				files: {
					'build/rotten-flesh.js': [

						// Main app file
						'src/Main.coffee',

						// Utils
						'src/utils/Utils.coffee',
						'src/utils/Vendors.coffee',
						'src/utils/EventManager.coffee',

						// Loaders
						'src/loaders/ImageLoader.coffee',
						'src/loaders/AssetLoader.coffee',
					]
				}
			}
		},


		// Uglify stuff
		uglify: {
			options: {
				mangle: false,
			},
			target: {
				files: {
					"build/rotten-flesh.min.js": "build/rotten-flesh.js"
				}
			}
		},


		// Watch task
		watch: {
			coffeeScripts: {
				files: "src/**/*.coffee",
				tasks: "coffee:build"
			},

			gruntfile: {
				files: ['Gruntfile.js'],
				tasks: "coffee:build"
			}
		}
	});

	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-watch');

	grunt.registerTask("build", [
		"coffee:build"
	]);

	grunt.registerTask("dist", [
		"coffee:build",
		"uglify"
	]);

	grunt.registerTask("listen", [
		"coffee:build",
		"watch"
	]);

	grunt.registerTask("test", [

	]);

};

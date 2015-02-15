module.exports = function(grunt) {

	grunt.initConfig({

		// Coffee build
		coffee: {
			build: {
				options: {
					join: true
				},
				files: {
					'build/rotten-flesh.js': 'src/**/*.coffee'
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
				files: ['Gruntfile.js']
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

	grunt.registerTask("test", [

	]);

};

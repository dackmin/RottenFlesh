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
                        'src/utils/InputManager.coffee',

                        // Renders
                        'src/render/Engine.coffee',
                        'src/render/CanvasRender.coffee',
                        'src/render/WebGL2DRender.coffee',

                        // Loaders
                        'src/loaders/ImageLoader.coffee',
                        'src/loaders/TiledMapLoader.coffee',
                        'src/loaders/AssetLoader.coffee',

                        // Drawables
                        'src/drawable/Drawable.coffee',
                        'src/drawable/TiledMap.coffee',
                        'src/drawable/Sprite.coffee',
                        'src/drawable/SpriteSheet.coffee',

                        // Game
                        'src/game/Game.coffee',
                        'src/game/Viewport.coffee',
                        'src/game/Scene.coffee',
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
                tasks: "coffee:build",
                options: { livereload: '<%= connect.options.livereload %>' }
            },

            gruntfile: {
                files: ['Gruntfile.js'],
                tasks: "coffee:build"
            },

            options: {
                livereload: '<%= connect.options.livereload %>',
                files: ["build/*.js","examples/*/*.html"]
            }
        },


        //Serve task
        connect: {
            options: {
                port: 35565,
                hostname: "localhost",
                livereload: 35566
            },

            livereload: {
                options: {
                    open: true,
                    middleware: function (connect) {
                        return [
                            connect.static('examples'),
                            connect().use('/build', connect.static('./build'))
                        ];
                    }
                }
            }
        },

        // Test settings
        karma: {
            unit: {
                configFile: 'tests/karma.conf.coffee',
                singleRun: true
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-karma');

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

    grunt.registerTask("serve", "", function(){
        grunt.task.run([
            "coffee:build",
            "connect:livereload",
            "watch"
        ]);
    });

    grunt.registerTask("test", [
        "build",
        "karma"
    ]);

};

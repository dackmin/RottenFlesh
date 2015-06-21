"use strict"

describe "Class: Rotten.Game", ->

    game = new Rotten.Game()
    scene = new Rotten.Scene game

    # .constructor
    it "should have a list of scenes", ->
        expect(Object.keys(game.scenes).length).toBe 0

    it "should init a default render", ->
        expect(game.render).not.toBe null

    it "should init an asset manager", ->
        expect(game.assetManager).not.toBe null

    it "should init an input manager", ->
        expect(game.inputs).not.toBe null

    it "should init a requestAnimationFrame call", ->
        expect(game.requestAnimation).not.toBe undefined


    # .addScene()
    it "should have a scene named 'main'", ->
        game.addScene "main", scene
        expect(game.scenes["main"]).not.toBe undefined

    it "should have 'main' scene as currentScene", ->
        expect(game.currentScene).not.toBe null

    # .start()
    it "should return true if game has started", ->
        expect(game.start "main").toBe true

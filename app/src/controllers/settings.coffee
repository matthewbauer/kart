_ = require 'underscore'
Spine._ = require 'underscore'
$      = Spine.$

fsUtils = require '../lib/fs-utils'
dialog = require('remote').require('dialog')

class Settings extends Spine.Controller
  className: 'app-settings'

  elements:
    '#retroarch_path': 'retroarchPathInput'
    '#roms_path': 'romsPathInput'

  events:
    'click #retroarch_path_button': 'browseRetroarchPath'
    'click #roms_path_button': 'browseRomsPath'
    'click .settings-button': 'showMain'

  constructor: ->
    super

    @settings = new App.Settings

    @build()
    @render()

  render: ->
    @html @view 'main/settings', @

  showMain: ->
    app.showMain()

  build: ->
    @retroarchPathInput.html(@settings.retroarchPath())
    @romsPathInput.html(@settings.romsPath())

  browseRetroarchPath: (e) ->
    path = dialog.showOpenDialog({ title: 'Retroarch Path', properties: [ 'openDirectory' ]})
    if path
      @settings.setRetroarchPath(path)
      @build()

  browseRomsPath: (e) ->
    path = dialog.showOpenDialog({ title: 'Roms Path', properties: [ 'openDirectory' ]})
    if path
      @settings.setRomsPath(path)
      @build()

  keyboardNav: (e) ->

    switch e.keyCode
      when KeyCodes.esc
        app.showMain()
        e.preventDefault()

module.exports = Settings
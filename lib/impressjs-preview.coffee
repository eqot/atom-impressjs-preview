ImpressjsPreviewView = require './impressjs-preview-view'

module.exports =
  impressjsPreviewView: null

  activate: (state) ->
    @impressjsPreviewView = new ImpressjsPreviewView(state.impressjsPreviewViewState)

  deactivate: ->
    @impressjsPreviewView.destroy()

  serialize: ->
    impressjsPreviewViewState: @impressjsPreviewView.serialize()

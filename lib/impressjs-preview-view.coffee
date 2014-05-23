{View} = require 'atom'

module.exports =
class ImpressjsPreviewView extends View
  @content: ->
    @div class: 'impressjs-preview overlay from-top', =>
      @div "The ImpressjsPreview package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "impressjs-preview:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "ImpressjsPreviewView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)

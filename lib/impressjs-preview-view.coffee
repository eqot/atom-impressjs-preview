{View} = require 'atom'

fs = require 'fs'

require './ext/impress.js'
impress = window.impress

module.exports =
class ImpressjsPreviewView extends View
  @content: ->
    @div class: 'impressjs-preview native-key-bindings', tabindex: -1

  @editorId: null

  initialize: (arg) ->
    @editorId = arg.editorId
    if @editorId?
      @resolveEditor(@editorId)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  resolveEditor: (editorId) ->
    resolve = =>
      @editor = @editorForId(editorId)

    if atom.workspace?
      resolve()

  editorForId: (editorId) ->
    for editor in atom.workspace.getEditors()
      return editor if editor.id?.toString() is editorId.toString()
    null

  getTitle: ->
    return 'impressjs-preview'

  getUri: ->
    return 'impressjs-preview://editor/' + @editorId

  render: ->
    content = @editor.getText()
    @html(content)

    impress().init()

{View} = require 'atom'

module.exports =
class ImpressjsPreviewView extends View
  @content: ->
    @div 'This is a test.'

  @editorId: null

  initialize: (arg) ->
    @editorId = arg.editorId

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  getTitle: ->
    return 'impressjs-preview'

  getUri: ->
    return 'impressjs-preview://editor/' + @editorId

  render: ->
    return

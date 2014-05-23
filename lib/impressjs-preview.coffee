ImpressjsPreviewView = require './impressjs-preview-view'

url = require 'url'

module.exports =
  impressjsPreviewView: null

  activate: (state) ->
    atom.workspaceView.command "impressjs-preview:toggle", => @toggle()

    return atom.workspace.registerOpener (uriToOpen) ->
      uri = url.parse uriToOpen

      if uri.protocol isnt 'impressjs-preview:'
        return

      if uri.host is 'editor'
        return new ImpressjsPreviewView {
          editorId: uri.pathname.substring 1
        }
      else
        return new ImpressjsPreviewView {
          fliePath: uri.pathname
        }

  deactivate: ->
    @impressjsPreviewView?.destroy()

  serialize: ->
    impressjsPreviewViewState: @impressjsPreviewView?.serialize()

  toggle: ->
    console.log "ImpressjsPreviewView was toggled!"

    editor = atom.workspace.getActiveEditor()
    if editor is null
      returns

    uri = 'impressjs-preview://editor/' + editor.id
    previewPane = atom.workspace.paneForUri uri
    if previewPane?
      previewPane.destroyItem(previewPane.itemForUri uri)
      return

    previousActivePane = atom.workspace.getActivePane()
    return atom.workspace.open(uri, {
      split: 'right',
      searchAllPanes: true
    }).done (impressjsPreviewView) =>
      if (impressjsPreviewView instanceof ImpressjsPreviewView)
        impressjsPreviewView.render()
        return previousActivePane.activate();

{WorkspaceView} = require 'atom'
ImpressjsPreview = require '../lib/impressjs-preview'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ImpressjsPreview", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('impressjs-preview')

  describe "when the impressjs-preview:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.impressjs-preview')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'impressjs-preview:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.impressjs-preview')).toExist()
        atom.workspaceView.trigger 'impressjs-preview:toggle'
        expect(atom.workspaceView.find('.impressjs-preview')).not.toExist()

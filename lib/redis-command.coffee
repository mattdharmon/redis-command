{CompositeDisposable} = require 'atom'
# KeysView = require './views/results-view'

module.exports =
  activate: ->
    Keys = require './commands/keys'

    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', 'redis-command:keys', => @create Keys()

  create: (view) ->
    @view view
    @toggle()

  destroy: ->
    @resultsPanel.destroy()
    @subscriptions.dispose()
    @resultsView.destroy()

  view: (view) ->
    return if @resultsView?

    @resultsView = view

    @resultsPanel = atom.workspace.addBottomPanel(item: @resultsView.getContent(), visible: false)

    @resultsPanel.onDidChangeVisible (visible) =>
      if not visible
        @resultsView.destroy()
        @resultsView = null

  toggle: ->
    if @resultsPanel.isVisible()
      @resultsPanel.hide()
    else
      @resultsPanel.show()

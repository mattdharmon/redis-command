RedisCommandView = require './redis-command-view'
{CompositeDisposable} = require 'atom'

module.exports = RedisCommand =
  redisCommandView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @redisCommandView = new RedisCommandView(state.redisCommandViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @redisCommandView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'redis-command:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @redisCommandView.destroy()

  serialize: ->
    redisCommandViewState: @redisCommandView.serialize()

  toggle: ->
    console.log 'RedisCommand was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()

module.exports =
class RedisCommandView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('redis-command')

    # Create message element
    Redis = require 'redis'
    client = Redis.createClient()
    client.keys "*", (err, keys) =>
      for key in keys
        do (key) ->
        message = document.createElement('div')
        client.type key, (err, type) =>
          message.textContent = key + " : " + type
          message.setAttribute 'data-key', key
          message.setAttribute 'data-type', type
          message.classList.add('message')
          @element.appendChild(message)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

Redis = require 'redis'

module.exports =
class FindView
  constructor: ->
    @element = document.createElement('div')
    @element.classList.add('redis-command')

    client = Redis.createClient()

    client.keys '*', (err, keys) =>
      for key in keys
        do (key) =>
          client.type key, (err, type) =>
            message = document.createElement('div')
            message.textContent = key + " : " + type
            message.setAttribute 'data-key', key
            message.setAttribute 'data-type', type
            message.classList.add('message')
            @element.appendChild(message)
      client.quit()

  destroy: ->
    @element.remove()

  getContent: ->
    @element

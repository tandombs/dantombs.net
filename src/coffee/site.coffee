class window.Site

  constructor: (url = '') ->
    @url = url
    @response = @fetch()

  # Send the site through the readability API using Yahoo pipes.
  fetch: =>
    $.getJSON 'http://pipes.yahoo.com/pipes/pipe.run?_callback=?',
      url: @url
      _id: '4b4d3ea82bfcdbe9b6daca620fc989d3'
      _render: 'json'
    .pipe (response) -> response.value.items[0]

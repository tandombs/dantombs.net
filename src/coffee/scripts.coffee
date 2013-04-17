class window.DT

  constructor: ->
    @imagePath = 'images/'
    @remoteURLs = URLs
    @images = images
    

    @remoteSites = []

  # Returns an amount of milliseconds.
  # Takes min/max arguemnents in seconds.
  getDuration: (min = 0, max = 10) -> Math.floor(Math.random() * (max * 1000)) + (min * 1000)

  getSite: =>
    siteIndex = Math.floor(Math.random() * @remoteURLs.length)
    @remoteSites[siteIndex] = @fetch(@remoteURLs[siteIndex]) unless @remoteSites[siteIndex]
    @remoteSites[siteIndex]

  fetch: (url) ->
    $.getJSON 'http://pipes.yahoo.com/pipes/pipe.run?_callback=?',
      url: url
      _id: '4b4d3ea82bfcdbe9b6daca620fc989d3'
      _render: 'json'

  showNext: =>
    @getSite().done (response) => 
      if response.value.items[0]?.content?
        $el = $("<a class='site' href='#{response.value.items[0]?.url}'/>").html $('<div />')
          .html(response.value.items[0].content)
          .jrumble({
            x: Math.floor(Math.random()*3),
            y: Math.floor(Math.random()*3),
            rotation: 0,
            speed: Math.random()*10,
            opacity: true,
            opacityMin: Math.random()
          })
          .trigger('startRumble')
        $el.css({
            "top": "#{100-(Math.random()*200)}%",
            "left": "#{100-(Math.random()*200)}%",
            "right": "#{100-(Math.random()*200)}%"
          })
          .animate({
            "right": "#{Math.random()*50}%"
          }, @getDuration 0.001, 1, 'linear')
        $('body').css('background-image', "url(#{@imagePath}#{@images[Math.floor(Math.random()*@images.length)]})").append $el
        setTimeout  -> $el.remove(), 
        @getDuration 0.5, 2
        setTimeout dt.showNext, @getDuration 0, 1
      else
        dt.showNext()

$ -> 
  window.dt = new DT()
  $('#contact')
    .jrumble({
      x: 0,
      y: 0,
      rotation: 0.05,
      speed: 10,
      opacity: true
    })
    .trigger('startRumble')
  dt.showNext()
class window.Dan

  constructor: (urls = [], images = []) ->
    @urlCount = urls.length

    @sites = new Sites urls

    @imagePath = 'images/'
    @images = images

  getSite: => @sites.get Math.floor(Math.random() * @urlCount)

  # Returns an amount of milliseconds.
  # Takes min/max arguemnents in seconds.
  getDuration: (min = 0, max = 10) -> Math.floor(Math.random() * (max * 1000)) + (min * 1000)

  renderSite: (response) =>
    if response
      $inner = $('<div />').html(response.content).jrumble({
        x: Math.floor(Math.random()*3),
        y: Math.floor(Math.random()*3),
        rotation: 0,
        speed: Math.random()*10,
        opacity: true,
        opacityMin: Math.random()
      })
      $el = $("<a class='site' href='#{response.url}'/>").css({
        "top": "#{100-(Math.random()*200)}%",
        "left": "#{100-(Math.random()*200)}%",
        "right": "#{100-(Math.random()*200)}%"
      }).html($inner)
      $('body').css('background-image', "url(#{@imagePath}#{@images[Math.floor(Math.random()*@images.length)]})").append $el 
      $inner.trigger('startRumble')
      $el.animate({
        "right": "#{Math.random()*50}%"
      }, @getDuration 0.001, 1, 'linear')
      setTimeout (-> $el.trigger('stopRumble').remove()), @getDuration 0.5, 2
      setTimeout @doIt, @getDuration 0, 1
    else
      @doIt()

  doIt: =>
    site = @getSite()
    site.response.done @renderSite

  init: =>
    delay = @getDuration(3, 5)

    setTimeout ->
      $('#prefill').addClass 'site'
      $('#nav').jrumble({
        x: 0,
        y: 0,
        rotation: 0.05,
        speed: 10,
        opacity: true
      }).trigger('startRumble')
    , delay

    setTimeout =>
      $('#prefill').animate({
        "right": "#{30+Math.random()*50}%"
      }, @getDuration(3, 5), 'swing', =>
        @doIt()
        setTimeout (-> $('#prefill').remove()), @getDuration 0.5, 2
      )
    , delay + @getDuration 3, 5
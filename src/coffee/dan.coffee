class window.Dan

  constructor: (urls = [], images = []) ->
    @urls = urls
    @urlCount = urls.length

    @sites = []

    @imagePath = 'images/'
    @images = images

  ### 
  TO DO - ensure a maximum number of sites are shown at any one time.
  Currently, new sites are added faster than they are removed.
  ###
  showSite: =>
    site = new Site @pickURL()
    site.show()
    setTimeout @showSite, Math.floor(Math.random() * 1000)

  pickURL: => @urls[Math.floor(Math.random() * @urlCount)]



class Site

  constructor: (url) ->
    @url = url

    @el = document.createElement 'a'
    @el.className = 'site'
    @el.addEventListener 'data:fetched', @render

    ### 
    TO DO - cache responses.
    Currently, sites request the readability documents each time they are shown.
    ###
    @fetched = false
    @fetch()

  render: (e) =>
    @el.removeEventListener 'data:fetched', @render
    @el.innerHTML = e.detail.content
    @removeAfter @resize()

  # Inserts a new script element load the JSONP for this site.
  # Inserts callback method on `window` that announces the response and removes itself plus the loader script element.
  fetch: =>
    jsonpRef = "jsonp#{Date.now()}"

    window[jsonpRef] = (response) =>
      if response.value?.items[0]?
        @fetched = true
        @el.dispatchEvent new CustomEvent('data:fetched', detail: response.value.items[0])
      else
        console.log "JSONP failure", @url, response
      document.body.removeChild document.getElementById jsonpRef
      window[jsonpRef] = null

    script = document.createElement 'script'
    script.setAttribute 'id', jsonpRef
    script.src = "http://pipes.yahoo.com/pipes/pipe.run?_render=json&_id=4b4d3ea82bfcdbe9b6daca620fc989d3&url=#{encodeURIComponent(@url)}&_callback=#{jsonpRef}"
    document.body.appendChild script

  position: =>   
    @el.style.top = "#{parseInt(100-(Math.random()*200))}%"
    @el.style.left = "#{parseInt(100-(Math.random()*200))}%"
    @el.style.right = "#{parseInt(100-(Math.random()*200))}%"

  show: =>
    @position()
    @startJiggling()
    document.body.appendChild @el
    @removeAfter @resize() if @fetched

  remove: => 
    document.body.removeChild @el
    @stopJiggling()

  removeAfter: (delay = 1000) => 
    setTimeout @remove, delay + @getDuration 0, 2000

  jiggle: (minOpacity = 0.5, maxMovement = Math.floor(Math.random()*3)) =>    
    @el.style.transform = @el.style.webkitTransform = "translate(
      #{Math.floor(Math.random()*((2*maxMovement)+1))-maxMovement}px,
      #{Math.floor(Math.random()*((2*maxMovement)+1))-maxMovement}px
    )"
    @el.style.opacity = (Math.random()*minOpacity)+minOpacity
    @rAF = requestAnimationFrame @jiggle

  startJiggling: =>
    @jiggle()

  stopJiggling: =>
    cancelAnimationFrame @rAF

  resize: =>
    transitionDuration = @getDuration 10, 1000
    transitionDelay = @getDuration 1000, 2000
    @el.style.webkitTransitionDuration = @el.style.transitionDuration = "#{transitionDuration}ms"
    @el.style.webkitTransitionDelay = @el.style.transitionDelay = "#{transitionDelay}ms"
    @el.style.right = "#{parseInt(Math.random()*50)}%"
    transitionDuration + transitionDelay

  # Returns an random amount of ms between min/max arguemnents.
  getDuration: (min = 0, max = 1000) -> Math.floor(Math.random() * max) + min
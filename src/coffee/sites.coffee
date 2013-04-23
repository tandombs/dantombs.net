class Sites

  constructor: (urls = []) ->
    @urls = urls
    @_sites = []

  # Return (and create, if necessary) a `Site` from the list, by index.
  get: (index) => 
    @_sites[index] ||= new Site(@urls[index])
    
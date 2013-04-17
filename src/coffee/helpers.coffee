_.extend window,

  log : ->
    log.history = log.history or [] # store logs to an array for reference
    log.history.push arguments
    if @console
      arguments.callee = arguments.callee.caller
      console.log Array::slice.call(arguments)

    ((b) ->
      c = ->
      d = "assert,count,debug,dir,dirxml,error,exception,group,groupCollapsed,groupEnd,info,log,markTimeline,profile,profileEnd,time,timeEnd,trace,warn".split(",")
      a = undefined

      while a = d.pop()
        b[a] = b[a] or c
    ) window.console = window.console or {}

  factors : (n) ->
    factors = []
    for num in [1..n]
      factors.push num if n/num == Math.floor n/num
    factors
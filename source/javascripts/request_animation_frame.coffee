for vendor in ['moz', 'webkit', 'o', 'ms']
  window.requestAnimationFrame = window["#{vendor}RequestAnimationFrame"]
  break if window.requestAnimationFrame

unless window.requestAnimationFrame
  window.requestAnimationFrame = (callback) ->
    setTimeout callback, 1000 / 60

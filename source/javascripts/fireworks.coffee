class @Fireworks
  constructor: (selector) ->
    @initCanvas selector
    @settings =
      gravity: 0.2
      damping: 0.95
      sparkSize: 3
      sparkQuantity: 1500
    @fire()

  initCanvas: (selector) ->
    @canvas = document.getElementById selector
    @canvas.width  = 500
    @canvas.height = 500
    @context = @canvas.getContext '2d'
    @context.fillStyle = '#000000'
    @context.fillRect 0, 0, @canvas.width, @canvas.height

  initSparks: ->
    x = @canvas.width  / 2
    y = @canvas.height / 2
    for i in [0..@settings.sparkQuantity]
      angle = Math.random() * (Math.PI * 2)
      speed = Math.random() * 6
      @sparks.push
        x: x
        y: y
        vx: Math.cos(angle) * speed
        vy: Math.sin(angle) * speed

  fire: ->
    @sparkSize = @settings.sparkSize
    @sparks = []
    @initSparks()
    requestAnimationFrame @update

  update: =>
    for spark in @sparks
      spark.x += spark.vx
      spark.y += spark.vy + @settings.gravity
      spark.vx *= @settings.damping
      spark.vy *= @settings.damping
      @draw spark
    @context.globalCompositeOperation = 'source-over'
    @context.fillStyle = 'rgba(0, 0, 0, 0.3)'
    @context.fillRect 0, 0, @canvas.width, @canvas.height
    @sparkSize *= 0.97
    if @sparkSize < 0.03
      @fire()
      return
    requestAnimationFrame @update

  draw: (spark) ->
    @context.fillStyle = '#723057'
    @context.globalCompositeOperation = 'lighter'
    @context.beginPath();
    @context.arc spark.x, spark.y, @sparkSize, 0, Math.PI * 2, true
    @context.fill()

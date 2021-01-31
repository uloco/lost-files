require("AnAL")
require("laser")
require("player")
require("laser")
require("laserActivator")
require("level")
require("world")
require("debugger")
require("container")
require("roadblock")
require("helper")
require("goal")
require("enemy")
Talkies=require("libs/talkies")
gameOver = false
win = false
textblock=0;
function love.load()
    -- love.graphics.setBackgroundColor(0.8, .8, .8)
    love.graphics.setBackgroundColor(1, 1, 1)

    images = {
        player = love.graphics.newImage("assets/gfx/player.png"),
        world = love.graphics.newImage("assets/gfx/world.png")
    }
    x = 300
    y = 200
    -- game
    love.window.setMode( 1000, 1000)
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    speed = 100
    w = images.player:getWidth()
    h = images.player:getHeight()
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginCallback, endCallback)
    walls = {}
    for i, v in ipairs(obstaclelist) do
        table.insert(walls, create_obstacle(v.x, v.y, 100, 100))
    end
    containers = {create_container(600, 800, 100, 100, containerTypes.file),create_container(500, 500, 100, 100, containerTypes.image)
    ,create_container(1500, 1700, 100, 100)
    ,create_container(1500, 1800, 100, 100),create_container(1500, 900, 100, 100)}

    objects = {} -- table to hold all our physical objects
    laser = create_laser(1040, -50, 650, world,1)
    laser2 = create_laser(1040, 1615, 565, world,2)
    enemy = create_enemy(1250, 1400, 1800, 1400, world)
    laser_activator = create_laser_activator(850, 800, 100, 100, world,1)
    laser_activator2 = create_laser_activator(850, 1800, 100, 100, world,2)
    goals = {create_goal(280, 1450, 100, 100, world)}

    player = create_player(x + 400, y + 100, world)
    Talkies.say("Old Robotman Jenkins", "Hi there, Kid. I'm so sad, I lost my old wedding foto files\nWould you be so kind to push them into the file converter, so we can restore them?\nMy wife will be sooo mad if you don't help me! If there was just a way to get past that laser...")

end

function love.update(dt)
    world:update(dt) -- this puts the world into motion
    player:update(dt)
    enemy:update(dt)
    laser:update(dt, containers)

    if love.keyboard.isDown("escape") then -- press the right arrow key to push the ball to the right
        gameOver = false
        win = false
        love.run()

    end
    for i, v in ipairs(containers) do
        v.update()
    end
    x = player.body:getX()
    y = player.body:getY()
    Talkies.update(dt)
end

function render_local(asset, globalx, globaly)
    love.graphics.draw(asset, 300 + globalx - x, 200 + globaly - y)
end

function render_local_box(globalx, globaly, w, h)
    love.graphics.rectangle("fill", 300 + globalx - x, 200 + globaly - y, w, h)
end

function love.draw()
    -- render_local(images.world, 0, 0)
    background()

    player:draw()

    for i, v in ipairs(walls) do
        v.draw()
    end

    love.graphics.setBlendMode("alpha")
    for i, v in ipairs(containers) do
        v.draw()
    end

    for i, v in ipairs(goals) do
        v.draw()
    end

    laser:draw()
    laser2:draw()
    enemy:draw()
    laser_activator:draw()
    laser_activator2:draw()

    if (gameOver) then
        love.graphics.setColor(0, 0, 1) -- set the drawing color to red for the ball
        love.graphics.rectangle("fill", 0, 0, width, width)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        love.graphics.print("BLUE SCREEN", 400, 300)
    end
    if (win) then
        love.graphics.setColor(0, 1, 0) -- set the drawing color to red for the ball
        love.graphics.rectangle("fill", 0, 0, width, width)
        love.graphics.setColor(1, 1, 1) -- set the drawing color to red for the ball
        love.graphics.print("WIN", 400, 300)
    end

    Talkies.draw()
    love.graphics.setColor(0, 1, 0) 
    love.graphics.print("x: "..x, 10, 10)
    love.graphics.print("y: "..y, 10, 50)
    love.graphics.setColor(1, 1, 1) 
    debug_print()
end

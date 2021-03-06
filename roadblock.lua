function create_obstacle(x, y, w, h)
    -- let's create the ground

    local images = {
        roadblock = love.graphics.newImage("assets/gfx/roadblock001.png")
    }

    local obstacle = {}
    obstacle.x = x
    obstacle.y = y
    obstacle.w = w
    obstacle.h = h
    obstacle.body = love.physics.newBody(world, x + w / 2, y + h / 2, "static") -- remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    obstacle.shape = love.physics.newRectangleShape(w, h) -- make a rectangle with a width of 650 and a height of 50
    obstacle.fixture = love.physics.newFixture(obstacle.body, obstacle.shape) -- attach shape to body

    function obstacle.draw()
        render_local(images.roadblock, obstacle.x, obstacle.y)
        -- love.graphics.setColor(1, 1, 1, 0.5)
        -- render_local_box(obstacle.x - w / 2, obstacle.y - h / 2, obstacle.w, obstacle.h)
    end

    return obstacle
end

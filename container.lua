function create_container(x, y, w, h, type)
    -- let's create the ground
    type = type or containerTypes.emtpy
    local images = {
        container = love.graphics.newImage("assets/gfx/container001.png"),
        image = love.graphics.newImage("assets/gfx/transportFiles002.png"),
        file = love.graphics.newImage("assets/gfx/transportFiles001.png")
    }

    local container = {}
    container.x = x
    container.y = y
    container.w = w
    container.h = h
    container.body = love.physics.newBody(world, x + w / 2, y + h / 2, "dynamic") -- remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    container.body:setLinearDamping(3) -- place the body in the center of the world and make it dynamic, so it can move around
    container.body:setFixedRotation(true)
    container.shape = love.physics.newRectangleShape(w, h) -- make a rectangle with a width of 650 and a height of 50
    container.fixture = love.physics.newFixture(container.body, container.shape) -- attach shape to body
    container.fixture:setRestitution(0.5) -- let the ball bounce
    container.fixture:setUserData(RandomString(32)) -- let the ball bounce
    if(type==containerTypes.image) then
        container.fixture:setUserData("image") -- let the ball bounce
 
    end
    function container.update(dt)

        container.body:setAngle(0)
    end

    function container.draw()
        render_local(images.container, container.body:getX() - w / 2, container.body:getY() - h / 2)

        if type == containerTypes.image then
            render_local(images.image, container.body:getX() - images.image:getWidth() / 2 , container.body:getY() - h - 6)
        elseif type == containerTypes.file then
            render_local(images.file, container.body:getX() - images.file:getWidth() / 2 ,  container.body:getY() - h - 6)
        end
        -- love.graphics.setColor(1, 1, 1, 0.5)
        -- render_local_box(container.body:getX() - w / 2, container.body:getY() - h / 2, container.w, container.h)
    end

    return container

end

containerTypes = {
    emtpy = 0,
    image = 1,
    file = 2,
    audio = 3
}

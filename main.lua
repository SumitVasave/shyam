
function love.load()
	--window
	love.window.setMode(720,1600,{resizable=false,vsync=true})

	Player = {}
	Player.x = 100
	Player.y = 100
	Player.texture = love.graphics.newImage("sprites/player.png")
	-- world
	World=love.physics.newWorld(10, 250)

	-- player physics body
	Player.body=love.physics.newBody(World,Player.x,Player.y,"dynamic")
	Player.shape=love.physics.newCircleShape(25)
	Player.fixture=love.physics.newFixture(Player.body,Player.shape)
	-- ground physics body
	Ground={}
	Ground.body=love.physics.newBody(World,400,550,"static")
	Ground.shape=love.physics.newRectangleShape(800,50)
	Ground.fixture=love.physics.newFixture(Ground.body,Ground.shape)

	--pipe
	pipe={}
	T=0
    -- Camera
	Camera=require "lib.camera"
    -- require "lib.camera"
	Cam=Camera()
end

function love.update(dt)
	World:update(dt)
	Player.x,Player.y=Player.body:getPosition()
	T = T + dt
	if T >= 2 then
		T = 0
	end

	Cam:lookAt(Player.body:getX(),Player.body:getY())
end

function love.draw()
	love.graphics.print(string.format("Position(x,y):(%s,%s)",Player.x,Player.y),10,10)

	Cam:attach()

		-- love.graphics.rectangle("fill",Player.x,Player.y,50,50)
		-- love.graphics.circle("fill",Player.x-50,Player.y-50,0,0.25,0.25)
		love.graphics.draw(Player.texture,Player.x-75,Player.y-75,0,0.25,0.25)
		
		love.graphics.rectangle("fill",Ground.body:getX()-400,Ground.body:getY(),800,50)

	Cam:detach()
end

function love.keypressed(key)
	if key == "escape" then
		print("Game Closed by escape")
		love.event.quit()
	end
	if key=="space" then
		Player.body:applyLinearImpulse(0,-500)
	end
	if key== "f" then
		love.window.setFullscreen(true)
	end
end

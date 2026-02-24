
function love.load()
	Fun=require "lib.myfunctions"
	--window
    -- 720,1600
	Game={}
	Player={}
	World={}
	Screenx=360
	Screeny=640
	love.window.setMode(Screenx,Screeny,{resizable=false,vsync=true})

	Player.x = 200
	Player.y = 200
	Player.texture = love.graphics.newImage("sprites/player.png")
	-- world
	World.world=love.physics.newWorld(100, 0)

	-- player physics body
	Player.body=love.physics.newBody(World.world,Player.x,Player.y,"dynamic")
	Player.shape=love.physics.newCircleShape(25)
	Player.fixture=love.physics.newFixture(Player.body,Player.shape)
	-- ground physics body
	World.Ground={}
	World.Ground.body=love.physics.newBody(World.world,400,1600,"static")
	World.Ground.shape=love.physics.newRectangleShape(800,50)
	World.Ground.fixture=love.physics.newFixture(World.Ground.body,World.Ground.shape)

    -- Camera
	Camera=require "lib.camera"
    -- require "lib.camera"
	Cam=Camera()
end

function love.update(dt)
	World.world:update(dt)
	Player.x,Player.y=Player.body:getPosition()

	if love.keyboard.isDown("p") then
		print(love.math.random(50,Screeny-50))
	end
	Cam:lookAt(Player.body:getX(),300)
end

function love.draw()
	Pipegen()
	love.graphics.print(string.format("Position(x,y):(%s,%s)",Player.x,Player.y),10,10)
	
	Cam:attach()
	
	-- love.graphics.rectangle("fill",Player.x,Player.y,50,50)
	-- love.graphics.circle("fill",Player.x-50,Player.y-50,0,0.25,0.25)
	love.graphics.draw(Player.texture,Player.x-75,Player.y-75,0,0.25,0.25)
	
	love.graphics.rectangle("fill",World.Ground.body:getX()-400,World.Ground.body:getY(),800,50)
	
	Cam:detach()
	Fun.drawphysics()
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

function love.mousepressed(x, y, button, istouch)
	-- istouch=true
    if (button == 1 or istouch==true) then
		Player.body:applyLinearImpulse(0,-500)
    end
end


function Pipegen()
	if Player.x>0 and Player.x%200==0 then
		print("pile")
	end
	
end

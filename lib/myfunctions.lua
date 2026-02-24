local myfun={}

function myfun.hextorgb(hex)
    -- Remove the '#' if it's there
    hex = hex:gsub("#", "")
    
    -- Convert hex pairs to numbers and divide by 255 to get 0-1 range
    local r = tonumber(hex:sub(1, 2), 16) / 255
    local g = tonumber(hex:sub(3, 4), 16) / 255
    local b = tonumber(hex:sub(5, 6), 16) / 255
    
    return r, g, b
end

function myfun.sgn(x)
    if x==0 then
        return 0
    elseif x>0 then
        return 1
    else
        return -1
    end
end

function myfun.relpos(x1,y1,x2,y2)
    return x1-x2,y2-y1
end


-- to draw bodies[physics] (https://love2d.org/wiki/Tutorial:PhysicsDrawing)
function myfun.drawphysics()
    love.graphics.setColor(myfun.hextorgb("#fc039d"))
    for _, body in pairs(World.world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
            if shape:typeOf("CircleShape") then
                local cx, cy = body:getWorldPoints(shape:getPoint())
                love.graphics.circle("line", cx, cy, shape:getRadius())
            elseif shape:typeOf("PolygonShape") then
                love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
            else
                love.graphics.line(body:getWorldPoints(shape:getPoints()))
            end
        end
    end
    love.graphics.setColor(myfun.hextorgb("#ffffff"))
end


return myfun
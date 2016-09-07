debug = true
local progress = 0

local scrWidth = love.graphics.getWidth()
local scrHeight = love.graphics.getHeight()

function love.load(arg)
    stime = love.timer.getTime()
    co = coroutine.create(backend_logic)

    ttime = (love.timer.getTime() - stime)
end

function love.draw(dt)

    love.graphics.print("Loading: " .. progress .. " %", scrWidth/2 - 50, scrHeight/2)

    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)    
    love.graphics.print("Time taken : "..tostring(round(ttime, 1)) .. " seconds", 10, 30)    
end

function love.update(dt)
    if coroutine.status(co) ~= "dead" then
         _, progress = coroutine.resume(co)
    end
end

function backend_logic()
    local smin = 1
    local smax = 5000
    for i = smin, smax, 1 do
        print(i .. " > ALL WORK AND NO PLAY MAKES JACK A DULL BOY")
        local prg = round(i * 100 / smax)
        coroutine.yield(prg)
    end
    ttime = (love.timer.getTime() - stime)
    return 100
end

function round(num, dp)
    local mult = 10^(dp or 0)
    return (math.floor(num * mult + 0.5)) / mult
end
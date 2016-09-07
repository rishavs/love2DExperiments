debug = true
inspect = require "inspect"

local progress = 0
local msg_queue = {}
local scrWidth = love.graphics.getWidth()
local scrHeight = love.graphics.getHeight()

function love.load(arg)
    stime = love.timer.getTime()

    thread = love.thread.newThread( "backend.lua")
    channel = love.thread.getChannel("test" )
    thread:start()

    -- backend_logic()
    ttime = (love.timer.getTime() - stime)
end

function love.draw(dt)
    love.graphics.print("Loading: " .. progress .. " %", scrWidth/2 - 50, scrHeight/2)

    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 10, 10)    
    love.graphics.print("Time taken : "..tostring(round(ttime, 1)) .. " seconds", 10, 30)    
end

function love.update(dt)

    progress = channel:pop() or progress

end

function love.threaderror(thread, errorstr)
    print("Thread error!\n"..errorstr)
    -- thread:getError() will return the same error string now.
end

function get_progress()
    return msg_queue[#msg_queue] or "starting..."
end

function round(num, dp)
    local mult = 10^(dp or 0)
    return (math.floor(num * mult + 0.5)) / mult
end
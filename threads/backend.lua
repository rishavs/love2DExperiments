
local smin = 1
local smax = 1000

channel = love.thread.getChannel("test")

for i = smin, smax, 1 do
    print(i .. " > ALL WORK AND NO PLAY MAKES JACK A DULL BOY")
    channel:push((i * 100 / smax))
end


function round(num, dp)
    local mult = 10^(dp or 0)
    return (math.floor(num * mult + 0.5)) / mult
end
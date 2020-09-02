
---[[
local composer = require( "composer" )

local background = display.setDefault("background", 0/255, 143/255, 126/255 )

--require("mobdebug").start() --zeroBrane откладка

local options = {
    effect = "fade",
    time = 500,
    params = {
        someKey = "someValue",
        someOtherKey = 10
    }
}
composer.gotoScene( "scene.menu", options )
--]]

-- local tot = {12, 67,"453453",pop = "iuouou"}
--   print(tot[1])
--   print(tot[4])
--   print(tot.pop)
--
-- local lp = tot.pop
--
-- print(lp)
--
-- local ttt = {}
-- for i = 1, 10 do
--     ttt[i] = i+2
--     print(ttt[i])
-- end
--
-- local ty = {}
--
-- local i = 1
-- local stolb = 5
--
-- while (i <= 10) do
--   top = 100
--   pol = i * 100
--   if  (i > 5) then
--     top = 200
--     pol = (i-5)* 100
--   end
--   ty[i] = display.newRect( top, pol , 60, 90 )
--   i = i + 1
-- end

-- local t = 1
--
-- for i =1,3 do
--   t = t + 1
--   print(t)
-- end
--
-- local p = 1
--
-- local i = 1
--
-- while i < 3 do
--   p = p + 1
--   print(p)
--   i = i +1
-- end

--return scene

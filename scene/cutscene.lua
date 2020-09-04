local composer = require("composer")
local scene = composer.newScene()
local background = display.setDefault("background", 0, 0, 0 )

local loop = composer.getVariable( "name" )
composer.removeScene(composer.getVariable( "name" ))
local function perehod( event )
     composer.gotoScene( loop , {delay = 400, time = 1000, effect="crossFade", onComplete =composer.removeScene("scene.cutscene") } )
     background = display.setDefault("background", 0/255, 143/255, 126/255 )
end
      timer.performWithDelay( 50, perehod )
--print(composer.getVariable( "name" ))

scene:addEventListener("create", scene)
return scene

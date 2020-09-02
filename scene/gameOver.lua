local composer = require("composer")
local widget = require("widget")
local loadsave = require( "scene.loadsave" )
local facts	= require("facts")
local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

	local centerX    = display.contentCenterX
	local centerY    = display.contentCenterY
	local fullw      = display.actualContentWidth
	local fullh      = display.actualContentHeight
	local left       = centerX - fullw/2
	local right      = left + fullw
	local top        = centerY - fullh/2
	local bottom     = top + fullh


	display.newRect(sceneGroup, centerX , centerY, fullw, fullh):setFillColor(37/255, 39/255, 46/255, 0.7)
  local plant = display.newRoundedRect(sceneGroup, display.contentCenterX, 600, 560, 920, 15)
				plant:setFillColor(244/255,229/255,209/255)

	local textTab = {"Время вышло\n", "Звезды закончились\n", "Очки", "Ловкость ", "Правельных ответов"}

	local text = display.newText({
		parent = sceneGroup,
		text =  textTab[1],
		width = 490,
		align = "center",
		x = display.contentCenterX, y = plant.y-400,
		font = "font/Blogger_Sans-Bold.otf",
		fontSize = 75,
	})
	text:setTextColor(255/255,129/255,129/255)

transition.cancel("transTag")

local lov = 0
	for i = 1, #lovkost do
		lov = math.ceil(lov + lovkost[i])
		--print(lovkost[i])
	end

	display.newRoundedRect(sceneGroup, display.contentCenterX, plant.y-320, 350, 55, 15):setFillColor(118/255,113/255,112/255)
	local plane = display.newRoundedRect(sceneGroup, display.contentCenterX-175, plant.y-320, (350/100)*(lov/#lovkost), 55, 15)
				plane:setFillColor(0.272+(38/(lov/#lovkost+10)), (0.815/100)*(lov/#lovkost+30), 80/255) --red 0.572 .428
				plane.anchorX = 0

	local text2 = display.newText({
		parent = sceneGroup,
		text =  textTab[4] .. math.ceil(lov/#lovkost) .. '%', --.."%\n" .. textTab[5] .." ".. math.floor((score/minus)*100) .. "%"
		width = 490,
		align = "center",
		x = display.contentCenterX, y = plant.y-320,
		font = "font/Blogger_Sans-Bold.otf",
		fontSize = 45,
	})
	text2:setTextColor(1,1,1)



local ar1 = math.random(1, #facts)
local ar2 = math.random(2, math.random(2, #facts[ar1]))

	local text3 = display.newText({
		parent = sceneGroup,
		text =  facts[ar1][1] .. '\n' .. facts[ar1][ar2] ,
		width = 490,
		align = "left",
		x = display.contentCenterX, y = plant.y,
		font = "font/Blogger_Sans-Bold.otf",
		fontSize = 600/string.len(facts[ar1][ar2])+35,
	})
	text3:setTextColor(118/255,113/255,112/255)

	local text4 = display.newText({
		parent = sceneGroup,
		text =  'А вы знали что:' ,
		width = 490,
		align = "center",
		x = display.contentCenterX, y = plant.y-220,
		font = "font/Blogger_Sans-Bold.otf",
		fontSize = 45,
	})
	text4:setTextColor(118/255,113/255,112/255)
---------------
  local setting = loadsave.loadTable( "settings.json" )
	goh()

	function closer(tip)
			if (tip == 'restart') then
					composer.removeHidden( false )
					composer.hideOverlay("fade", 400)
					composer.removeScene("scene")-- composer.getVariable( "name" )
					composer.gotoScene( "scene", {time = 800, effect="crossFade"} )
			elseif (tip == 'close') then
				composer.hideOverlay("fade", 400) -- закрываем сцену
				--composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
				composer.removeScene("scene")
			--	composer.removeScene(composer.getVariable( "name" ))
		end
	end


	local okButton = widget.newButton {
		shape = 'roundedRect',
		radius = 5,
		width = 220, height = 70,
		left = display.contentCenterX - 220, top = 920,
		fillColor = { default={ 0.2 }, over={ 0, 149/255, 59/255 } },
		labelColor = { default={ 1 }, over={ 1 } },
		fontSize = 32,
		label = "OK",
		onRelease  = function(event) closer('close')	end
	}
	sceneGroup:insert(okButton)
--{"score":9,"minus":18}

	local okButton2 = widget.newButton {
		shape = 'roundedRect',
		radius = 5,
		width = 220, height = 70,
		left = display.contentCenterX, top = 920,
		fillColor = { default={ 0.2 }, over={ 0, 149/255, 59/255 } },
		labelColor = { default={ 1 }, over={ 1 } },
		fontSize = 32,
		label = "Restart",
		onRelease = function(event)	closer('restart')	end
	}
	sceneGroup:insert(okButton2)


end

scene:addEventListener("create", scene)
return scene

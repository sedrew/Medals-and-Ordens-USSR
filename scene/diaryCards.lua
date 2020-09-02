local composer = require("composer")
local widget = require("widget")
local json = require("json")

local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

  function loadSettings(filename)
    -- получаем путь к файлу
    local path = system.pathForFile(filename, system.ResourceDirectory)
    local contents = ""
    local myTable = {}
    local file = io.open(path, "r") -- открываем файл
    if (file) then -- если такой файл существует
       local contents = file:read( "*a" ) -- читаем из него данные
       myTable = json.decode(contents) -- расшифровываем их
       io.close(file) -- закрываем файл
       return myTable -- возвращаем параметры из файла
    end
    return nil
  end


  setting = loadSettings("settings.json"); -- загружаем параметры из файла
  if (setting) then
    score	= setting.score
    minus = setting.minus
  end
  local cards = {"солдат", "солдат2", "солдат3", "солдат4", "солдат5", "солдат6"}
  local points = {5,10,15,20,25,30}

	display.newRect(sceneGroup, display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight):setFillColor(37/255, 39/255, 46/255, 0.7)
  display.newRoundedRect(sceneGroup, display.contentCenterX, 490, 460, 620, 10):setFillColor(244/255,229/255,209/255)

	local text = display.newText({
		parent = sceneGroup,
		text =  "Нужно накопить ".. score .. "/".. points[composer.getVariable( "cards" )]  .. " очков" ,
		width = 450,
		align = "center",
		x = display.contentCenterX, y = 300,
		font = "font/Blogger_Sans-Bold.otf",
		fontSize = 60,
	})
	text:setTextColor(118/255,113/255,112/255)

	local okButton = widget.newButton {
		shape = 'roundedRect',
		radius = 5,
		width = 440, height = 70,
		left = display.contentCenterX - 220, top = 720,
		fillColor = { default={ 0.2 }, over={ 0, 149/255, 59/255 } },
		labelColor = { default={ 1 }, over={ 1 } },
		fontSize = 32,
		label = "OK",
		onPress = function(event)
			composer.hideOverlay( "fade", 800) -- закрываем сцену
		end
	}
	sceneGroup:insert(okButton)

  function okButton:touch()
		--system.openURL( "http://www.coronalabs.com" )
    composer.hideOverlay( true, "fade", 800)
  --composer.gotoScene("scene.diary", {time = 800, effect="crossFade", onComplete =})
		--composer.removeScene("diaryCards")
    -- composer.removeScene("gameOver")
    return true
  end okButton:addEventListener( "touch", okButton )

end

scene:addEventListener("create", scene)
return scene

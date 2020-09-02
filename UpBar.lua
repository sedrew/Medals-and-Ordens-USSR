local composer = require("composer")

local scene = composer.newScene()

function scene:create(event)
	local sceneGroup = self.view

    local text = display.newGroup()

    local ToMenu = display.newText({
      parent = text,
      text = "Домой",
      x = display.contentCenterX, y = 40,
      font = "CoreMellowBold.ttf",
      fontSize = 75,
    })


  function text:touch(e)
    if(e.phase == "ended" ) then
      composer.gotoScene("menu", {time = 500, effect="crossFade"})
      composer.removeScene("kolodki", {time = 500})
      display.remove( bar.ToMenu )
      bar.ToMenu = nil
      print("F:SKF:KSF:K")
    end
    return true
  end
  text:addEventListener("touch", text)
 return text


end
scene:addEventListener("create", scene)
return scene

local composer = require("composer")
local widget = require("widget")
local facts	= require("resource.facts")[PROPS.lang]
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view


  local container = display.newContainer(fullw-80, fullh-180)
  display.newRect(sceneGroup, centerX , centerY, fullw, fullh):setFillColor(37/255, 39/255, 46/255, 0.7)
  local plant = display.newRoundedRect(sceneGroup, centerX, centerY, fullw-80, fullh-180, 40)
        plant:setFillColor(unpack(PROPS.color.cart))

  local group = display.newGroup()



  local table_name = composer.getVariable("table_name_med")
  local kol_not = {2,5,11,17,24,30,37,48,51,59,60}
  local img_medal = display.newImage(group, "img/medali_ten/".. table_name[1] .. ".png",display.contentCenterX, 450)

  function table.find(t, l)
    for k,v in pairs(t) do
       if v == l then
            return true
        end
      end
    return false
  end

  local kol_img
  if table.find(kol_not, table_name[1]) == true then
    kol_img = display.newImage(group, "img/kolodki/".. 2 .. ".png",display.contentCenterX, img_medal.y+400)
  else
    kol_img = display.newImage(group, "img/kolodki/".. table_name[1] .. ".png",display.contentCenterX, img_medal.y+400)
  end

  --local img_medal = display.newImage(group, )
  print(table_name[2])
  local all_text_score = display.newText({
    parent = group,
    text =  "table_achieve.game_achieve.all_score",
    width = 490,
    align = "center",
    x = display.contentCenterX, y = img_medal.y+800,
    font = PROPS.font,
    fontSize = 40,
  })
  all_text_score:setFillColor(unpack(PROPS.color.grey))

  local dr = display.newGroup()
  dr:insert(img_medal)
  img_medal.x = 0
  img_medal.y = -200
  dr:insert(all_text_score)
  all_text_score.x = img_medal.x
  all_text_score.y = img_medal.y+600
  dr:insert(kol_img)
  kol_img.x = img_medal.x
  kol_img.y = img_medal.y+350

  container.x = plant.x
  container.y = plant.y
  container:insert(dr, true)


  function plant:touch( event )
    if event.phase == "began" then
      display.getCurrentStage():setFocus( self, event.id )
      self.isFocus = true

      --self.markX = self.x
      --self.markY = self.y
      self.markY = dr.y

    elseif self.isFocus then
      if event.phase == "moved" then

        --self.x = event.x - event.xStart + self.markX
        dr.y = event.y - event.yStart + self.markY

      elseif event.phase == "ended" or event.phase == "cancelled" then
        display.getCurrentStage():setFocus( self, nil )
        self.isFocus = false
      end
    end
   return true
  end
  plant:addEventListener("touch", plant)

  local button_close = display.newImage(sceneGroup,"img/UI/2x/buttonX.png",plant.x+plant.width/2-10, plant.y-plant.height/2+10)
  button_close:setFillColor(unpack(PROPS.color.mistake))

  function button_close:touch(event)
      if (event.phase == "began") then
        --composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
        composer.hideOverlay("scene.description")
        display.remove(dr)
      end
  end
  button_close:addEventListener("touch", button_close)

  function closer(event)
  end

sceneGroup:insert(group)
--sceneGroup:insert(dr)
end

scene:addEventListener("create", scene)
return scene

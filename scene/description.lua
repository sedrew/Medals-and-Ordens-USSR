local composer = require("composer")
local widget = require("widget")
local facts	= require("resource.facts")[PROPS.lang]
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view

  --local descript = require("resource.descriptionHandbook")[PROPS.lang]
  local words = require("resource.words")[PROPS.lang]

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

  --print(table.find(descript,"Медаль\n«За победу над Германией в Великой Отечественной войне\n1941-1945 гг.»"))
  --local string_name = utf8.gsub(words[table_name[1]],'\n.-'," ")

  local all_text_score = display.newText({
    parent = group,
    text = "Медаль\n«За победу над Германией в Великой Отечественной войне\n1941-1945 гг.»",
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
        local posY = event.y - event.yStart + self.markY
        if posY < top+200 then
          dr.y = event.y - event.yStart + self.markY
        end

        --self.x = event.x - event.xStart + self.markX
        --dr.y = event.y - event.yStart + self.markY

      elseif event.phase == "ended" or event.phase == "cancelled" then
        display.getCurrentStage():setFocus( self, nil )
        self.isFocus = false
        if dr.y >= top then
          transition.to(dr,{
            time=150, y = top})
        end
      end
    end
   return true
  end
  plant:addEventListener("touch", plant)

  local button_close = display.newImage(sceneGroup,"img/UI/2x/buttonX.png",plant.x+plant.width/2-10, plant.y-plant.height/2+10)
  button_close:setFillColor(unpack(PROPS.color.mistake))

  function button_close:touch(event)
      if (event.phase == "ended") then
        --composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
        display.remove(dr)
        composer.hideOverlay("scene.description")
      end
  end
  button_close:addEventListener("touch", button_close)

  local button_close = display.newImage(dr,"img/UI/2x/zoomIn.png",img_medal.x+img_medal.width/2-140, img_medal.y+img_medal.height/2+10)
  button_close:setFillColor(1)


  function closer(event)
  end

sceneGroup:insert(group)
--sceneGroup:insert(dr)
end

scene:addEventListener("create", scene)
return scene

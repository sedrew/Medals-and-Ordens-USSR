local composer = require("composer")
local widget = require("widget")
local load  = require("lib.loadsave")
local facts	= require("resource.facts")[PROPS.lang]
local descript_texts = require("resource.descriptionHandbook")[PROPS.lang]
local words = require("resource.words")[PROPS.lang]
local scene = composer.newScene()
local scroll_group = display.newGroup()

function scene:create(event)
  local sceneGroup = self.view

  function get_side(obj)
    local side = {}
    side.top = obj.y - obj.height/2
    side.down = obj.y + obj.height/2
    side.left = obj.x - obj.width/2
    side.right = obj.x + obj.width/2
    return side
  end

  local container = display.newContainer(fullw-80, fullh-180)
  display.newRect(sceneGroup, centerX , centerY, fullw, fullh):setFillColor(37/255, 39/255, 46/255, 0.7)
  local plant = display.newRoundedRect(sceneGroup, centerX, centerY, fullw-80, fullh-180, 40)
        plant:setFillColor(unpack(PROPS.color.cart))

  local table_name = composer.getVariable("table_name_med")
  local kol_not = {2,5,11,17,24,30,37,48,51,59,60}
  local img_medal = display.newImage(scroll_group, "img/medali_ten/".. table_name[1] .. ".png",container.x, get_side(container).top+300)

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
    kol_img = display.newImage(scroll_group, "img/kolodki/".. 2 .. ".png",container.x, img_medal.y+400)
    kol_img:scale(0.9*(320/kol_img.width), 0.9*(120/kol_img.height))--КОСТЫЛь!!!
  else
    kol_img = display.newImage(scroll_group, "img/kolodki/".. table_name[1] .. ".png",container.x, img_medal.y+400)
    kol_img:scale(0.9*(320/kol_img.width), 0.9*(120/kol_img.height))--КОСТЫЛь!!!
  end

  local wiki = load.loadTable("resource/wiki_medal.json", system.pathForFile(system.ResourceDirectory))

  function get_info_in_wiki(tabl, id)
    for i, k in pairs(tabl) do
        if k["id"] == id then
          return k
        end
    end
    return {}
  end

  local wiki_form = {}
  function wiki_form:create(text)
    local pos_indexY = 0
    local text = text or "error"
    if #wiki_form == 0 then
      pos_indexY = img_medal.y+480
    else
      pos_indexY = wiki_form[#wiki_form].y + wiki_form[#wiki_form].height
      print(wiki_form[#wiki_form].height)
    end
    function text_init(text, t)
      t.y = t.y or 0
      t.fontSize = t.fontSize or 40
      t.color = t.color or {0.2}
      wiki_form[#wiki_form+1] = display.newText({
        parent = scroll_group,
        text = text,
        width = 600,
        align = "left",
        x = container.x, y = pos_indexY+t.y,
        font = PROPS.font,
        fontSize = 40,
      })
      wiki_form[#wiki_form]:setFillColor(unpack(t.color))
      wiki_form[#wiki_form].anchorX = 0.5
      wiki_form[#wiki_form].anchorY = 0
      return wiki_form[#wiki_form]
    end
    function wiki_form:header(header)
      local header = header or "HEADER"
      text_init(header, {y = 40, fontSize = 40})
      return wiki_form
    end
    function wiki_form:text()
      text_init(text, {y = 100, fontSize = 30, color = PROPS.color.grey})
    end
    function wiki_form:url()
      local link = text_init("Wiki", {y = 100, fontSize = 40, color = {0.1,0.5,1}})
      function openURL()
        system.openURL(text)
      end
      link:addEventListener("tap", openURL)
    end
    return wiki_form
  end
wiki_form:create(get_info_in_wiki(wiki, table_name[1])["history"]):header("История награды"):text()
wiki_form:create(get_info_in_wiki(wiki, table_name[1])["statick"]):header("Статистика награждений"):text()
wiki_form:create(get_info_in_wiki(wiki, table_name[1])["regulation"]):header("Положение о медали"):text()
wiki_form:create(get_info_in_wiki(wiki, table_name[1])["rewarding"]):header("Основания для награждения"):text()
wiki_form:create(get_info_in_wiki(wiki, table_name[1])["appearance"]):header("Внешний вид"):text()
wiki_form:create(get_info_in_wiki(wiki, table_name[1])["examples"]):header("Примеры награждений"):text()
wiki_form:create(get_info_in_wiki(wiki, table_name[1])["link"]):header("Ссылки на источник"):url()


  container.x = plant.x
  container.y = plant.y
  container:insert(scroll_group, true)

  function plant:touch( event )
    if event.phase == "began" then
      display.getCurrentStage():setFocus( self, event.id )
      self.isFocus = true
      --self.markX = self.x
      --self.markY = self.y
      self.markY = scroll_group.y
    elseif self.isFocus then
      if event.phase == "moved" then
        local posY = event.y - event.yStart + self.markY
        if posY < top+200 then
          scroll_group.y = event.y - event.yStart + self.markY
        end
        --self.x = event.x - event.xStart + self.markX
        --scroll_group.y = event.y - event.yStart + self.markY
      elseif event.phase == "ended" or event.phase == "cancelled" then
        display.getCurrentStage():setFocus( self, nil )
        self.isFocus = false
        if scroll_group.y >= top then
          transition.to(scroll_group,{
            time=150, y = top})
        elseif scroll_group.y <= -(wiki_form[#wiki_form].y+wiki_form[#wiki_form].height) then --КОСТЫЛь
          transition.to(scroll_group,
            {
              time=150,
              y = -(wiki_form[#wiki_form].y+wiki_form[#wiki_form].height),
            })
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
        display.remove(scroll_group)
        composer.hideOverlay("scene.description")
      end
  end
  button_close:addEventListener("touch", button_close)

  local button_close = display.newImage(scroll_group,"img/UI/2x/zoomIn.png",img_medal.x+img_medal.width/2-140, img_medal.y+img_medal.height/2+10)
  button_close:setFillColor(1)


  function closer(event)
  end

end

function scene:destroy( event )
    local sceneGroup = self.view
    display.remove(scroll_group)
end

scene:addEventListener( "destroy", scene )
scene:addEventListener("create", scene)
return scene

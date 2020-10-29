
local composer = require( "composer" )
local nazv = require("resource.words")[PROPS.lang]
local scroll_group = display.newGroup()
local one_row_group = display.newGroup()
local did_scene_bool = false

local scene = composer.newScene()
function scene:create( event )
    local sceneGroup = self.view
end
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

      function get_side(obj)
        local side = {}
        side.top = obj.y - obj.height/2
        side.bottom = obj.y + obj.height/2
        side.left = obj.x - obj.width/2
        side.right = obj.x + obj.width/2
        return side
      end

    local containerY = 70
    local container = display.newContainer(fullw, fullh-containerY)

    display.newRoundedRect(sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(unpack(PROPS.color.up_bar))

    local GroupText1 = display.newText({
      parent = sceneGroup,
      text = i18n('home'),
      x = centerX, y = top+50,
      font = PROPS.font,
      fontSize = 70,
    })
    --
    function GroupText1:touch(e)
      if (e.phase == "began") then
      composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
      composer.removeScene("scene.handbook")
      display.remove(GroupText1)
      GroupText1 = nil
    end
    return true
  end
  GroupText1:addEventListener( "touch", GroupText1 )

local tool = {}
function tool:table_left(t)
  table.remove(t,1)
 return t
end
function tool:table_right(t)
  local t2 = {nil}
  table.remove(t,#t)
  for i = 1, #t do
    t2[#t2+i] = t[i]
  end
  t = t2
 return t
end

local switch_menu = display.newImageRect(sceneGroup, "img/UI/2x/menuGrid.png",  100, 100)
switch_menu.x = left+100
switch_menu.y = top+60
switch_menu.id = "table_row"

-- for j, k in pairs(nazv) do
-- 	print(j, utf8.gsub(k,'\n.-'," "))
-- end

local sorted = {}
for k, v in pairs(nazv) do
    table.insert(sorted,{k,v})
end
local index_sort = {}
table.sort(sorted, function(a,b) return a[2] < b[2] end)
for _, v in ipairs(sorted) do
    index_sort[#index_sort+1] = v[1]
end

function pick_mode_menu(string)
  if (string == "table_row") then

    container = display.newContainer(fullw, fullh-containerY)
    scroll_group = display.newGroup()

    function pick_medal(e)
      if did_scene_bool then
        local tb = {e.target.tag,nazv[e.target.tag]}
        composer.setVariable("table_name_med", tb)
        composer.showOverlay("scene.description",{isModal = true})
      end
    end

    local function doOnScreenFillTest(self)
    	local x0 = self.x + self.parent.x + self.contentWidth
    	local x1 = self.x + self.parent.x
    	local y0 = self.y + self.parent.y + self.contentHeight
    	local y1 = self.y + self.parent.y
      local cont =  get_side(container)
      print(x0, cont.left)
      local onScreen = ( x0 >= cont.left and x1 <= cont.right ) and (y0 >= top and y1 <= bottom )
       if( onScreen and self.lastFill == "img/fillT.png" ) then
       	self.fill = { type = "image", filename = self.imgPath }
       	self.lastFill = self.imgPath
        self:addEventListener("tap", pick_medal)
       	--print("SHOW", self.imgPath )
       elseif( not onScreen and self.lastFill == self.imgPath ) then
       	self.fill = { type = "image", filename = "img/fillT.png" }
       	self.lastFill = "img/fillT.png"
        self:removeEventListener("tap", pick_medal)
       	--print("HIDE", self.imgPath )
       end
    end

    local roundRect = {}
    local medalImg = {}

    --local scroll_group = display.newGroup()
    local k = 1
    local rectX = get_side(container).left+120
    local rectY = 200
    local indentY = 220
    local indentX = 220
    for i = 1, 3 do
      for j = 1, 20 do
        roundRect[k] = display.newRoundedRect(scroll_group, rectX, rectY, 210, 210, 30)
        roundRect[k]:setFillColor(unpack(PROPS.color.cart))
        roundRect[k].tag = k
        roundRect[k].tap = true
        --print(utf8.gsub(nazv[index_sort[k]],'\n.-'," "))
        local slice
        local imgPath = "img/low_medali_ten/" .. index_sort[k] .. ".png"
        slice = display.newImageRect(scroll_group, imgPath, 210, 210)
    		--slice.anchorX = 0
    		-- slice.anchorY = 0
    		slice.x = rectX
    		slice.y = rectY
    		slice.imgPath = imgPath
    		slice.lastFill = slice.imgPath
    		slice.doOnScreenFillTest = doOnScreenFillTest
        slice.tag = index_sort[k]
        medalImg[k] = slice

        medalImg[k]:addEventListener("tap", pick_medal)

    		slice:doOnScreenFillTest()

        rectY = rectY + indentY
        k = k + 1
      end
    rectY = 200
    rectX = rectX + indentX
    end
    scroll_group.x = 140

    local function listener(event)
       for k,v in pairs(medalImg) do
       	v:doOnScreenFillTest()
       end
    end

  function touch(event)
      if event.phase == "began" then
        self.isFocus = true
        self.markY = scroll_group.y
      elseif self.isFocus then
        if event.phase == "moved" then
          listener()
          local posY = event.y - event.yStart + self.markY
          if posY < top+200 then
            scroll_group.y = event.y - event.yStart + self.markY
          end
        elseif event.phase == "ended" or event.phase == "cancelled" then
          self.isFocus = false
          if scroll_group.y >= top then
            transition.to(scroll_group,{
              time=150, y = top})
          end
        end
      end
     return true
    end
    scroll_group:addEventListener("touch",touch)

    --sceneGroup:insert(scroll_group)
    scroll_group.x = -490
    container.x = centerX
    container.y = centerY+containerY
    container:insert(scroll_group, true)
    sceneGroup:insert(container)
  ------------------------------------
  ------------------------------------
elseif (string == "one_row") then

    one_row_group = display.newGroup()

    local i = 1
    local medalRect = display.newRoundedRect(one_row_group,display.contentCenterX, 560, 650, 650, 15)
          medalRect:setFillColor(190/255,215/255,239/255)
    local myRoundedRect2 = display.newRoundedRect(one_row_group, display.contentCenterX, 1000, 360, 160, 15)
          myRoundedRect2:setFillColor(190/255,215/255,239/255)

    function medalRect:touch(event)
      if (event.phase == "began") then
        local tb = {i,nazv[i]}
        composer.setVariable("table_name_med", tb)
        composer.showOverlay("scene.description",{isModal = true})
      end
      return true
    end
    medalRect:addEventListener("touch", medalRect)

    local right_bt = display.newText({
      parent = one_row_group,
      width = 200,
      text = ">>",
      x = right-40, y = 1150,
      font = PROPS.font,
      fontSize = 100,
    })
    ---
    local left_bt = display.newText({
      parent = one_row_group,
      width = 200,
      text = "<<",
      x = left+120, y = 1150,
      font = PROPS.font,
      fontSize = 100,
    })

    local med = display.newGroup()
    local GroupText = display.newText({
      parent = one_row_group,
      text = nazv[i],
      width = display.actualContentWidth,
      x = display.contentCenterX, y = 120,
      align = "center",
      font = PROPS.font,
    })

    local med1 = {}
          med1[i] = display.newImage(med, "img/medali_ten/".. i .. ".png",display.contentCenterX, 550)
    local kol_not = {2,5,11,17,24,30,37,48,51,59,60}
    local kol = {}
    local kol1 = {}

    for i = 1, #nazv do
      kol[i] = i
      for g, h in ipairs(kol_not)  do
        rawset(kol, h, 2)
      end
    end
    kol1[kol[i]] = display.newImage(med, "img/kolodki/".. i .. ".png",display.contentCenterX, 1000)
    kol1[1]:scale(0.9*(350/kol1[1].width),0.9*(350/kol1[1].width))

    local l = 1
    function left_bt:touch(event)
      if ( event.phase == "began" ) then
        if (i > 1) then
          if (med1[i] ~= nil )  then
              med1[i]:removeSelf()
              med1[i] = nil
              kol1[1]:removeSelf()
              kol1[1] = nil
          end
              i = i - 1
              med1[i] = display.newImage(med, "img/medali_ten/".. i .. ".png",display.contentCenterX, 550)
              kol1[1] = display.newImage(med, "img/kolodki/".. kol[i] .. ".png",display.contentCenterX, 1000)
              kol1[1]:scale(0.9*(350/kol1[1].width),0.9*(350/kol1[1].width))
              GroupText.text = nazv[i]
              GroupText.size = 620/string.len(nazv[i])+32
          end
      end
      return true
    end
    left_bt:addEventListener( "touch", left_bt )

    function right_bt:touch(event)
      if ( event.phase == "began" ) then
        if (i < #nazv) then
          if (med1[i] ~= nil )  then
            med1[i]:removeSelf()
            med1[i] = nil
            kol1[1]:removeSelf()
            kol1[1] = nil
        end
            i = i + 1
            med1[i] = display.newImage(med, "img/medali_ten/".. i .. ".png",display.contentCenterX, 550)
            kol1[1] = display.newImage(med, "img/kolodki/".. kol[i] .. ".png",display.contentCenterX, 1000)
            kol1[1]:scale(0.9*(350/kol1[1].width),0.9*(350/kol1[1].width))
            GroupText.text = nazv[i]
            GroupText.size = 620/string.len(nazv[i])+37
        end
      end
      return true
    end
    right_bt:addEventListener("touch", right_bt)

    one_row_group:insert(medalRect)
    one_row_group:insert(med)
    sceneGroup:insert(one_row_group)

  end
end

sceneGroup:insert(GroupText1)


pick_mode_menu("table_row")


function switch_menu:touch(e)
  if (e.phase == "began") then
    if (switch_menu.id == "table_row") then
      container:removeSelf()
      switch_menu.fill = {type = "image", filename = "img/UI/2x/pause.png"}
      switch_menu.id = "one_row"
    else
      one_row_group:removeSelf()
      switch_menu.fill = {type = "image", filename = "img/UI/2x/menuGrid.png"}
      switch_menu.id = "table_row"
    end
    pick_mode_menu(switch_menu.id)
  end
end
switch_menu:addEventListener("touch", switch_menu)


    elseif ( phase == "did" ) then
      did_scene_bool = true

  end
end


-- hide()
function scene:hide(event)

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
      did_scene_bool = false
        -- Code here runs immediately after the scene goes entirely off screen

    end
end

function scene:destroy( event )
    local sceneGroup = self.view
    display.remove(scroll_group)
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

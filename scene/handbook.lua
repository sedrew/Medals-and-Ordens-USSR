
local composer = require( "composer" )
local nazv = require("resource.words")[PROPS.lang]


local scene = composer.newScene()
function scene:create( event )

    local sceneGroup = self.view

end
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    display.newRoundedRect(sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(unpack(PROPS.color.up_bar))

    local GroupText1 = display.newText({
      parent = GroupText1,
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



local sorted = {}
for k, v in pairs(nazv) do
    table.insert(sorted,{k,v})
end
local index_sort = {}
table.sort(sorted, function(a,b) return a[2] < b[2] end)
for _, v in ipairs(sorted) do
    index_sort[#index_sort+1] = v[1]
  --  print(v[1],v[2])
end

--print(nazv[7])

function pick_mode_menu(string)

  if (string == "table_row") then



    function pick_medal(e)
      local tb = {e.target.tag,nazv[e.target.tag]}
      composer.setVariable("table_name_med", tb)
      composer.showOverlay("scene.description",{isModal = true})
    end

    local function doOnScreenFillTest( self )
    	local x0 = self.x + self.parent.x + self.contentWidth
    	local x1 = self.x + self.parent.x
    	local y0 = self.y + self.parent.y + self.contentHeight
    	local y1 = self.y + self.parent.y

      local onScreen = ( x0 >= left and x1 <= right ) and (y0 >= top and y1 <= bottom )

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

    local rectGroup = display.newGroup()
    local k = 1
    local rectX = 0
    local rectY = 0
    local indentY = 220
    local indentX = 220
    for i = 1, 3 do
      for j = 1, 20 do
        roundRect[k] = display.newRoundedRect(rectGroup, rectX, rectY, 210, 210, 30)
        roundRect[k]:setFillColor(unpack(PROPS.color.cart))
        roundRect[k].tag = k
        roundRect[k].tap = true

        local slice
        local imgPath = "img/medali_ten/" .. index_sort[k] .. ".png"
        slice = display.newImageRect(rectGroup, imgPath, 210, 210)
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
    rectY = 0
    rectX = rectX + indentX
    end
    rectGroup.x = 140

    local function listener(event)
       for k,v in pairs(medalImg) do
       	v:doOnScreenFillTest()
       end
    end

    --ssk.misc.addSmartDrag( rectGroup, { toFront = true, listener = listener } )
    local back = display.newRect(rectGroup, centerX-fullw/2, centerY,fullw+fullw,fullh) --КОСТЫль
    back:setFillColor(0,0,0,0.001)
    --back.anchorX = 0.2-- back.anchorY = 0


  function touch(event)
      if event.phase == "began" then
        --display.getCurrentStage():setFocus( self, event.id )
        self.isFocus = true
        self.markY = rectGroup.y
      elseif self.isFocus then
        if event.phase == "moved" then
          print(system.getTimer())
          listener()
          local posY = event.y - event.yStart + self.markY
          if posY < top+200 then
            rectGroup.y = event.y - event.yStart + self.markY
          end
        elseif event.phase == "ended" or event.phase == "cancelled" then
          --display.getCurrentStage():setFocus( self, nil )
          self.isFocus = false
          if rectGroup.y >= top then
            transition.to(rectGroup,{
              time=150, y = top})
          end
        end
      end
     return true
    end
    rectGroup:addEventListener("touch",touch)

    sceneGroup:insert(rectGroup)

  elseif (tring == "one_row") then

    local i = 1

    local medalRect = display.newRoundedRect(display.contentCenterX, 560, 650, 650, 15)
          medalRect:setFillColor(190/255,215/255,239/255)
    local myRoundedRect2 = display.newRoundedRect(sceneGroup, display.contentCenterX, 1000, 360, 160, 15)
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
      parent = sceneGroup,
      width = 200,
      text = ">>",
      x = right-40, y = 1150,
      font = PROPS.font,
      fontSize = 100,
    })
    ---
    local left_bt = display.newText({
      parent = sceneGroup,
      width = 200,
      text = "<<",
      x = left+120, y = 1150,
      font = PROPS.font,
      fontSize = 100,
    })

    local med = display.newGroup()
    local gr = display.newGroup()
    local GroupText = display.newText({
      parent = GroupText,
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

    sceneGroup:insert(medalRect)
    sceneGroup:insert(med)
    sceneGroup:insert(gr)

    sceneGroup:insert(GroupText)
    sceneGroup:insert(GroupText1)
  end
end

pick_mode_menu("table_row")


function switch_menu:touch(e)
  if (e.phase == "began") then
    if (switch_menu.id == "table_row") then
      switch_menu.fill = {type = "image", filename = "img/UI/2x/pause.png"}
      switch_menu.id = "one_row"
    else
      switch_menu.fill = {type = "image", filename = "img/UI/2x/menuGrid.png"}
      switch_menu.id = "table_row"
    end
    pick_mode_menu(switch_menu.id)
  end
end
switch_menu:addEventListener("touch", switch_menu)

  end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)

    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen

    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

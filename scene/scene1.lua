
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


composer.removeScene("scene.menu")

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  -- Code here runs when the scene is first created but has not yet appeared on screen
end
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      ---вызоваемы таблицы
      local fs        = require ("imge")
      local nazv      = require ("words")
      local json      = require("json")
      local timeGame  = require("scene.timeGame")
      local loadsave  = require("scene.loadsave")
local vt = timeGame.timeStripe(sceneGroup,composer,8)
      local setting = loadsave.loadTable( "settings.json" )
      composer.setVariable( "name", "scene.scene1")
      score	= setting.score
      minus = setting.minus

      display.newRoundedRect(sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(0/255, 130/255, 116/255 );

      local life = 3
      local block = 4
      local pl = {}
      local bg = {}
      local tumb = true
      local nameMedal = math.random(block-3, block)
      local minus = 0
       res = 2

      local box = display.newGroup()

      local yu = {}
      for i = 1, 4 do
          local y = 720
          local sx = -130
        if (i > 2) then
          y = 1050
          sx = -790
        end
        yu[i] = display.newRoundedRect(box, sx+(i*330), y, 320, 320, 12)
        yu[i]:setFillColor(190/255,215/255,239/255)
      end
      sceneGroup:insert(box)

      function loli()
        if (#bg == 0) then
        for i = 1, 4 do
          bg[i] = i + (block - 4)
        end
      end
    end loli()

      math.randomseed(os.time()) -- random initialize
      function df()
        local ran = 1
        while (#pl < 4) do
            j = math.random(1,4)
          if (bg[j] ~= nil) then
			      pl[ran] = bg[j]
			      bg[j] = nil
			      ran = ran + 1
          end
        end
      end df()

      function zaz()
        loli()
        pl = {}
        df()
      end

    local textMedal = display.newGroup()
    local GroupText = display.newText({
      parent = textMedal,
      text = nazv[nameMedal],
      width = display.contentWidth,
      align = "center",
      x = display.contentCenterX, y = 320,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 640/math.floor(string.len(nazv[nameMedal]))+65,
    })


    local textScore = display.newText({
      parent = sceneGroup,
      text =  score,
      width =display.contentWidth,
      align = "center",
      x = 50, y = 40,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 80,
    })


      local med1 = display.newGroup()

      local icons = {}
      function icon()
        local x, y = 200, 720
        for i=1, 4 do
            if (i == 3) then
              y = 1050
              x = 200
            end
          x = x + 330
          icons[i] = display.newImage(med1, "img/medali_ten/" .. pl[i] .. ".png", x-330, y) --fs[pl[i]]
          icons[i]:scale(0.9*(320/icons[i].height), 0.9*(320/icons[i].height))
          icons[i].tag = i
        end
      end icon()

      function touchIt(e)
       if (tumb == true) then
        if(e.phase == "ended" ) then
        --  print(e.target.tag)
          if (pl[e.target.tag] == nameMedal) then
            yu[e.target.tag]:setFillColor( 145/255,209/255,79/255 )
            tumb = false
            block = block + 4
            vt = transition.pause( "transTag" )
            mov()
            score = score + 1
            textScore.text = score
            --  transition.to(icons[1], {time = 400, delay = 200, onComplete = zaz()})
          else yu[e.target.tag]:setFillColor( 255,101/255,101/255 ) starColor()  lifeH()
            minus = minus + 1
          end
        end
      end
      end

      for i=1,4 do
        icons[i]:addEventListener("touch",touchIt)
      end


    function mov()
      if (block < 51) then
        transition.to(med1, { time = 400, delay = 700, alpha = 0,
        onComplete = function()
          for i = 1, 4 do
            icons[i]:removeSelf()
            yu[i]:setFillColor(190/255,215/255,239/255)
          end
           tumb = true
          -- GroupText:removeSelf()
           icons = {}
           nameMedal = math.random(block-3, block)
           GroupText.text = nazv[nameMedal]
          --  GroupText = display.newText({parent = textMedal,text =  nazv[nameMedal],width =display.contentWidth,align = "center",x = display.contentCenterX, y = 300,font = "CoreMellowBold.ttf",fontSize = 80, })
           -- sceneGroup:insert(GroupText)
           zaz()
           icon()
           med1.alpha = 1
           vt = transition.cancel("transTag")
           vt = timeGame.timeStripe(sceneGroup,composer,8)
           for i = 1, 4 do
             icons[i]:addEventListener("touch",touchIt)
           end
        end
    })
  else composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade"})
  end
  end


function lifeH()
  life = life - 1
      if (life < 1) then
        transition.pause( "transTag" )
        composer.showOverlay("scene.gameOver", { isModal = true, time = 800, effect="crossFade"})
  end
end

---------------------------------------------------------------------------
  local toMenu = display.newText({
    parent = toMenu,
    text = "Домой",
    x = display.contentCenterX, y = 40,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = 75,
  })


  function toMenu:touch(e)
    if (tumb == true) then
      if (e.phase == "began") then
        local setting = {
          difficulty = "easy",
          highScore = 10000,
          highestLevel = 7,
          score = score,
          minus = minus,
          lovkost
        }
        loadsave.saveTable( setting, "settings.json" )
      composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
      composer.removeScene("scene.scene1", {time = 500})
      display.remove( toMenu )
      transition.cancel( "transTag" )
      toMenu = nil
    end
    return true
   end
  end
  toMenu:addEventListener( "touch", toMenu )

  local stars = display.newGroup()
  local del = 5
  local vertices = { 0,-110/del, 27/del,-35/del, 105/del,-35/del, 43/del,16/del, 65/del,90/del, 0,45/del, -65/del,90/del, -43/del,15/del, -105/del,-35/del, -27/del,-35/del, }

    local star = {}
    local paint = {1, 1, 0}
    for i = 1, 3 do
      star[i] = display.newPolygon(stars, 750-(i*70), 50, vertices )
      star[i].fill = {1, 1, 0}
      star[i].strokeWidth = 10
      star[i]:setStrokeColor( 255/255,242/255,107/255 )
  end
  local o = 1
      function starColor()
        if (o < 4) then
          star[o]:setStrokeColor(0.5, 0.5, 0.5)
          star[o].fill = {0.5, 0.5, 0.5}
          o = o + 1
      end
      end

sceneGroup:insert(stars)
sceneGroup:insert(textMedal)
sceneGroup:insert(med1)
sceneGroup:insert(toMenu)

elseif ( phase == "did" ) then

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
  local ran = 1
  local pl = {}
  local bg = {}

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

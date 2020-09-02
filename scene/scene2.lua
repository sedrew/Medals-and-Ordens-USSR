
local composer = require( "composer" )

local scene = composer.newScene()

composer.removeScene("scene.menu")

function scene:create( event )


end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      local fs        = require("imge")
      local nazv      = require("words")
      local json      = require("json")
      local timeGame  = require("scene.timeGame")
      local loadsave  = require("scene.loadsave")
      local vt = timeGame.timeStripe(sceneGroup,composer,6)
      local setting = loadsave.loadTable( "settings.json" )
      composer.setVariable( "name", "scene.scene2")
      score	= setting.score
      minus = setting.minus

      display.newRoundedRect(sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(0/255, 130/255, 116/255 );

      local life = 3
      local block = 3
      local pl = {}
      local bg = {}
      local tumb = true
      local nameMedal = math.random(block-2, block)
      res = 2

      local box = display.newGroup()

      function loli()
        if (#bg == 0) then
        for i = 1, 3 do
          bg[i] = i + (block - 3)
        end
      end
    end loli()

      math.randomseed(os.time()) -- random initialize
      function df()
        local ran = 1
        while (#pl < 3) do
            j = math.random(1,3)
          if (bg[j] ~= nil) then
			      pl[ran] = bg[j]
			      bg[j] = nil
			      ran = ran + 1
          end
        end
      end df()

    local textMedal = display.newGroup()

    local yu = {}
    function boxx()
      local i = 3
      local y = 640
      while i > 0 do
        y = y + 170
        yu[i] = display.newRoundedRect(box, 350, y, 620, 160, 12)
        yu[i]:setFillColor(190/255,215/255,239/255)
        --yu[i].tag = pl[i]
        yu[i].tap = i
        i = i - 1
      end
    end boxx()
    yu[4] = display.newRoundedRect(box, 350, 420, 600, 600, 12)
    yu[4]:setFillColor(190/255,215/255,239/255)
    sceneGroup:insert(box)


    local textScore = display.newText({
      parent = sceneGroup,
      text =  score,
      width =display.contentWidth,
      align = "center",
      x = 50, y = 40,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 80,
    })

     function zaz()
          loli()
          pl = {}
          df()
      end

      local med1 = display.newGroup()

      local icons = {}
      function icon()
        local i = 3
        local y = 640
          while i > 0 do
            y = y + 170
              icons[i] = display.newText({
                parent = med1,
                text =  nazv[pl[i]],
                width = 620,
                align = "center",
                x = display.contentCenterX, y = y,
                font = "font/Blogger_Sans-Bold.otf",
                fontSize = 620/string.len(nazv[pl[i]])+32,
              })
            yu[i].tag = pl[i]
            i = i - 1
        end
      end icon()
      print(icons[1].text)

  function touchIt(e)
       if (tumb == true) then
        if(e.phase == "ended" ) then
          --print(e.target.tag)
          if (e.target.tag == nameMedal) then
            yu[e.target.tap]:setFillColor( 145/255,209/255,79/255 )
            tumb = false
            block = block + 3
            vt = transition.pause( "transTag" )
            mov()
            score = score + 1
            textScore.text = score
          else yu[e.target.tap]:setFillColor( 255,101/255,101/255 ) starColor()  lifeH()
            minus = minus + 1 --print(e.target.tag)
          end
        end
      end
    end

     for i=1,3 do
        yu[i]:addEventListener("touch",touchIt)
     end

local medal = display.newImage(med1, "img/medali_ten/" .. nameMedal .. ".png", 350, 420)



    function mov()
      if (block < 51) then
        transition.to(med1, { time = 400, delay = 700, alpha = 0,
        onComplete = function()
          for i = 1, 3 do
            yu[i]:setFillColor(190/255,215/255,239/255)
            icons[i].text = nil
          end
          medal:removeSelf()
           tumb = true
           icons = {}
           nameMedal = math.random(block-2, block)
           medal = display.newImage(med1, "img/medali_ten/" .. nameMedal .. ".png", 350, 420)
           zaz()
           icon()
           med1.alpha = 1
          vt = transition.cancel("transTag")
          vt = timeGame.timeStripe(sceneGroup,composer,6)

        end
    })
  else composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade"})
  end
  end





function lifeH()
  life = life - 1
      if (life < 1 ) then
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

--  local g, h = timeGame.timeStripeeOver()
  function toMenu:touch(e)
    if (tumb == true) then
      if(e.phase == "ended" ) then
        -- settings = {} settings.score = score settings.minus  = minus
        -- saveSettings(settings, "settings.json")
        local setting = {
          difficulty = "easy",
          highestLevel = 7,
          score = score,
          minus = minus,
          lovkost
        }
        loadsave.saveTable( setting, "settings.json" )
        composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
        composer.removeScene("scene.scene2", {time = 500})
        display.remove( toMenu )
        toMenu = nil
        transition.pause( "transTag" )
      return true
    end
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

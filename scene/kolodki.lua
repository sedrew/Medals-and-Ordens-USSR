local composer = require( "composer" )

local scene = composer.newScene()
function scene:create( event )

    local sceneGroup = self.view

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      local json      = require("json")
      local timeGame  = require("scene.timeGame")
      local loadsave  = require("scene.loadsave")
      local setting = loadsave.loadTable( "settings.json" )
      local vt = timeGame.timeStripe(sceneGroup,composer,6)
      score	= setting.score
      minus = setting.minus

      local box = display.newGroup()
      local bok = display.newRoundedRect(box, display.contentCenterX, 420, 600, 600, 12)
      bok:setFillColor(190/255,215/255,239/255)

      local kod = {1,3,4,6,7,8,9,10,12,13,14,15,16,18,19,20,21,22,23,25,26,27,28,29,31,32,33,34,35,36,38,39,40,41,42,43,44,45,46,47,49,50,52,53,54,55,56,57,58}
      local life = 3
      local block = 4
      local pl = {}
      local bg = {}
      local tumb = true
      local nameMedal = kod[math.random(block-3, block)]
      local minus = 0
      res = 2

      composer.setVariable( "name", "scene.kolodki")

local milis = 0
local incrementMilis = 1000
local watch


local function updateTime()
    milis = milis + 1
    print(milis)
    --Have some condition to cancel the timer to avoid it running forever
    if someCondition == true then
        timer.cancel(watch)
    end
end
watch = timer.performWithDelay( incrementMilis, updateTime, -1 )



      local yu = {}
      for i = 1, 4 do
        local y = 860
        local sx = -100
        if (i > 2) then
          y = 1020
          sx = -720
        end
        yu[i] = display.newRoundedRect(box,sx+(i*310), y, 300, 150, 12)
        yu[i]:setFillColor(190/255,215/255,239/255)
        yu[i].tap = i
      end

      function loli()
        if (#bg == 0) then
        for i = 1, 4 do
          local p = i + (block - 4)
          bg[i] = kod[p]
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

      local med1 = display.newGroup()

      local textScore = display.newText({
        parent = sceneGroup,
        text =  score,
        width = display.contentWidth,
        align = "center",
        x = 50, y = 40,
        font = "font/Blogger_Sans-Bold.otf",
        fontSize = 80,
      })

      local kolodki = {}
      function icon()
        local x, y = 200, 860
        for i=1, 4 do
            if (i == 3) then
              y = 1020
              x = 200
            end
          x = x + 330
          kolodki[i] = display.newImage(med1, "img/kolodki/" .. pl[i] .. ".png", x-330, y)
          kolodki[i]:scale(0.9*(120/kolodki[i].height), 0.9*(120/kolodki[i].height))
          yu[i].tag = pl[i]
          -- kolodki[i]:scale(1, 1)
        end
      end icon()

      local voc = display.newGroup()
      local vop = display.newImage(voc, "img/vop.jpg",display.contentCenterX, 300)
      vop:scale(0.74,0.74)

    function vopr()
      local vopr = {3,4,5,8,10,12,15,16,19,22,26,27,31,33,36,39,40,45,54,58}
       for i = 1, #vopr do
          if (nameMedal == vopr[i]) then
           voc.isVisible = false
          end
        end
    end vopr()

      function touchIt(e)
       if (tumb == true) then
        if(e.phase == "ended" ) then
          --print(e.target.tag)
          if (e.target.tag == nameMedal) then
            yu[e.target.tap]:setFillColor( 145/255,209/255,79/255 )
            tumb = false
            block = block + 4
            vt = transition.pause( "transTag" )
            mov()
            score = score + 1
            textScore.text = score
          else yu[e.target.tap]:setFillColor( 255,101/255,101/255 ) starColor()  lifeH()
            minus = minus + 1 print(e.target.tag)
          end
        end
      end
    end

    local medal = display.newImage(med1, "img/medali_ten/" .. nameMedal .. ".png", 350, 420)

     for i=1,4 do
        yu[i]:addEventListener("touch",touchIt)
     end

     function mov()
       if (block < 51) then
         transition.to(med1, { time = 400, delay = 700, alpha = 0,
         onComplete = function()
           for i = 1, 4 do
             kolodki[i]:removeSelf()
             yu[i]:setFillColor(190/255,215/255,239/255)
           end
           voc.isVisible = true
            medal:removeSelf()
            tumb = true
            kolodki = {}
            nameMedal = kod[math.random(block-3, block)]
            medal = display.newImage(med1, "img/medali_ten/" .. nameMedal .. ".png", 350, 420)
            vopr()
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



-- local vopr = {3,4,5,8,10,12,15,16,19,22,26,27,31,33,36,39,40,45,54,58}
--  for i = 1, #vopr do
--    if (nameMedal == vopr[i]) then
--      vop.isVisible = false
--    else vop.isVisible = true
--   end
-- end

 function lifeH()
   life = life - 1
       if (life < 1) then
         someCondition = true
         transition.pause( "transTag" )
         composer.showOverlay("scene.gameOver", {isModal = true, time = 800, effect="crossFade"})
   end
 end


           -- local kolodki = display.newImage(box,"img/kolodki/1.png", 520, 860)
           -- kolodki:scale(3.9, 3.9)

           local toMenu = display.newText({
             parent = sceneGroup,
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
               composer.removeScene("scene.kolodki", {time = 500})
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
           local vertices = {0,-110/del,27/del,-35/del,105/del,-35/del,43/del,16/del,65/del,90/del,0,45/del,-65/del,90/del, -43/del,15/del, -105/del,-35/del, -27/del,-35/del, }

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
sceneGroup:insert(box)
sceneGroup:insert(med1)
sceneGroup:insert(voc)

    end
end



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

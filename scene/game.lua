local composer  = require( "composer" )
local fs        = require("imge")
local nazv      = require("resource.words")
-- local json      = require("json")
local loadsave  = require("scene.loadsave")
local timeGame  = require("scene.timeGame")
--local utf8 = require( "plugin.utf8" )

local centerX    = display.contentCenterX
local centerY    = display.contentCenterY
local fullw      = display.actualContentWidth
local fullh      = display.actualContentHeight
local left       = centerX - fullw/2
local right      = left + fullw
local top        = centerY - fullh/2
local bottom     = top + fullh
local Gam
--local variant    = _G.variant

local scene = composer.newScene()

function scene:create( event )

    local sceneGroup = self.view


     Gam = {
      block = { scene = sceneGroup, kl = 3, x = centerX, y = centerY, w = 620, h = 160, r = 12, vr = 170, vr2 = 330, v = 1  },

      medal = {vr = true,},
      random = {r = 3},

  }
      resurse = {
                  { scene = sceneGroup, kl = 3, x = centerX, y = centerY, w = 620, h = 160, r = 12, vr = 170, vr2 = 330, v = 1  },
                  { scene = sceneGroup, kl = 4, x = centerX, y = centerY, w = 320, h = 320, r = 12, vr = 330, vr2 = 330, v = 2  },
                  { scene = sceneGroup, kl = 4, x = centerX, y = centerY, w = 300, h = 150, r = 12, vr = 170, vr2 = 330, v = 2  },
              }

        if (_G.variant == "text_3" ) then
          Gam.block = resurse[1]
        elseif (_G.variant == "medal_4" ) then
          Gam.block = resurse[2]
        elseif (_G.variant == "kolodki_4" ) then
          Gam.block = resurse[3]

  end
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    local bloc
    local rand
    local medl

function znach()
   bloc = Gam.block
   rand = Gam.random
   medl = Gam.medal
end
znach()

local time = 6

math.randomseed(os.time())
  local life = 3
  local kod = {1,3,4,6,7,8,9,10,12,13,14,15,16,18,19,20,21,22,23,25,26,27,28,29,31,32,33,34,35,36,38,39,40,41,42,43,44,45,46,47,49,50,52,53,54,55,56,57,58}
  local pl = {}
   tumb = true
  local nameMedal = math.random(rand.r-2, rand.r)
  composer.setVariable( "name", "scene.game")

  local setting = loadsave.loadTable( "settings.json" )
  PlayGame = setting.PlayGame
  score	= setting.score
  minus = setting.minus

  PlayGame = PlayGame + 1

  timeGame.upBar(sceneGroup,tumb,score,composer)
  timeGame.timeStripe(sceneGroup,composer,time)

  function random(r, deb)
      local bg = {}
            pl = {}
        if (#bg == 0) then
          for i = 1, r do
            local p = i + (deb - 3)
              if (variant == "kolodki_4") then
                bg[i] = kod[p]
              else
                bg[i] = p
            end
          end
        local ran = 1
        while (#pl < r) do
              j = math.random(1,r)
              if (bg[j] ~= nil) then
                pl[ran] = bg[j]
                bg[j] = nil
                ran = ran + 1
              end
            end
          else bg = {} pl = {}
        end
      end
random(bloc.kl,rand.r)


local box = {}
local bx
local group = display.newGroup()
      function block(sc)
        local i = 1
        local x, y = 0, -bloc.h
        local restart = true
        if (restart == true) then
          if (variant == "text_3" or variant == "kolodki_4") then
            bx = display.newRoundedRect(sceneGroup, centerX, 420, 600, 600, 12)
            bx:setFillColor(190/255,215/255,239/255)
            restart = false
           group.x, group.y = centerX, centerY+bloc.h
          end
          --while i < rand.r do
          for i = 1, bloc.kl do
            if (i == bloc.v+1 and variant == "medal_4") then
              x = x + bloc.vr2
              y = -bloc.h
            group.x, group.y = 0, centerY+bloc.h
          elseif (i == bloc.v+1 and variant == "kolodki_4") then
              x = x + bloc.vr2
              y = -bloc.h
              group.x, group.y = group.x-bloc.vr2/2, centerY+bloc.h
            end
              y = y + bloc.vr
              box[i] = display.newRoundedRect(sc, x, y, bloc.w, bloc.h, bloc.r)
              box[i]:setFillColor(190/255,215/255,239/255)
              box[i].tag = i
              box[i].tap = true
          end
        end
      end
block(group)
sceneGroup:insert(group)
--group.anchorX, group.anchorY = left,top




local icons = {}
local medalText
local med1

function grup(event)               --Функция для создание групп объектов медали и текста
  if (event == "restart") then
    med1:removeSelf()
    medalText:removeSelf()
  end
  medalText = display.newGroup() sceneGroup:insert(medalText)
  med1 = display.newGroup()      sceneGroup:insert(med1)
end grup()



      function medal()
        local i = 1
        local x, y = bloc.x, bloc.y
          if (variant == "text_3") then
            local medal = display.newImage(med1, "img/medali_ten/" .. nameMedal .. ".png", 350, 420)
            for i = 1, bloc.kl do
                if (i < bloc.v) then
                  x = x + bloc.vr2
                end
                y = y + bloc.vr
              icons[i] = display.newText({
                parent = med1,
                text =  nazv[pl[i]],
                width = 620,
                align = "center",
                x = display.contentCenterX, y = y,
                font = "font/Blogger_Sans-Bold.otf",
                fontSize = 620/string.len(nazv[pl[i]])+32,
              })
          end
          elseif (variant == "medal_4") then
            group.x, group.y = centerX-bloc.vr2/2, centerY+bloc.vr/2-50
            medText = display.newText({
              parent = medalText,
              text = nazv[nameMedal], --utf8.match(nazv[nameMedal], "%S+").."\n"..utf8.match(nazv[nameMedal], "%S+(.*)")
              width = display.contentWidth,
              align = "center",
              x = display.contentCenterX, y = 320,
              font = "font/Blogger_Sans-Bold.otf",
              fontSize = 640/math.floor(string.len(nazv[nameMedal]))+65,
            })
            for i = 1, bloc.kl do
              icons[i] = display.newImage(med1, "img/medali_ten/" .. pl[i] .. ".png", box[i].x+group.x, box[i].y+group.y)
              icons[i]:scale(0.9*(320/icons[i].height), 0.9*(320/icons[i].height))
              icons[i].tag = i
              --i = i + 1
            end
          elseif (variant == "kolodki_4") then
            nameMedal = kod[math.random(rand.r-2, rand.r)]
            local medal = display.newImage(med1, "img/medali_ten/" .. nameMedal .. ".png", 350, 420)
            local vop = display.newImage(med1, "img/vop.jpg",display.contentCenterX, 300)
            vop.isVisible = true
            vop:scale(0.74,0.74)
            group.x, group.y = centerX-bloc.vr2/2, centerY+bloc.h
            local vopr = {3,4,5,8,10,12,15,16,19,22,26,27,31,33,36,39,40,45,54,58}
             for i = 1, #vopr do
                if (nameMedal == vopr[i]) then
                 vop.isVisible = false
                end
              end
            for i = 1, 4 do
              icons[i] = display.newImage(medalText, "img/kolodki/" .. pl[i] .. ".png", box[i].x+group.x, box[i].y+group.y)
              icons[i]:scale(0.9*(120/icons[i].height), 0.9*(120/icons[i].height))
            end
          end
    end
medal()


function touchIt(e)
 if (tumb == true) then
  if(e.phase == "ended" ) then
    if (pl[e.target.tag] == nameMedal) then
      box[e.target.tag]:setFillColor( 145/255,209/255,79/255 )
      tumb = false
      rand.r = rand.r + 3
      random(bloc.kl,rand.r)
      transition.pause( "transTag" )
      nameMedal = math.random(rand.r-2, rand.r)
      mov()
      score = score + 1
      timeGame.setScore(score)
      _G.musicControl():sound("right")
    elseif (e.target.tap == true) then
       timeGame.starColor()
       box[e.target.tag]:setFillColor( 255,101/255,101/255 )   --lifeH()
       minus = minus + 1
       e.target.tap = false
       _G.musicControl():sound("mistake")
    end
  end
end
end

for i=1,bloc.kl do
   box[i]:addEventListener("touch",touchIt)
end

function mov()
  if (nazv[rand.r]) then
    transition.to(med1, { time = 400, delay = 700, alpha = 0,
    onComplete = function()
      grup("restart")
      medal()
      scene:create( event ) --Вызывать когда переходим на другой лвл
      for i = 1, bloc.kl do
        icons[i].text =  nazv[pl[i]]
        box[i]:setFillColor(190/255,215/255,239/255)
        box[i].tap = true
      end
       tumb = true
       med1.alpha = 1
       transition.cancel("transTag")
       timeGame.timeStripe(sceneGroup,composer,time)
          end
        })
      else  composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade"})
    -- elseif (rand.r > 5  or _G.marafon == true) then
     --   if (variant == "text_3") then
     --     variant = "medal_4"
     --   -- elseif (variant == "text_3") then
     --   --   variant = "medal_4"
     -- end
     -- print("fhfth56565") group:removeSelf()
     -- scene:create( event )  grup()
     -- znach() random(bloc.kl,rand.r) timeGame.timeStripe(sceneGroup,composer,time)
     -- local box = {}
     -- local bx
     -- local group = display.newGroup()
     -- block(group) sceneGroup:insert(group)
     -- grup("restart")
     -- medal()
  end
end




    elseif ( phase == "did" ) then

    end
end


function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then


    elseif ( phase == "did" ) then


    end
end


-- destroy()
function scene:destroy( event )

    local sceneGroup = self.view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene

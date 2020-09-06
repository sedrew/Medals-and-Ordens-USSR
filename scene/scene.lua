local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
  --composer.removeHidden()
  -- Code here runs when the scene is first created but has not yet appeared on screen
end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

      local great     = require( "maket" )
      local tab       = require( "markup" )
      local timeGame  = require("timeGame")
      local nazv      = require("resource.words")
      local tabl = tab.tabl.scene1
      local position = tab.tabl.orint
      local loadsave  = require("scene.loadsave")

      local setting = loadsave.loadTable( "settings.json" ) --{"minus":0,"score":0,"PlayGame":0}
      PlayGame = setting.PlayGame
      score	= setting.score
      minus = setting.minus

  --    local great = great.start(tabl)
  local full
  --local n = 4
  local pl = {}
  local full = tabl.arrey.x * tabl.arrey.y
  local gt = full
  local nameMedal
  local kod = {1,3,4,6,7,8,9,10,12,13,14,15,16,18,19,20,21,22,23,25,26,27,28,29,31,32,33,34,35,36,38,39,40,41,42,43,44,45,46,47,49,50,52,53,54,55,56,57,58}

  function random(r, deb)
      nameMedal = math.random(gt-3, gt)
      local bg = {}
            pl = {}
        if (#bg == 0) then
          for i = 1, r do
            local p = i + (deb - full)
              if (tabl.id == "kolodki") then
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
        great.table = pl                --варианты спрайтов
        great.randomMedal = nameMedal   --рандомный объект из pl таблицы
      end

random(full,gt)

      great.markup      = tabl           --разметка
      great.scene       = sceneGroup     --группа сцен
      great.words       = nazv           --список слов

      great.react(tabl,sceneGroup)
      great:image(true)

function close(n)
  local setting = {
    PlayGame = PlayGame,
    score = score,
    minus = minus,
    lovk = lovk,
  }
  setting.score = score setting.minus = minus
--  loadsave.saveTable( setting, "settings.json" )
  if (n == true) then
    composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade", isModal = true,})
    transition.pause( "transTag" )
  else
    transition.cancel("transTag")
    composer.gotoScene("scene.menu", {time = 900, effect="crossFade"})
    composer.removeScene("scene")
  end
end




function Color(t, i) --unpack in soul
      i = i or 1
      if t[i] ~= nil then
        return t[i], Color(t, i + 1)
      end
 end


local colorGreen = {145/255,209/255,79/255}
local colorRed = {255,101/255,101/255}



print("DDDDDDDD"..type(colorGreen), type(2), Color(colorGreen))

timeGame.upBar(sceneGroup,tumb,score,composer)
timeGame.timeStripe(sceneGroup,composer,15)
--local tumb = true
  function touchIt(e)
    if (great.tumb) then
      if(e.phase == "ended" ) then
        if (pl[e.target.tag] == nameMedal) then
          --great.start()
        --sceneGroup:remove(0)
        score = score + 1
        timeGame.setScore(score)
        great.tumb = false
        gt = gt + full
        random(full,gt)
        transition.cancel("transTag")
        timeGame.timeStripe(sceneGroup,composer,9)
        great:remove()
        great.box[e.target.tag]:setFillColor(unpack(colorGreen))
      elseif (e.target.tap == true) then
       timeGame.starColor()
       great.box[e.target.tag]:setFillColor(unpack(colorRed))   --lifeH()
    --   minus = minus + 1
       e.target.tap = false
      end
     end
    end
  end

  for i=1,full do
    great.box[i]:addEventListener("touch",touchIt)
  end


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


    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view

end
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene

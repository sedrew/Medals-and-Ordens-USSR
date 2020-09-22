local composer = require("composer")
local scene = composer.newScene()

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

      display.newRoundedRect(sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(unpack(PROPS.color.up_bar));

      local toMenu = display.newText({
        parent = sceneGroup,
        text = i18n('home'),
        x = display.contentCenterX, y = 40,
        font = PROPS.font,
        fontSize = 75,
      })

      local pop = require("maket")
      local stats_group = display.newGroup()
      pop:createRects({
        countX=1,countY=5,
        h=4,w=right-200,
        x=centerX,y=500,
        indentX = 100, indentY = 80,
      })
      sceneGroup:insert(pop.rectGroup)


      function statistic()
        local y = 0
        local score = 80
        for i = 1, 5 do
          local kol = display.newText({
            parent = pop.rectGroup,
            text = score,
            width = 100,
            align = "right",
            x = (pop.box[i].x-pop.w/2)-70, y = y,
            font = PROPS.font,
            fontSize = 40,
          })
          kol:setFillColor(unpack(PROPS.color.cart))
          y = y + pop.indentY
          score = score - 20
        end

        local x_cr = -250
        local x_cradd = pop.w/6
        local week_text = {"ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"}
        for i = 1, 7 do
          local circl = display.newCircle(pop.rectGroup, x_cr, pop.box[#pop.box].y, 10)
          local week = display.newText({
            parent = pop.rectGroup,
            text = week_text[i],
            width = right,
            align = "center",
            x = x_cr, y = pop.box[#pop.box].y+60,
            font = PROPS.font,
            fontSize = 40,
          })
          week:setFillColor(unpack(PROPS.color.cart))

          x_cr = x_cr + x_cradd
        end
      end
      statistic()


      local sbros = display.newText({
        parent = sceneGroup,
        text = i18n('removestat'),
        x = display.actualContentWidth-240, y = display.actualContentHeight-25,
        font = PROPS.font,
        fontSize = 40,
      })

      local loadsave  = require("lib.loadsave")
      function sbros:touch(e)
        if (e.phase == "began") then
          print("SS")
          local tabl = {
            settings = {
             color = {
               background = {0,	0.560, 0.494},
               up_bar = {0, 0.509, 0.454},
               achieve = {1, 0.949,	0.419},
               text = {0,0,0},
               cart = {0.745,	0.843, 0.937},
               right = {0.568, 0.819, 0.309},
               mistake = {1, 0.396, 0.396},
               white = {0,0,0},
               grey = {0.5,0.5,0.5},
             },
             font = "font/Blogger_Sans-Medium.otf",
             font_size = 80,
             music = true,
             sounds = true,
             lang = "ru",
             recent_visit = os_date,
             animation = {
               scene = {delay = 100, time = 300, effect="crossFade"},
               object = {time = 400, delay = 700, alpha = 0},
             }
            },
            game_achieve = {
              all_score = 0,
              all_right_answer = 0,
              all_mistake_answer = 0,
              all_time = 0,
              middle_time = 0,
              count_game = 0,
              achieve_name = {},
              week_progres = {{all_score=0,all_right_answer=0,all_mistake_answer=0},
                              {all_score=0,all_right_answer=0,all_mistake_answer=0},
                              {all_score=0,all_right_answer=0,all_mistake_answer=0},
                              {all_score=0,all_right_answer=0,all_mistake_answer=0},
                              {all_score=0,all_right_answer=0,all_mistake_answer=0},
                              {all_score=0,all_right_answer=0,all_mistake_answer=0},
                              {all_score=0,all_right_answer=0,all_mistake_answer=0}},
              all_time_progres = {},
            }
          }
          PROPS.settings = tabl.settings
          ACHIEVES.game_achieve = tabl.settings.game_achieve
          loadsave.saveTable(tabl, "settings.json")
        end
        return true
      end
      sbros:addEventListener( "touch", sbros )

      function toMenu:touch(e)
        if (e.phase == "began") then
          composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
          composer.removeScene("scene.affair", {time = 500})
          display.remove( toMenu )
          toMenu = nil
        end
        return true
      end
      toMenu:addEventListener( "touch", toMenu )


      local score_text = display.newText({
        parent = sceneGroup,
        align = "left",
        width = 400,
        text = i18n("score").." "..ACHIEVES.all_score,
        x =  left+310, y = top+220,
        font = PROPS.font,
        fontSize = 50,
        })

      local text =i18n('played').." "..ACHIEVES.count_game.." "..i18n('answer').." "..ACHIEVES.all_right_answer.." "..i18n('Times')
      local case = display.newText({
        parent = sceneGroup,
        align = "left",
        text = text,
        x = display.contentCenterX, y = score_text.y+100,
        font = PROPS.font,
        fontSize = 50,
      })

      --local halfW = display.contentWidth * 0.5
      --local halfH = display.contentHeight * 0.5

    --Radian deogram
    --   local ragdogLib = require "scene.ragdogLib"
    --   local data = {
    --     radius = 100,
    --     values = {
    --       {percentage = 100-res, color = {118/255,113/255,112/255}},
    --       {percentage = res, color = {0.572,0.815,80/255}},
    --       }
    --     }
    -- local pie = ragdogLib.createPieChart(data)
    -- pie.x, pie.y = display.contentCenterX-200, display.contentCenterY-200
    -- sceneGroup:insert(pie)


    end
  end
scene:addEventListener("show", scene)
return scene

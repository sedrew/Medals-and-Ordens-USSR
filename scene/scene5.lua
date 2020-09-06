local composer  = require( "composer" )
local fs        = require("imge")
local nazv      = require("resource.words")


local scene = composer.newScene()

function scene:create( event )

    local sceneGroup = self.view


end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

local t = {"c","o","m","p","o","s","e","r","t","y","l","d","x","h"}

local r = {}
local w = {}

local bg = {}
local pl = {}

math.randomseed(os.time())
function rand()
  if (#bg == 0) then
    for i = 1, #t do
      bg[i] = i
    end
    local ran = 1
    while (#pl < #t ) do
        j = math.random(1,#t)
      if (bg[j] ~= nil) then
        pl[ran] = bg[j]
        bg[j] = nil
        ran = ran + 1
      end
    end
  end
end
rand()

local gr = display.newGroup()
local box = {}
function bkv()
  local x, y = 40, display.contentCenterY
  for i = 1, 14 do
    if (i == 8) then
      y = y + 41
      x = 40
    end
    x = x + 41
    box[i] = display.newRoundedRect(gr, x, y, 40, 40, 12)
    box[i]:setFillColor(190/255,215/255,239/255)
    box[i].tag = i
  --  i = i + 1
    w[i] = display.newText({
      parent = gr,
      text = t[pl[i]],
      width = display.contentWidth,
      align = "center",
      x = x, y = y,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 40,
    })
    w[i].tag = i
  end
end bkv()

gr:scale(2,2)
gr.y = -display.contentCenterY
gr.x = -40

local box2 = {}
function bk()
  local x, y = 20, display.contentCenterY - 100
  for i = 1, 8 do
      x = x + 41
      box2[i] = display.newRoundedRect(gr, x, y, 40, 40, 12)
      box2[i]:setFillColor(190/255,215/255,239/255)
      box2[i].tag = i
      --  i = i + 1
    end
end
bk()

function proverka()
  local slovo = ""
--  i = 0
--if (#r < 8) then
  for i = 1, #r do
  slovo = slovo .. r[i].text
  i= i + 1
  end
--end
  if ( slovo == "composer") then
    local er2 = display.newText({
      parent = sceneGroup,
      text = "Правильно",
      width = display.contentWidth,
      align = "center",
      x = display.contentCenterX, y = display.contentCenterY+400,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 90,
    })
    print(slovo)
  end
end


local readT = {}
local x, y = 20, display.contentCenterY - 100
function touchIt(e)
  if(e.phase == "ended" ) then
    for i = 1, 8 do
      if (r[i] == nil or r[i].text == "") then
        --r[i] = w[e.target.tag].text
        x = x + 41
        r[i] = display.newText({
          parent = gr,
          text = w[e.target.tag].text,
          width = display.contentWidth,
          align = "center",
          x = box2[i].x, y = display.contentCenterY - 100,
          font = "font/Blogger_Sans-Bold.otf",
          fontSize = 40,
        })
        w[e.target.tag].text = ""
      --  print(r[i])
        proverka()
        --print(r[1])
        break
      end
    end
  end
end

for i=1,14 do
  box[i]:addEventListener("touch",touchIt)
end


function touchIt(e)
  if(e.phase == "ended" ) then
    for i = 1, 14 do
      if (w[i].text == "") then
        w[i].text = r[e.target.tag].text
        --r[e.target.tag] = nil
        r[e.target.tag].text = ""
        print(r[i])
        break
      end
    end
  end
end

for i=1,8 do
   box2[i]:addEventListener("touch",touchIt)
end


local er = display.newText({
  parent = sceneGroup,
  text = "test",
  width = display.contentWidth,
  align = "center",
  x = display.contentCenterX, y = display.contentCenterY-600,
  font = "font/Blogger_Sans-Bold.otf",
  fontSize = 90,
})


local er2 = display.newText({
  parent = sceneGroup,
  text = "composer",
  width = display.contentWidth,
  align = "center",
  x = display.contentCenterX, y = display.contentCenterY-400,
  font = "font/Blogger_Sans-Bold.otf",
  fontSize = 90,
})






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

------------------------------------------------------------------------
---This library contains a few functions that we're gonna use in several
---parts of this template.
---We use various functions throughout our games and apps to speed up
---the most common practices.
---Each template only contains a handful of these (the one useful to it)
---but we're planning on a release that will contain all our functions
---revised and polished up.
---Made by Ragdog Studios SRL in 2013 http://www.ragdogstudios.com
------------------------------------------------------------------------

local ragdogLib = {};

ragdogLib.applyMaskFromPolygon = function(object, polygon, maskName)
  --we use these to scale down the mask so that it looks exactly the same on any device
  local pixelWidth, pixelHeight;
  local contentWidth, contentHeight = display.contentWidth-(display.screenOriginX*2), display.contentHeight-(display.screenOriginY*2);
  if contentWidth > contentHeight then
    pixelWidth = display.pixelHeight;
    pixelHeight = display.pixelWidth;
  else
    pixelWidth = display.pixelWidth;
    pixelHeight = display.pixelHeight;
  end

  local maskGroup = display.newGroup();
  --create a rect with width and height higher than polygon and rounded up to 2^)
  local rectWidth, rectHeight = 1, 1;
  while (rectWidth < polygon.contentWidth) do
    rectWidth = rectWidth*2;
  end
  while (rectHeight < polygon.contentHeight) do
    rectHeight = rectHeight*2;
  end
  local blackRect = display.newRect(maskGroup, 0, 0, rectWidth, rectHeight);
  blackRect:setFillColor(0, 0, 0);

  maskGroup:insert(polygon);
  polygon.x, polygon.y = 0, 0;
  polygon:setFillColor(1, 1, 1, 1);

  maskGroup.x, maskGroup.y = display.contentCenterX, display.contentCenterY;

  display.save(maskGroup, maskName or "mask.jpg");

  local mask = graphics.newMask(maskName or "mask.jpg", system.DocumentsDirectory);
  object:setMask(mask);

  --here we scale down the mask to make it consistent across devices
  object.maskScaleX = contentWidth/pixelWidth;
  object.maskScaleY = object.maskScaleX;

  maskGroup:removeSelf();
end

ragdogLib.createPieChart = function(data)
  local group = display.newGroup();

--  local brush = { type="image", filename="brush.png"};

  local values = data.values;
  local mSin, mCos = math.sin, math.cos;
  local toRad = math.pi/180;
  local currAngle = -90;
  local strokesSlices = {};

  for i = #values, 1, -1 do
    if values[i].percentage <= 0 then
      table.remove(values, i);
    elseif values[i].percentage == 100 then
      values[i].percentage = 99.9;
    end
  end

  for i = 1, #values do
    local newAngle = values[i].percentage*360*0.01;
    local midAngle1, midAngle2;
    local shape;

    if newAngle > 180 then
      newAngle = currAngle+newAngle;
      midAngle1 = currAngle+(newAngle-180-currAngle)*.5;
      midAngle2 = midAngle1+(newAngle-90-midAngle1)*.5;
      midAngle3 = midAngle2+(newAngle-90-midAngle2)*.5;
      midAngle4 = midAngle3+(newAngle-midAngle3)*.5;
      shape = {0, 0, mCos(currAngle*toRad)*data.radius*2, mSin(currAngle*toRad)*data.radius*2, mCos(midAngle1*toRad)*data.radius*2, mSin(midAngle1*toRad)*data.radius*2, mCos(midAngle2*toRad)*data.radius*2, mSin(midAngle2*toRad)*data.radius*2,
        mCos(midAngle3*toRad)*data.radius*2, mSin(midAngle3*toRad)*data.radius*2, mCos(midAngle4*toRad)*data.radius*2, mSin(midAngle4*toRad)*data.radius*2, mCos(newAngle*toRad)*data.radius*2, mSin(newAngle*toRad)*data.radius*2};
    else
      newAngle = currAngle+newAngle;
      midAngle1 = currAngle+(newAngle-currAngle)*.5;
      shape = {0, 0, mCos(currAngle*toRad)*data.radius*2, mSin(currAngle*toRad)*data.radius*2, mCos(midAngle1*toRad)*data.radius*2, mSin(midAngle1*toRad)*data.radius*2, mCos(newAngle*toRad)*data.radius*2, mSin(newAngle*toRad)*data.radius*2};
    end
    currAngle = newAngle;

    local slice = display.newPolygon(group, 0, 0, shape);
    slice:setFillColor(unpack(values[i].color));
    slice.stroke = brush;
    slice.strokeWidth = 2;
    slice:setStrokeColor(unpack(values[i].color));

    local lowerPointX, higherPointX, lowerPointY, higherPointY = 10000, -10000, 10000, -10000;
    for i = 1, #shape, 2 do
      if shape[i] < lowerPointX then
        lowerPointX = shape[i];
      end
      if shape[i] > higherPointX then
        higherPointX = shape[i];
      end
      if shape[i+1] < lowerPointY then
        lowerPointY = shape[i+1];
      end
      if shape[i+1] > higherPointY then
        higherPointY = shape[i+1];
      end
    end

    slice.x = lowerPointX+(higherPointX-lowerPointX)*.5;
    slice.y = lowerPointY+(higherPointY-lowerPointY)*.5;
  end

  local circle = display.newCircle(0, 0, data.radius)
  circle.stroke = brush;
  circle.strokeWidth = 2;
  ragdogLib.applyMaskFromPolygon(group, circle);

  return group;
end

return ragdogLib;

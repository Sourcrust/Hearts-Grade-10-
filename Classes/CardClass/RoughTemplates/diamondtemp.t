
proc drawDiamond (centerX, centerY, width, height, shapeC : int, upsideDown, isVertical : boolean)
    if isVertical then
	Draw.Line (centerX + (width div 4), centerY, centerX, centerY + (height div 4), shapeC)
	Draw.Line (centerX - (width div 4), centerY, centerX, centerY + (height div 4), shapeC)
	Draw.Line (centerX + (width div 4), centerY, centerX, centerY - (height div 4), shapeC)
	Draw.Line (centerX - (width div 4), centerY, centerX, centerY - (height div 4), shapeC)
	Draw.Fill (centerX, centerY, shapeC, shapeC)
    else
	Draw.Line (centerX, centerY + (width div 4), centerX + (height div 4), centerY, shapeC)
	Draw.Line (centerX, centerY - (width div 4), centerX + (height div 4), centerY, shapeC)
	Draw.Line (centerX, centerY + (width div 4), centerX - (height div 4), centerY, shapeC)
	Draw.Line (centerX, centerY - (width div 4), centerX - (height div 4), centerY, shapeC)
	Draw.Fill (centerX, centerY, shapeC, shapeC)
    end if
end drawDiamond


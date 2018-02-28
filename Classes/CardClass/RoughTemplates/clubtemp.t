


proc drawClub (centerX, centerY, width, height, shapeC : int, upsideDown, isVertical : boolean)
    var i : int
    if upsideDown then
	i := -1
    else
	i := 1
    end if
    if isVertical then
	Draw.Line (centerX - (width div 16), centerY - i * (height div 4), centerX + (width div 16), centerY - i * (height div 4), shapeC)
	Draw.Line (centerX - (width div 16), centerY - i * (height div 4), centerX, centerY - i * (height div 20), shapeC)
	Draw.Line (centerX + (width div 16), centerY - i * (height div 4), centerX, centerY - i * (height div 20), shapeC)
	Draw.Fill (centerX, centerY - i * (height div 4) + i, shapeC, shapeC)
	Draw.FillOval (centerX + (width div 8), centerY - i * (height div 16), width div 8, width div 8, shapeC)
	Draw.FillOval (centerX - (width div 8), centerY - i * (height div 16), width div 8, width div 8, shapeC)
	Draw.FillOval (centerX, centerY + i * (height div 9), width div 8, width div 8, shapeC)
	%Draw.FillBox(centerX+(width div 40),centerY+(height div 9),centerX-(width div 40),centerY-(height div 4),shapeC)
	Draw.FillBox (centerX + (width div 20), centerY + i * (height div 9), centerX - (width div 20), centerY - i * (height div 8), shapeC)
    else
	Draw.Line (centerX - i * (height div 4), centerY - (width div 16), centerX - i * (height div 4), centerY + (width div 16), shapeC)
	Draw.Line (centerX - i * (height div 4), centerY - (width div 16), centerX - i * (height div 20), centerY, shapeC)
	Draw.Line (centerX - i * (height div 4), centerY + (width div 16), centerX - i * (height div 20), centerY, shapeC)
	Draw.Fill (centerX - i * (height div 4) + i, centerY, shapeC, shapeC)
	Draw.FillOval (centerX - i * (height div 16), centerY + (width div 8), width div 8, width div 8, shapeC)
	Draw.FillOval (centerX - i * (height div 16), centerY - (width div 8), width div 8, width div 8, shapeC)
	Draw.FillOval (centerX + i * (height div 9), centerY, width div 8, width div 8, shapeC)
	%Draw.FillBox(centerX+(width div 40),centerY+(height div 9),centerX-(width div 40),centerY-(height div 4),shapeC)
	Draw.FillBox (centerX + i * (height div 9), centerY + (width div 20), centerX - i * (height div 8), centerY - (width div 20), shapeC)
    end if
end drawClub

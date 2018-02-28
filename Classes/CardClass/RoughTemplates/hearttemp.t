%Draw.Box (100, 100, 300, 350, black)
%Draw.Box (400, 100, 600, 350, black)
%var width : int := 200
%var height : int := 250
%var centerX : int := 200
%var centerY : int := 225
var shapeC : int := 12


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%option 1

proc drawHeart (centerX, centerY, width, height, shapeC : int, upsideDown, isVertical : boolean)
    var i : int
    if upsideDown then
	i := -1
    else
	i := 1
    end if
    if isVertical then
	Draw.Line (centerX - (width div 4), centerY + i * (height div 18), centerX + (width div 4), centerY + i * (height div 18), shapeC)
	Draw.Line (centerX - (width div 4), centerY + i * (height div 18), centerX, centerY - i * (height div 4), shapeC)
	Draw.Line (centerX + (width div 4), centerY + i * (height div 18), centerX, centerY - i * (height div 4), shapeC)
	Draw.Fill (centerX, centerY, shapeC, shapeC)
	Draw.FillBox (centerX - (width div 4), centerY + i * (height div 12), centerX + (width div 4), centerY + i * (height div 18), shapeC)
	Draw.FillOval (centerX + (width div 8), centerY + i * (height div 12), width div 8, width div 8, shapeC)
	Draw.FillOval (centerX - (width div 8), centerY + i * (height div 12), width div 8, width div 8, shapeC)
    else
	Draw.Line (centerX + i * (height div 18),centerY - (width div 4), centerX + i * (height div 18),  centerY + (width div 4), shapeC)
	Draw.Line (centerX + i * (height div 18),centerY - (width div 4), centerX - i * (height div 4),  centerY, shapeC)
	Draw.Line (centerX + i * (height div 18),centerY + (width div 4),centerX - i * (height div 4), centerY,  shapeC)
	Draw.Fill (centerX, centerY, shapeC, shapeC)
	Draw.FillBox (centerX + i * (height div 12),centerY - (width div 4),centerX + i * (height div 18), centerY + (width div 4),  shapeC)
	Draw.FillOval (centerX + i * (height div 12),centerY + (width div 8),  width div 8, width div 8, shapeC)
	Draw.FillOval (centerX + i * (height div 12),centerY - (width div 8),  width div 8, width div 8, shapeC)
    end if
end drawHeart

drawHeart(100,125,200,250,shapeC,false,true)

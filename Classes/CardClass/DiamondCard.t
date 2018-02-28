%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc drawDiamondCard (bottom_leftX, bottom_leftY, width, height, card, direction, shapeC, backC, royalCard:int, simpleG : boolean)
    %draws the corners stuff
    if direction mod 2 = 1 then
	Draw.FillBox (bottom_leftX, bottom_leftY, bottom_leftX + width, bottom_leftY + height, backC)
	Draw.Box (bottom_leftX, bottom_leftY, bottom_leftX + width, bottom_leftY + height, black)
	drawDiamond (bottom_leftX + (width div 10), bottom_leftY + 4 * (height div 5), width div 4, height div 4, shapeC, false, true)
	drawDiamond (bottom_leftX + (9 * width) div 10, bottom_leftY + (height div 5), width div 4, height div 4, shapeC, true, true)
    else
	Draw.FillBox (bottom_leftX, bottom_leftY, bottom_leftX + height, bottom_leftY + width, backC)
	Draw.Box (bottom_leftX, bottom_leftY, bottom_leftX + height, bottom_leftY + width, black)
	drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + (9 * width div 10), width div 4, height div 4, shapeC, false, false)
	drawDiamond (bottom_leftX + (height div 5), bottom_leftY + (width) div 10, width div 4, height div 4, shapeC, true, false)
    end if
    var dir : boolean
    if direction < 3 then
	dir := false
    else
	dir := true
    end if

    case card of
	label 1 :
	    %draws 1
	    if direction mod 2 = 1 then
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + (height div 2), width, height, shapeC, dir, true)
	    else
		drawDiamond (bottom_leftX + (height div 2), bottom_leftY + (width div 2), width, height, shapeC, dir, false)
	    end if
	label 2 :
	    %draws 2
	    if direction mod 2 = 1 then
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
	    else
		drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + (height div 5), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, true, false)
	    end if
	label 3 :
	    % %draws 3
	    if direction mod 2 = 1 then
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + (height div 2), width div 3, height div 3, shapeC, dir, true)
	    else
		drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + (height div 5), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, true, false)
		drawDiamond (bottom_leftX + (height div 2), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, dir, false)
	    end if
	label 4 :
	    %draws 4
	    if direction mod 2 = 1 then
		drawDiamond (bottom_leftX + (width div 3), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + (width div 3), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
		drawDiamond (bottom_leftX + 2 * (width div 3), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + 2 * (width div 3), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
	    else
		drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + (width div 3), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + (height div 5), bottom_leftY + (width div 3), width div 3, height div 3, shapeC, true, false)
		drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + 2 * (width div 3), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + (height div 5), bottom_leftY + 2 * (width div 3), width div 3, height div 3, shapeC, true, false)
	    end if
	label 5 :
	    %draws 5
	    if direction mod 2 = 1 then
		drawDiamond (bottom_leftX + (width div 3), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + (width div 3), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
		drawDiamond (bottom_leftX + 2 * (width div 3), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + 2 * (width div 3), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + (height div 2), width div 3, height div 3, shapeC, dir, true)
	    else
		drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + (width div 3), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + (height div 5), bottom_leftY + (width div 3), width div 3, height div 3, shapeC, true, false)
		drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + 2 * (width div 3), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + (height div 5), bottom_leftY + 2 * (width div 3), width div 3, height div 3, shapeC, true, false)
		drawDiamond (bottom_leftX + (height div 2), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, dir, false)
	    end if
	label 6 :
	    %draws 6
	    if direction mod 2 = 1 then
		for i : 1 .. 2
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + (height div 2), width div 3, height div 3, shapeC, dir, true)
		end for
	    else
		for i : 1 .. 2
		    drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, false, false)
		    drawDiamond (bottom_leftX + (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, true, false)
		    drawDiamond (bottom_leftX + (height div 2), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, dir, false)
		end for
	    end if
	label 7 :
	    %draws 7
	    if direction mod 2 = 1 then
		for i : 1 .. 2
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + (height div 2), width div 3, height div 3, shapeC, dir, true)
		end for
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + ((10-3*(direction-2))*height div 20), width div 3, height div 3, shapeC, dir, true)
	    else
		for i : 1 .. 2
		    drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, false, false)
		    drawDiamond (bottom_leftX + (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, true, false)
		    drawDiamond (bottom_leftX + (height div 2), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, dir, false)
		end for
		drawDiamond (bottom_leftX + ((10-3*(direction-3))*height div 20), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, dir, false)
	    end if
	label 8 :
	    %Draws 8
	    if direction mod 2 = 1 then
		for i : 1 .. 2
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + 4 * (height div 5), width div 3, height div 3, shapeC, false, true)
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + (height div 5), width div 3, height div 3, shapeC, true, true)
		    drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + (height div 2), width div 3, height div 3, shapeC, dir, true)
		end for
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + 14 * (height div 20), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + 7 * (height div 20), width div 3, height div 3, shapeC, true, true)
	    else
		for i : 1 .. 2
		    drawDiamond (bottom_leftX + 4 * (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, false, false)
		    drawDiamond (bottom_leftX + (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, true, false)
		    drawDiamond (bottom_leftX + (height div 2), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, dir, false)
		end for
		drawDiamond (bottom_leftX + 14 * (height div 20), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + 7 * (height div 20), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, true, false)
	    end if
	label 9 :
	    %Draws 9
	    if direction mod 2 = 1 then
		for i : 1 .. 2
		    for j : 1 .. 4
			drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + j * (height div 5), width div 3, height div 3, shapeC, j < 3, true)
		    end for
		end for
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + (height div 2), width div 3, height div 3, shapeC, dir, true)
	    else
		for i : 1 .. 2
		    for j : 1 .. 4
			drawDiamond (bottom_leftX + j * (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, j < 3, false)
		    end for
		end for
		drawDiamond (bottom_leftX + (height div 2), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, dir, false)
	    end if
	label 10 :
	    %draws 10
	    if direction mod 2 = 1 then
		for i : 1 .. 2
		    for j : 1 .. 4
			drawDiamond (bottom_leftX + i * (width div 3), bottom_leftY + j * (height div 5), width div 3, height div 3, shapeC, j < 3, true)
		    end for
		end for
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + 2 * (height div 3), width div 3, height div 3, shapeC, false, true)
		drawDiamond (bottom_leftX + (width div 2), bottom_leftY + (height div 3), width div 3, height div 3, shapeC, true, true)
	    else
		for i : 1 .. 2
		    for j : 1 .. 4
			drawDiamond (bottom_leftX + j * (height div 5), bottom_leftY + i * (width div 3), width div 3, height div 3, shapeC, j < 3, false)
		    end for
		end for
		drawDiamond (bottom_leftX + 2 * (height div 3), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, false, false)
		drawDiamond (bottom_leftX + (height div 3), bottom_leftY + (width div 2), width div 3, height div 3, shapeC, true, false)
	    end if
	label 11 :
	    if simpleG then
		var i : int
		if direction <= 2 then
		    i := 1
		else
		    i := -1
		end if
		if direction mod 2 = 1 then
		    var baseY : int := bottom_leftY + (height div 2)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillArc (centerX - i * (2 * height div 50), baseY - i * (4 * height div 50), (12 * width div 50), (10 * height div 50), 180 + (((i - 1) div 2) * 180), 370 + (((i - 1) div
			2) * 180), shapeC)
		    Draw.FillArc (centerX - i * (2 * height div 50), baseY - i * (4 * height div 50), (7 * width div 50), (9 * height div 50), 180 + (((i - 1) div 2) * 180), 370 + (((i - 1) div
			2) * 180), backC)
		    Draw.FillBox (centerX - i * (2 * height div 50) + i * (47 * width div 200), baseY - i * (6 * height div 50), centerX - i * (2 * height div 50) + i * (7 * width div 50), baseY + i
			* (11 * height div 50), shapeC)
		    Draw.FillBox (centerX + i * (13 * width div 50), baseY + i * (13 * height div 50), centerX + i * (0 * width div 50), baseY + i * (11 * height div 50), shapeC)
		else
		    var baseX : int := bottom_leftX + (height div 2)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillArc (baseX - i * (4 * height div 50), centerY + i * (2 * height div 50), (10 * height div 50), (12 * width div 50), 90 + (((i - 1) div 2) * 180), 280 + (((i - 1) div
			2) * 180), shapeC)
		    Draw.FillArc (baseX - i * (4 * height div 50), centerY + i * (2 * height div 50), (9 * height div 50), (7 * width div 50), 90 + (((i - 1) div 2) * 180), 280 + (((i - 1) div
			2) * 180), backC)
		    Draw.FillBox (baseX - i * (6 * height div 50), centerY + i * (2 * height div 50) - i * (47 * width div 200), baseX + i
			* (11 * height div 50), centerY + i * (2 * height div 50) - i * (7 * width div 50), shapeC)
		    Draw.FillBox (baseX + i * (13 * height div 50), centerY - i * (13 * width div 50), baseX + i * (11 * height div 50), centerY - i * (0 * width div 50), shapeC)
		end if
	    else
		var face : int := royalCard
		face := Pic.Scale (face, 6 * width div 10, 7 * height div 10)
		if direction mod 2 = 0 then
		    face := Pic.Rotate (face, 90, -1, -1)
		    if direction = 2 then
			face := Pic.Rotate (face, 180, -1, -1)
		    end if
		    Pic.Draw (face, bottom_leftX + height div 2 - 7 * height div 20, bottom_leftY + width div 2 - 6 * width div 20, 0)
		else
		    if direction = 3 then
			face := Pic.Rotate (face, 180, -1, -1)
		    end if
		    Pic.Draw (face, bottom_leftX + width div 2 - 6 * width div 20, bottom_leftY + height div 2 - 7 * height div 20, 0)
		end if
	    end if
	label 12 :
	    if simpleG then
		var i : int
		if direction <= 2 then
		    i := 1
		else
		    i := -1
		end if
		if direction mod 2 = 1 then
		    var baseY : int := bottom_leftY + (height div 2)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillOval (centerX, baseY, (12 * width div 50), (14 * height div 50), shapeC)
		    Draw.FillOval (centerX, baseY, (8 * width div 50), (13 * height div 50), backC)
		    var x : array 1 .. 4 of int
		    var y : array 1 .. 4 of int
		    x (1) := centerX - i * (30 * width div 100)
		    y (1) := baseY - i * (3 * height div 50)
		    x (2) := centerX - i * (30 * width div 100)
		    y (2) := baseY - i * (2 * height div 50)
		    x (3) := centerX + i * (26 * width div 100)
		    y (3) := baseY - i * (11 * height div 50)
		    x (4) := centerX + i * (28 * width div 100)
		    y (4) := baseY - i * (15 * height div 50)
		    Draw.FillPolygon (x, y, 4, shapeC)
		else
		    var baseX : int := bottom_leftX + (height div 2)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillOval (baseX, centerY, (14 * height div 50), (12 * width div 50), shapeC)
		    Draw.FillOval (baseX, centerY, (13 * height div 50), (8 * width div 50), backC)
		    var x : array 1 .. 4 of int
		    var y : array 1 .. 4 of int
		    y (1) := centerY + i * (30 * width div 100)
		    x (1) := baseX - i * (3 * height div 50)
		    y (2) := centerY + i * (30 * width div 100)
		    x (2) := baseX - i * (2 * height div 50)
		    y (3) := centerY - i * (26 * width div 100)
		    x (3) := baseX - i * (11 * height div 50)
		    y (4) := centerY - i * (28 * width div 100)
		    x (4) := baseX - i * (15 * height div 50)
		    Draw.FillPolygon (x, y, 4, shapeC)
		end if
	    else
		var face : int := royalCard
		face := Pic.Scale (face, 6 * width div 10, 7 * height div 10)
		if direction mod 2 = 0 then
		    face := Pic.Rotate (face, 90, -1, -1)
		    if direction = 2 then
			face := Pic.Rotate (face, 180, -1, -1)
		    end if
		    Pic.Draw (face, bottom_leftX + height div 2 - 7 * height div 20, bottom_leftY + width div 2 - 6 * width div 20, 0)
		else
		    if direction = 3 then
			face := Pic.Rotate (face, 180, -1, -1)
		    end if
		    Pic.Draw (face, bottom_leftX + width div 2 - 6 * width div 20, bottom_leftY + height div 2 - 7 * height div 20, 0)
		end if
	    end if

	label 13 :
	    if simpleG then
		var i : int
		if direction <= 2 then
		    i := 1
		else
		    i := -1
		end if
		if direction mod 2 = 1 then
		    var baseY : int := bottom_leftY + (height div 2)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillBox (centerX - i * (13 * width div 50), baseY - i * (13 * height div 50), centerX - i * (6 * width div 50), baseY - i * (11 * height div 50), shapeC)
		    Draw.FillBox (centerX - i * (13 * width div 50), baseY + i * (13 * height div 50), centerX - i * (6 * width div 50), baseY + i * (11 * height div 50), shapeC)
		    Draw.FillBox (centerX + i * (13 * width div 50), baseY - i * (13 * height div 50), centerX + i * (5 * width div 50), baseY - i * (11 * height div 50), shapeC)
		    Draw.FillBox (centerX + i * (13 * width div 50), baseY + i * (13 * height div 50), centerX + i * (5 * width div 50), baseY + i * (11 * height div 50), shapeC)
		    Draw.FillBox (centerX - i * (11 * width div 50), baseY + i * (11 * height div 50), centerX - i * (15 * width div 100), baseY - i * (11 * height div 50), shapeC)
		    var x : array 1 .. 8 of int
		    var y : array 1 .. 8 of int
		    x (1) := (centerX - i * (15 * width div 100))
		    y (1) := baseY - i * (5 * height div 50)
		    x (2) := (centerX - i * (15 * width div 100))
		    y (2) := baseY - i * (1 * height div 50)
		    x (3) := (centerX + i * (7 * width div 50))
		    y (3) := baseY + i * (11 * height div 50)
		    x (4) := (centerX + i * (11 * width div 50))
		    y (4) := baseY + i * (11 * height div 50)
		    x (5) := (centerX + i * (2 * width div 50))
		    y (5) := baseY + i * (3 * height div 50)                            %
		    x (6) := (centerX + i * (11 * width div 50))
		    y (6) := baseY - i * (11 * height div 50)
		    x (7) := (centerX + i * (7 * width div 50))
		    y (7) := baseY - i * (11 * height div 50)
		    x (8) := (centerX - i * (1 * width div 50))
		    y (8) := baseY + i * (1 * height div 50)
		    Draw.FillPolygon (x, y, 8, shapeC)
		else
		    i *= -1
		    var baseX : int := bottom_leftX + (height div 2)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillBox (baseX - i * (13 * height div 50), centerY - i * (13 * width div 50), baseX - i * (11 * height div 50), centerY - i * (6 * width div 50), shapeC)
		    Draw.FillBox (baseX + i * (13 * height div 50), centerY - i * (13 * width div 50), baseX + i * (11 * height div 50), centerY - i * (6 * width div 50), shapeC)
		    Draw.FillBox (baseX - i * (13 * height div 50), centerY + i * (13 * width div 50), baseX - i * (11 * height div 50), centerY + i * (5 * width div 50), shapeC)
		    Draw.FillBox (baseX + i * (13 * height div 50), centerY + i * (13 * width div 50), baseX + i * (11 * height div 50), centerY + i * (5 * width div 50), shapeC)
		    Draw.FillBox (baseX + i * (11 * height div 50), centerY - i * (11 * width div 50), baseX - i * (11 * height div 50), centerY - i * (15 * width div 100), shapeC)
		    var x : array 1 .. 8 of int
		    var y : array 1 .. 8 of int
		    y (1) := (centerY - i * (15 * width div 100))
		    x (1) := baseX + i * (5 * height div 50)
		    y (2) := (centerY - i * (15 * width div 100))
		    x (2) := baseX + i * (1 * height div 50)
		    y (3) := (centerY + i * (7 * width div 50))
		    x (3) := baseX - i * (11 * height div 50)
		    y (4) := (centerY + i * (11 * width div 50))
		    x (4) := baseX - i * (11 * height div 50)
		    y (5) := (centerY + i * (2 * width div 50))
		    x (5) := baseX - i * (3 * height div 50)                            %
		    y (6) := (centerY + i * (11 * width div 50))
		    x (6) := baseX + i * (11 * height div 50)
		    y (7) := (centerY + i * (7 * width div 50))
		    x (7) := baseX + i * (11 * height div 50)
		    y (8) := (centerY - i * (1 * width div 50))
		    x (8) := baseX - i * (1 * height div 50)
		    Draw.FillPolygon (x, y, 8, shapeC)
		end if
	    else
		var face : int := royalCard
		face := Pic.Scale (face, 6 * width div 10, 7 * height div 10)
		if direction mod 2 = 0 then
		    face := Pic.Rotate (face, 90, -1, -1)
		    if direction = 2 then
			face := Pic.Rotate (face, 180, -1, -1)
		    end if
		    Pic.Draw (face, bottom_leftX + height div 2 - 7 * height div 20, bottom_leftY + width div 2 - 6 * width div 20, 0)
		else
		    if direction = 3 then
			face := Pic.Rotate (face, 180, -1, -1)
		    end if
		    Pic.Draw (face, bottom_leftX + width div 2 - 6 * width div 20, bottom_leftY + height div 2 - 7 * height div 20, 0)
		end if
	    end if
    end case
end drawDiamondCard

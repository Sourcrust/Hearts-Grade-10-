proc drawCardNumber (bottom_leftX, bottom_leftY, width, height, card, direction, shapeC, backC : int)
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
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillBox (centerX - i * (46 * width div 100), baseY, centerX - i * (43 * width div 100), baseY + i * (height div 100), shapeC)
		    Draw.FillBox (centerX - i * (38 * width div 100), baseY, centerX - i * (34 * width div 100), baseY + i * (height div 100), shapeC)
		    var x : array 1 .. 7 of int
		    var y : array 1 .. 7 of int
		    x (1) := centerX - i * (45 * width div 100)
		    y (1) := baseY + i * (height div 100)
		    x (2) := centerX - i * (44 * width div 100)
		    y (2) := baseY + i * (height div 100)
		    x (3) := centerX - i * (82 * width div 200)
		    y (3) := baseY + i * (19 * height div 200)
		    x (4) := centerX - i * (37 * width div 100)
		    y (4) := baseY + i * (height div 100)
		    x (5) := centerX - i * (35 * width div 100)
		    y (5) := baseY + i * (height div 100)
		    x (6) := centerX - i * (39 * width div 100)
		    y (6) := baseY + i * (11 * height div 100)
		    x (7) := centerX - i * (41 * width div 100)
		    y (7) := baseY + i * (11 * height div 100)
		    Draw.FillPolygon (x, y, 7, shapeC)
		    Draw.FillBox (centerX - i * (43 * width div 100), baseY + i * (4 * height div 100), centerX - i * (37 * width div 100), baseY + i * (5 * height div 100), shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillBox (baseX, centerY + i * (46 * width div 100), baseX + i * (height div 100), centerY + i * (43 * width div 100), shapeC)
		    Draw.FillBox (baseX, centerY + i * (38 * width div 100), baseX + i * (height div 100), centerY + i * (34 * width div 100), shapeC)
		    var x : array 1 .. 7 of int
		    var y : array 1 .. 7 of int
		    y (1) := centerY + i * (45 * width div 100)
		    x (1) := baseX + i * (height div 100)
		    y (2) := centerY + i * (44 * width div 100)
		    x (2) := baseX + i * (height div 100)
		    y (3) := centerY + i * (82 * width div 200)
		    x (3) := baseX + i * (19 * height div 200)
		    y (4) := centerY + i * (37 * width div 100)
		    x (4) := baseX + i * (height div 100)
		    y (5) := centerY + i * (35 * width div 100)
		    x (5) := baseX + i * (height div 100)
		    y (6) := centerY + i * (39 * width div 100)
		    x (6) := baseX + i * (11 * height div 100)
		    y (7) := centerY + i * (41 * width div 100)
		    x (7) := baseX + i * (11 * height div 100)
		    Draw.FillPolygon (x, y, 7, shapeC)
		    Draw.FillBox (baseX + i * (4 * height div 100), centerY + i * (43 * width div 100), baseX + i * (5 * height div 100), centerY + i * (37 * width div 100), shapeC)
		end for
	    end if
	label 2 :
	    %draws 2
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    var x : array 1 .. 9 of int
		    var y : array 1 .. 9 of int
		    x (1) := centerX - i * (44 * width div 100)
		    y (1) := baseY + i * (height div 100)
		    x (2) := centerX - i * (44 * width div 100)
		    y (2) := baseY
		    x (3) := centerX - i * (36 * width div 100)
		    y (3) := baseY
		    x (4) := centerX - i * (34 * width div 100)
		    y (4) := baseY + i * (9 * height div 400)
		    x (5) := centerX - i * (36 * width div 100)
		    y (5) := baseY + i * (7 * height div 400)
		    x (6) := centerX - i * (82 * width div 200)
		    y (6) := baseY + i * (7 * height div 400)
		    x (7) := centerX - i * (36 * width div 100)
		    y (7) := baseY + i * (6 * height div 100)
		    x (8) := centerX - i * (71 * width div 200)
		    y (8) := baseY + i * (7 * height div 100)
		    x (9) := centerX - i * (38 * width div 100)
		    y (9) := baseY + i * (7 * height div 100)
		    Draw.FillPolygon (x, y, 9, shapeC)
		    %Draw.FillBox(centerX-i*(130*width div 400),baseY+i*(5*height div 100),centerX-i*(141*width div 400),baseY+i*(12*height div 100),backC)
		    Draw.FillArc (centerX - i * (80 * width div 200), baseY + i * (7 * height div 100), 19 * width div 400, 9 * height div 200, 0 + (((i - 1) div 2) * 180), 180 + (((i - 1) div 2) *
			180),
			shapeC)
		    Draw.FillArc (centerX - i * (81 * width div 200), baseY + i * (7 * height div 100), 2 * width div 100, 5 * height div 200, 0 + (((i - 1) div 2) * 180), 180 + (((i - 1) div 2) *
			180),
			backC)
		    %Draw.FillBox(centerX-i*(130*width div 400),baseY+i*(5*height div 100),centerX-i*(139*width div 400),
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    var x : array 1 .. 9 of int
		    var y : array 1 .. 9 of int
		    y (1) := centerY + i * (44 * width div 100)
		    x (1) := baseX + i * (height div 100)
		    y (2) := centerY + i * (44 * width div 100)
		    x (2) := baseX
		    y (3) := centerY + i * (36 * width div 100)
		    x (3) := baseX
		    y (4) := centerY + i * (34 * width div 100)
		    x (4) := baseX + i * (9 * height div 400)
		    y (5) := centerY + i * (36 * width div 100)
		    x (5) := baseX + i * (7 * height div 400)
		    y (6) := centerY + i * (82 * width div 200)
		    x (6) := baseX + i * (7 * height div 400)
		    y (7) := centerY + i * (36 * width div 100)
		    x (7) := baseX + i * (6 * height div 100)
		    y (8) := centerY + i * (71 * width div 200)
		    x (8) := baseX + i * (7 * height div 100)
		    y (9) := centerY + i * (38 * width div 100)
		    x (9) := baseX + i * (7 * height div 100)
		    Draw.FillPolygon (x, y, 9, shapeC)
		    %Draw.FillBox(centerX-i*(130*width div 400),baseY+i*(5*height div 100),centerX-i*(141*width div 400),baseY+i*(12*height div 100),backC)
		    Draw.FillArc (baseX + i * (7 * height div 100), centerY + i * (80 * width div 200), 9 * height div 200, 19 * width div 400, 270 + (((i - 1) div 2) * 180), 90 + (((i - 1) div 2) *
			180), shapeC)
		    Draw.FillArc (baseX + i * (7 * height div 100), centerY + i * (81 * width div 200), 5 * height div 200, 2 * width div 100, 270 + (((i - 1) div 2) * 180), 90 + (((i - 1) div 2) *
			180),
			backC)
		    %Draw.FillBox(centerX-i*(130*width div 400),baseY+i*(5*height div 100),centerX-i*(139*width div 400),
		end for
	    end if
	label 3 :
	    % %draws 3
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (7 * height div 200), (7 * height div 200), (7 * height div 200), shapeC)
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (16 * height div 200), (6 * height div 200), (6 * height div 200), shapeC)
		    Draw.FillBox (centerX - i * (46 * width div 100), baseY + i * (16 * height div 200), centerX - i * (41 * width div 100), baseY + i * (6 * height div 200), backC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (16 * height div 200), 3 * width div 200, 3 * height div 200, 0 + (((i - 1) div 2) * 180), 180 + (((i - 1) div 2) *
			180),
			backC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (16 * height div 200), 3 * width div 200, 4 * height div 200, 180 - (((i - 1) div 2) * 180), 360 - (((i - 1) div 2) *
			180), backC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (6 * height div 200), 4 * width div 200, 4 * height div 200, 0 + (((i - 1) div 2) * 180), 180 + (((i - 1) div 2) *
			180),
			backC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (6 * height div 200), 4 * width div 200, 3 * height div 200, 180 - (((i - 1) div 2) * 180), 360 - (((i - 1) div 2) *
			180), backC)
		    Draw.FillBox (centerX - i * (38 * width div 100), baseY + i * (25 * height div 400), centerX - i * (82 * width div 200), baseY + i * (10 * height div 200), shapeC)
		    Draw.FillOval (centerX - i * (43 * width div 100), baseY + i * (10 * height div 400), (2 * height div 200), (4 * height div 400), shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillOval (baseX + i * (7 * height div 200), centerY + i * (40 * width div 100), (7 * height div 200), (7 * height div 200), shapeC)
		    Draw.FillOval (baseX + i * (16 * height div 200), centerY + i * (40 * width div 100), (6 * height div 200), (6 * height div 200), shapeC)
		    Draw.FillBox (baseX + i * (16 * height div 200), centerY + i * (46 * width div 100), baseX + i * (6 * height div 200), centerY + i * (41 * width div 100), backC)
		    Draw.FillArc (baseX + i * (16 * height div 200), centerY + i * (40 * width div 100), 3 * height div 200, 3 * width div 200, 270 + (((i - 1) div 2) * 180), 90 + (((i - 1) div 2) *
			180), backC)
		    Draw.FillArc (baseX + i * (16 * height div 200), centerY + i * (40 * width div 100), 4 * height div 200, 3 * width div 200, 90 - (((i - 1) div 2) * 180), 270 - (((i - 1) div 2) *
			180), backC)
		    Draw.FillArc (baseX + i * (6 * height div 200), centerY + i * (40 * width div 100), 4 * height div 200, 4 * width div 200, 270 + (((i - 1) div 2) * 180), 90 + (((i - 1) div 2) *
			180),
			backC)
		    Draw.FillArc (baseX + i * (6 * height div 200), centerY + i * (40 * width div 100), 3 * height div 200, 4 * width div 200, 90 - (((i - 1) div 2) * 180), 270 - (((i - 1) div 2) *
			180),
			backC)
		    Draw.FillBox (baseX + i * (25 * height div 400), centerY + i * (38 * width div 100), baseX + i * (10 * height div 200), centerY + i * (82 * width div 200), shapeC)
		    Draw.FillOval (baseX + i * (10 * height div 400), centerY + i * (43 * width div 100), (4 * height div 400), (2 * height div 200), shapeC)
		end for
	    end if
	label 4 :
	    %draws 4
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillBox (centerX - i * (39 * width div 100), baseY, centerX - i * (37 * width div 100), baseY + i * (8 * height div 100), shapeC)
		    Draw.FillBox (centerX - i * (45 * width div 100), baseY + i * (3 * height div 100), centerX - i * (35 * width div 100), baseY + i * (4 * height div 100), shapeC)
		    var x : array 1 .. 6 of int
		    var y : array 1 .. 6 of int
		    x (1) := centerX - i * (45 * width div 100)
		    y (1) := baseY + i * (4 * height div 100)
		    x (2) := centerX - i * (43 * width div 100)
		    y (2) := baseY + i * (4 * height div 100)
		    x (3) := centerX - i * (39 * width div 100)
		    y (3) := baseY + i * (8 * height div 100)
		    x (4) := centerX - i * (37 * width div 100)
		    y (4) := baseY + i * (8 * height div 100)
		    x (5) := centerX - i * (37 * width div 100)
		    y (5) := baseY + i * (11 * height div 100)
		    x (6) := centerX - i * (38 * width div 100)
		    y (6) := baseY + i * (11 * height div 100)
		    Draw.FillPolygon (x, y, 6, shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillBox (baseX, centerY + i * (39 * width div 100), baseX + i * (8 * height div 100), centerY + i * (37 * width div 100), shapeC)
		    Draw.FillBox (baseX + i * (3 * height div 100), centerY + i * (45 * width div 100), baseX + i * (4 * height div 100), centerY + i * (35 * width div 100), shapeC)
		    var x : array 1 .. 6 of int
		    var y : array 1 .. 6 of int
		    y (1) := centerY + i * (45 * width div 100)
		    x (1) := baseX + i * (4 * height div 100)
		    y (2) := centerY + i * (43 * width div 100)
		    x (2) := baseX + i * (4 * height div 100)
		    y (3) := centerY + i * (39 * width div 100)
		    x (3) := baseX + i * (8 * height div 100)
		    y (4) := centerY + i * (37 * width div 100)
		    x (4) := baseX + i * (8 * height div 100)
		    y (5) := centerY + i * (37 * width div 100)
		    x (5) := baseX + i * (11 * height div 100)
		    y (6) := centerY + i * (38 * width div 100)
		    x (6) := baseX + i * (11 * height div 100)
		    Draw.FillPolygon (x, y, 6, shapeC)
		end for
	    end if
	label 5 :
	    %draws 5
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (4 * height div 100), (8 * height div 200), (8 * height div 200), 198 + (((i - 1) div 2) * 180), 130 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (4 * height div 100), (9 * height div 400), (5 * height div 200), backC)
		    var x : array 1 .. 4 of int
		    var y : array 1 .. 4 of int
		    x (1) := centerX - i * (44 * width div 100)
		    y (1) := baseY + i * (12 * height div 200)
		    x (2) := centerX - i * (42 * width div 100)
		    y (2) := baseY + i * (12 * height div 200)
		    x (3) := centerX - i * (84 * width div 200)
		    y (3) := baseY + i * (11 * height div 100)
		    x (4) := centerX - i * (87 * width div 200)
		    y (4) := baseY + i * (11 * height div 100)
		    Draw.FillPolygon (x, y, 4, shapeC)
		    Draw.FillBox (centerX - i * (87 * width div 200), baseY + i * (23 * height div 200), centerX - i * (37 * width div 100), baseY + i * (10 * height div 100), shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillArc (baseX + i * (4 * height div 100), centerY + i * (40 * width div 100), (8 * height div 200), (8 * height div 200), 108 + (((i - 1) div 2) * 180), 40 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillOval (baseX + i * (4 * height div 100), centerY + i * (40 * width div 100), (5 * height div 200), (9 * height div 400), backC)
		    var x : array 1 .. 4 of int
		    var y : array 1 .. 4 of int
		    y (1) := centerY + i * (44 * width div 100)
		    x (1) := baseX + i * (12 * height div 200)
		    y (2) := centerY + i * (42 * width div 100)
		    x (2) := baseX + i * (12 * height div 200)
		    y (3) := centerY + i * (84 * width div 200)
		    x (3) := baseX + i * (11 * height div 100)
		    y (4) := centerY + i * (87 * width div 200)
		    x (4) := baseX + i * (11 * height div 100)
		    Draw.FillPolygon (x, y, 4, shapeC)
		    Draw.FillBox (baseX + i * (23 * height div 200), centerY + i * (87 * width div 200), baseX + i * (10 * height div 100), centerY + i * (37 * width div 100), shapeC)
		end for
	    end if
	label 6 :
	    %draws 6
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillArc (centerX - i * (36 * width div 100), baseY + i * (7 * height div 100), (17 * width div 200), (18 * height div 400), 95 + (((i - 1) div 2) * 180), 190 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (centerX - i * (36 * width div 100), baseY + i * (7 * height div 100), (11 * width div 200), (14 * height div 400), 75 + (((i - 1) div 2) * 180), 190 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (4 * height div 100), (9 * width div 200), (15 * height div 400), shapeC)
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (4 * height div 100), (7 * width div 400), (11 * height div 400), backC)
		    Draw.FillBox (centerX - i * (179 * width div 400), baseY + i * (6 * height div 200), centerX - i * (42 * width div 100), baseY + i * (7 * height div 100), shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillArc (baseX + i * (7 * height div 100), centerY + i * (36 * width div 100), (18 * height div 400), (17 * width div 200), 5 + (((i - 1) div 2) * 180), 100 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (baseX + i * (7 * height div 100), centerY + i * (36 * width div 100), (14 * height div 400), (11 * width div 200), 355 + (((i - 1) div 2) * 180), 100 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillOval (baseX + i * (4 * height div 100), centerY + i * (40 * width div 100), (15 * height div 400), (9 * width div 200), shapeC)
		    Draw.FillOval (baseX + i * (4 * height div 100), centerY + i * (40 * width div 100), (11 * height div 400), (7 * width div 400), backC)
		    Draw.FillBox (baseX + i * (6 * height div 200), centerY + i * (179 * width div 400), baseX + i * (7 * height div 100), centerY + i * (42 * width div 100), shapeC)
		end for
	    end if
	label 7 :
	    %draws 7
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    var x : array 1 .. 9 of int
		    var y : array 1 .. 9 of int
		    x (1) := centerX - i * (42 * width div 100)
		    y (1) := baseY
		    x (2) := centerX - i * (40 * width div 100)
		    y (2) := baseY
		    x (3) := centerX - i * (35 * width div 100)
		    y (3) := baseY + i * (10 * height div 100)
		    x (4) := centerX - i * (35 * width div 100)
		    y (4) := baseY + i * (11 * height div 100)
		    x (5) := centerX - i * (44 * width div 100)
		    y (5) := baseY + i * (11 * height div 100)
		    x (6) := centerX - i * (45 * width div 100)
		    y (6) := baseY + i * (8 * height div 100)
		    x (7) := centerX - i * (89 * width div 200)
		    y (7) := baseY + i * (15 * height div 200)
		    x (8) := centerX - i * (87 * width div 200)
		    y (8) := baseY + i * (9 * height div 100)
		    x (9) := centerX - i * (37 * width div 100)
		    y (9) := baseY + i * (9 * height div 100)
		    Draw.FillPolygon (x, y, 9, shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    var x : array 1 .. 9 of int
		    var y : array 1 .. 9 of int
		    y (1) := centerY + i * (42 * width div 100)
		    x (1) := baseX
		    y (2) := centerY + i * (40 * width div 100)
		    x (2) := baseX
		    y (3) := centerY + i * (35 * width div 100)
		    x (3) := baseX + i * (10 * height div 100)
		    y (4) := centerY + i * (35 * width div 100)
		    x (4) := baseX + i * (11 * height div 100)
		    y (5) := centerY + i * (44 * width div 100)
		    x (5) := baseX + i * (11 * height div 100)
		    y (6) := centerY + i * (45 * width div 100)
		    x (6) := baseX + i * (8 * height div 100)
		    y (7) := centerY + i * (89 * width div 200)
		    x (7) := baseX + i * (15 * height div 200)
		    y (8) := centerY + i * (87 * width div 200)
		    x (8) := baseX + i * (9 * height div 100)
		    y (9) := centerY + i * (37 * width div 100)
		    x (9) := baseX + i * (9 * height div 100)
		    Draw.FillPolygon (x, y, 9, shapeC)
		end for
	    end if
	label 8 :
	    %Draws 8
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (3 * height div 100), (9 * width div 200), (6 * height div 200), 180 + (((i - 1) div 2) * 180), 0 + (((i - 1) div 2) *
			180), shapeC)
		    Draw.FillArc (centerX - i * (80 * width div 200), baseY + i * (3 * height div 100), (4 * width div 200), (6 * height div 400), 41 + (((i - 1) div 2) * 180), 40 + (((i - 1) div 2) *
			180), backC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (9 * height div 100), (9 * width div 200), (6 * height div 200), 360 + (((i - 1) div 2) * 180), 180 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (centerX - i * (80 * width div 200), baseY + i * (9 * height div 100), (4 * width div 200), (6 * height div 400), 221 + (((i - 1) div 2) * 180), 220 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (3 * height div 100), (9 * width div 200), (13 * height div 400), 90 + (((i - 1) div 2) * 180), 180 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (9 * height div 100), (9 * width div 200), (13 * height div 400), 270 + (((i - 1) div 2) * 180), 0 + (((i - 1) div 2)
			*
			180), shapeC)
		    Draw.FillArc (centerX - i * (80 * width div 200), baseY + i * (3 * height div 100), (4 * width div 200), (16 * height div 800), 90 + (((i - 1) div 2) * 180), 180 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillArc (centerX - i * (80 * width div 200), baseY + i * (9 * height div 100), (4 * width div 200), (16 * height div 800), 270 + (((i - 1) div 2) * 180), 0 + (((i - 1) div 2)
			*
			180), backC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (3 * height div 100), (9 * width div 200), (15 * height div 400), 0 + (((i - 1) div 2) * 180), 100 + (((i - 1) div 2)
			*
			180), shapeC)
		    Draw.FillArc (centerX - i * (40 * width div 100), baseY + i * (9 * height div 100), (9 * width div 200), (15 * height div 400), 180 + (((i - 1) div 2) * 180), 280 + (((i - 1) div
			2) *
			180), shapeC)
		    var x : array 1 .. 3 of int
		    var y : array 1 .. 3 of int
		    x (1) := centerX - i * ((40 * width div 100) - (4 * width div 200))
		    y (1) := baseY + i * (3 * height div 100)
		    x (2) := centerX - i * (81 * width div 200)
		    y (2) := baseY + i * (3 * height div 100)
		    x (3) := centerX - i * (81 * width div 200)
		    y (3) := baseY + i * (19 * height div 400)
		    Draw.FillPolygon (x, y, 3, backC)
		    x (1) := centerX - i * ((40 * width div 100) + (4 * width div 200))
		    y (1) := baseY + i * (9 * height div 100)
		    x (2) := centerX - i * (79 * width div 200)
		    y (2) := baseY + i * (9 * height div 100)
		    x (3) := centerX - i * (79 * width div 200)
		    y (3) := baseY + i * (29 * height div 400)
		    Draw.FillPolygon (x, y, 3, backC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillArc (baseX + i * (3 * height div 100), centerY + i * (40 * width div 100), (6 * height div 200), (9 * width div 200), 90 + (((i - 1) div 2) * 180), 270 + (((i - 1) div 2)
			*
			180), shapeC)
		    Draw.FillArc (baseX + i * (3 * height div 100), centerY + i * (80 * width div 200), (6 * height div 400), (4 * width div 200), 311 + (((i - 1) div 2) * 180), 310 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillArc (baseX + i * (9 * height div 100), centerY + i * (40 * width div 100), (6 * height div 200), (9 * width div 200), 270 + (((i - 1) div 2) * 180), 90 + (((i - 1) div 2)
			*
			180), shapeC)
		    Draw.FillArc (baseX + i * (9 * height div 100), centerY + i * (80 * width div 200), (6 * height div 400), (4 * width div 200), 131 + (((i - 1) div 2) * 180), 130 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillArc (baseX + i * (3 * height div 100), centerY + i * (40 * width div 100), (13 * height div 400), (9 * width div 200), 0 + (((i - 1) div 2) * 180), 90 + (((i - 1) div 2) *
			180), shapeC)
		    Draw.FillArc (baseX + i * (9 * height div 100), centerY + i * (40 * width div 100), (13 * height div 400), (9 * width div 200), 180 + (((i - 1) div 2) * 180), 270 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (baseX + i * (3 * height div 100), centerY + i * (80 * width div 200), (16 * height div 800), (4 * width div 200), 0 + (((i - 1) div 2) * 180), 90 + (((i - 1) div 2) *
			180), backC)
		    Draw.FillArc (baseX + i * (9 * height div 100), centerY + i * (80 * width div 200), (16 * height div 800), (4 * width div 200), 90 + (((i - 1) div 2) * 180), 270 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillArc (baseX + i * (3 * height div 100), centerY + i * (40 * width div 100), (15 * height div 400), (9 * width div 200), 270 + (((i - 1) div 2) * 180), 10 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (baseX + i * (9 * height div 100), centerY + i * (40 * width div 100), (15 * height div 400), (9 * width div 200), 90 + (((i - 1) div 2) * 180), 190 + (((i - 1) div
			2) *
			180), shapeC)
		    var x : array 1 .. 3 of int
		    var y : array 1 .. 3 of int
		    y (1) := centerY + i * ((40 * width div 100) - (4 * width div 200))
		    x (1) := baseX + i * (3 * height div 100)
		    y (2) := centerY + i * (81 * width div 200)
		    x (2) := baseX + i * (3 * height div 100)
		    y (3) := centerY + i * (81 * width div 200)
		    x (3) := baseX + i * (19 * height div 400)
		    Draw.FillPolygon (x, y, 3, backC)
		    y (1) := centerY + i * ((40 * width div 100) + (4 * width div 200))
		    x (1) := baseX + i * (9 * height div 100)
		    y (2) := centerY + i * (79 * width div 200)
		    x (2) := baseX + i * (9 * height div 100)
		    y (3) := centerY + i * (79 * width div 200)
		    x (3) := baseX + i * (29 * height div 400)
		    Draw.FillPolygon (x, y, 3, backC)
		end for
	    end if
	label 9 :
	    %Draws 9
	    if direction mod 2 = 1 then
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillArc (centerX - i * (44 * width div 100), baseY + i * (4 * height div 100), (17 * width div 200), (18 * height div 400), 267 + (((i - 1) div 2) * 180), 40 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (centerX - i * (44 * width div 100), baseY + i * (4 * height div 100), (11 * width div 200), (14 * height div 400), 240 + (((i - 1) div 2) * 180), 40 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (7 * height div 100), (9 * width div 200), (15 * height div 400), shapeC)
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (7 * height div 100), (7 * width div 400), (11 * height div 400), backC)
		    Draw.FillBox (centerX - i * (144 * width div 400), baseY + i * (13 * height div 400), centerX - i * (143 * width div 400), baseY + i * (12 * height div 200), shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillArc (baseX + i * (4 * height div 100), centerY + i * (44 * width div 100), (18 * height div 400), (17 * width div 200), 177 + (((i - 1) div 2) * 180), 310 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (baseX + i * (4 * height div 100), centerY + i * (44 * width div 100), (14 * height div 400), (11 * width div 200), 147 + (((i - 1) div 2) * 180), 310 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillOval (baseX + i * (7 * height div 100), centerY + i * (40 * width div 100), (15 * height div 400), (9 * width div 200), shapeC)
		    Draw.FillOval (baseX + i * (7 * height div 100), centerY + i * (40 * width div 100), (11 * height div 400), (7 * width div 400), backC)
		    Draw.FillBox (baseX + i * (13 * height div 400), centerY + i * (144 * width div 400), baseX + i * (12 * height div 200), centerY + i * (143 * width div 400), shapeC)
		end for
	    end if
	label 10 :
	    %draws 10
	    if direction mod 2 = 1 then

		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillOval (centerX - i * (37 * width div 100), baseY + i * (6 * height div 100), (15 * width div 400), (21 * height div 400), shapeC)
		    Draw.FillOval (centerX - i * (37 * width div 100), baseY + i * (6 * height div 100), (3 * width div 200), (4 * height div 100), backC)
		    var x : array 1 .. 11 of int
		    var y : array 1 .. 11 of int
		    var j : int
		    if width < 200 then
			j := 3
		    else
			j := 2
		    end if
		    x (1) := centerX - i * (120 * width div 300)
		    y (1) := baseY + i * (7 * height div 400)
		    x (2) := centerX - i * (120 * width div 300)
		    y (2) := baseY + i * (j * height div 200)
		    x (3) := centerX - i * (138 * width div 300)
		    y (3) := baseY + i * (j * height div 200)
		    x (4) := centerX - i * (138 * width div 300)
		    y (4) := baseY + i * (7 * height div 400)
		    x (5) := centerX - i * (131 * width div 300)
		    y (5) := baseY + i * (7 * height div 400)
		    x (6) := centerX - i * (131 * width div 300)
		    y (6) := baseY + i * (10 * height div 100)
		    x (7) := centerX - i * (138 * width div 300)
		    y (7) := baseY + i * (19 * height div 200)
		    x (8) := centerX - i * (138 * width div 300)
		    y (8) := baseY + i * (10 * height div 100)
		    x (9) := centerX - i * (130 * width div 300)
		    y (9) := baseY + i * (11 * height div 100)
		    x (10) := centerX - i * (126 * width div 300)
		    y (10) := baseY + i * (11 * height div 100)
		    x (11) := centerX - i * (126 * width div 300)
		    y (11) := baseY + i * (7 * height div 400)
		    Draw.FillPolygon (x, y, 11, shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillOval (baseX + i * (6 * height div 100), centerY + i * (37 * width div 100), (21 * height div 400), (15 * width div 400), shapeC)
		    Draw.FillOval (baseX + i * (6 * height div 100), centerY + i * (37 * width div 100), (4 * height div 100), (3 * width div 200), backC)
		    var x : array 1 .. 11 of int
		    var y : array 1 .. 11 of int
		    var j : int
		    if width < 200 then
			j := 3
		    else
			j := 2
		    end if
		    y (1) := centerY + i * (120 * width div 300)
		    x (1) := baseX + i * (7 * height div 400)
		    y (2) := centerY + i * (120 * width div 300)
		    x (2) := baseX + i * (j * height div 200)
		    y (3) := centerY + i * (138 * width div 300)
		    x (3) := baseX + i * (j * height div 200)
		    y (4) := centerY + i * (138 * width div 300)
		    x (4) := baseX + i * (7 * height div 400)
		    y (5) := centerY + i * (131 * width div 300)
		    x (5) := baseX + i * (7 * height div 400)
		    y (6) := centerY + i * (131 * width div 300)
		    x (6) := baseX + i * (10 * height div 100)
		    y (7) := centerY + i * (138 * width div 300)
		    x (7) := baseX + i * (19 * height div 200)
		    y (8) := centerY + i * (138 * width div 300)
		    x (8) := baseX + i * (10 * height div 100)
		    y (9) := centerY + i * (130 * width div 300)
		    x (9) := baseX + i * (11 * height div 100)
		    y (10) := centerY + i * (126 * width div 300)
		    x (10) := baseX + i * (11 * height div 100)
		    y (11) := centerY + i * (126 * width div 300)
		    x (11) := baseX + i * (7 * height div 400)
		    Draw.FillPolygon (x, y, 11, shapeC)
		end for
	    end if
	label 11 :
	    if direction mod 2 = 0 then
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillArc (baseX + i * (3 * height div 100), centerY + i * (41 * width div 100), (3 * height div 100), (4 * width div 100), 90 + (((i - 1) div 2) * 180), 280 + (((i - 1) div 2)
			*
			180), shapeC)
		    Draw.FillArc (baseX + i * (3 * height div 100), centerY + i * (41 * width div 100), (2 * height div 100), (2 * width div 100), 90 + (((i - 1) div 2) * 180), 280 + (((i - 1) div 2)
			*
			180), backC)
		    Draw.FillBox (baseX + i * (2 * height div 100), centerY + i * (39 * width div 100), baseX + i * (10 * height div 100), centerY + i * (37 * width div 100), shapeC)
		    Draw.FillBox (baseX + i * (10 * height div 100), centerY + i * (40 * width div 100), baseX + i * (21 * height div 200), centerY + i * (36 * width div 100), shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillArc (centerX - i * (41 * width div 100), baseY + i * (3 * height div 100), (4 * width div 100), (3 * height div 100), 180 + (((i - 1) div 2) * 180), 370 + (((i - 1) div
			2) *
			180), shapeC)
		    Draw.FillArc (centerX - i * (41 * width div 100), baseY + i * (3 * height div 100), (2 * width div 100), (2 * height div 100), 180 + (((i - 1) div 2) * 180), 370 + (((i - 1) div
			2) *
			180), backC)
		    Draw.FillBox (centerX - i * (39 * width div 100), baseY + i * (2 * height div 100), centerX - i * (37 * width div 100), baseY + i * (10 * height div 100), shapeC)
		    Draw.FillBox (centerX - i * (40 * width div 100), baseY + i * (10 * height div 100), centerX - i * (36 * width div 100), baseY + i * (21 * height div 200), shapeC)
		end for
	    end if
	label 12 :
	    if direction mod 2 = 0 then
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillOval (baseX + i * (6 * height div 100), centerY + i * (40 * width div 100), (6 * height div 100), (4 * width div 100), shapeC)
		    Draw.FillOval (baseX + i * (6 * height div 100), centerY + i * (40 * width div 100), (5 * height div 100), (2 * width div 100), backC)
		    var x : array 1 .. 4 of int
		    var y : array 1 .. 4 of int
		    y (1) := centerY + i * (45 * width div 100)
		    x (1) := baseX + i * (5 * height div 100)
		    y (2) := centerY + i * (45 * width div 100)
		    x (2) := baseX + i * (4 * height div 100)
		    y (3) := centerY + i * (35 * width div 100)
		    x (3) := baseX + i * (0 * height div 100)
		    y (4) := centerY + i * (35 * width div 100)
		    x (4) := baseX + i * (2 * height div 100)
		    Draw.FillPolygon (x, y, 4, shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (6 * height div 100), (4 * width div 100), (6 * height div 100), shapeC)
		    Draw.FillOval (centerX - i * (40 * width div 100), baseY + i * (6 * height div 100), (2 * width div 100), (5 * height div 100), backC)
		    var x : array 1 .. 4 of int
		    var y : array 1 .. 4 of int
		    x (1) := centerX - i * (45 * width div 100)
		    y (1) := baseY + i * (5 * height div 100)
		    x (2) := centerX - i * (45 * width div 100)
		    y (2) := baseY + i * (4 * height div 100)
		    x (3) := centerX - i * (35 * width div 100)
		    y (3) := baseY + i * (0 * height div 100)
		    x (4) := centerX - i * (35 * width div 100)
		    y (4) := baseY + i * (2 * height div 100)
		    Draw.FillPolygon (x, y, 4, shapeC)
		end for
	    end if
	label 13 :
	    if direction mod 2 = 0 then
		for i : -1 .. 1 by 2
		    var baseX : int := bottom_leftX + (height div 2) + i * (3 * height div 8)
		    var centerY : int := bottom_leftY + width div 2
		    Draw.FillBox (baseX, centerY + i * (38 * width div 100), baseX + i * (1 * height div 100), centerY + i * (34 * width div 100), shapeC)
		    Draw.FillBox (baseX + i * (10 * height div 100), centerY + i * (38 * width div 100), baseX + i * (11 * height div 100), centerY + i * (34 * width div 100), shapeC)
		    Draw.FillBox (baseX, centerY + i * (42 * width div 100), baseX + i * (1 * height div 100), centerY + i * (45 * width div 100), shapeC)
		    Draw.FillBox (baseX + i * (10 * height div 100), centerY + i * (42 * width div 100), baseX + i * (11 * height div 100), centerY + i * (45 * width div 100), shapeC)
		    Draw.FillBox (baseX + i * (10 * height div 100), centerY + i * (43 * width div 100), baseX + i * (1 * height div 100), centerY + i * (44 * width div 100), shapeC)
		    var x : array 1 .. 8 of int
		    var y : array 1 .. 8 of int
		    y (1) := (centerY + i * (43 * width div 100))
		    x (1) := baseX + i * (3 * height div 100)
		    y (2) := (centerY + i * (43 * width div 100))
		    x (2) := baseX + i * (11 * height div 200)
		    y (3) := (centerY + i * (37 * width div 100))
		    x (3) := baseX + i * (10 * height div 100)
		    y (4) := (centerY + i * (35 * width div 100))
		    x (4) := baseX + i * (10 * height div 100)
		    y (5) := (centerY + i * (40 * width div 100))
		    x (5) := baseX + i * (6 * height div 100)
		    y (6) := (centerY + i * (35 * width div 100))
		    x (6) := baseX + i * (1 * height div 100)
		    y (7) := (centerY + i * (37 * width div 100))
		    x (7) := baseX + i * (1 * height div 100)
		    y (8) := (centerY + i * (41 * width div 100))
		    x (8) := baseX + i * (5 * height div 100)
		    Draw.FillPolygon (x, y, 8, shapeC)
		end for
	    else
		for i : -1 .. 1 by 2
		    var baseY : int := bottom_leftY + (height div 2) + i * (3 * height div 8)
		    var centerX : int := bottom_leftX + width div 2
		    Draw.FillBox (centerX - i * (38 * width div 100), baseY, centerX - i * (34 * width div 100), baseY + i * (1 * height div 100), shapeC)
		    Draw.FillBox (centerX - i * (38 * width div 100), baseY + i * (10 * height div 100), centerX - i * (34 * width div 100), baseY + i * (11 * height div 100), shapeC)
		    Draw.FillBox (centerX - i * (42 * width div 100), baseY, centerX - i * (45 * width div 100), baseY + i * (1 * height div 100), shapeC)
		    Draw.FillBox (centerX - i * (42 * width div 100), baseY + i * (10 * height div 100), centerX - i * (45 * width div 100), baseY + i * (11 * height div 100), shapeC)
		    Draw.FillBox (centerX - i * (43 * width div 100), baseY + i * (10 * height div 100), centerX - i * (44 * width div 100), baseY + i * (1 * height div 100), shapeC)
		    var x : array 1 .. 8 of int
		    var y : array 1 .. 8 of int
		    x (1) := (centerX - i * (43 * width div 100))
		    y (1) := baseY + i * (3 * height div 100)
		    x (2) := (centerX - i * (43 * width div 100))
		    y (2) := baseY + i * (11 * height div 200)
		    x (3) := (centerX - i * (37 * width div 100))
		    y (3) := baseY + i * (10 * height div 100)
		    x (4) := (centerX - i * (35 * width div 100))
		    y (4) := baseY + i * (10 * height div 100)
		    x (5) := (centerX - i * (40 * width div 100))
		    y (5) := baseY + i * (6 * height div 100)
		    x (6) := (centerX - i * (35 * width div 100))
		    y (6) := baseY + i * (1 * height div 100)
		    x (7) := (centerX - i * (37 * width div 100))
		    y (7) := baseY + i * (1 * height div 100)
		    x (8) := (centerX - i * (41 * width div 100))
		    y (8) := baseY + i * (5 * height div 100)
		    Draw.FillPolygon (x, y, 8, shapeC)
		end for
	    end if
    end case
end drawCardNumber

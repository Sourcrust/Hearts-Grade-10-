proc drawCardBack (bottom_leftX, bottom_leftY, width, height, direction, cardBack : int)
    %const FACE_FILE_NAME : string := "face_cards.txt"
    if cardBack ~= -1 then
	var back := Pic.Scale (cardBack, width, height)
	case direction of
	    label 2 :
		back := Pic.Rotate (back, 270, -1, -1)
	    label 3 :
		back := Pic.Rotate (back, 180, -1, -1)
	    label 4 :
		back := Pic.Rotate (back, 90, -1, -1)
	    label :
	end case
	Pic.Draw (back, bottom_leftX, bottom_leftY, picCopy)
	if direction mod 2 = 1 then
	    Draw.Box (bottom_leftX, bottom_leftY, bottom_leftX + width, bottom_leftY + height, black)
	else
	    Draw.Box (bottom_leftX, bottom_leftY, bottom_leftX + height, bottom_leftY + width, black)
	end if
    else
	if direction mod 2 = 1 then
	    Draw.FillBox (bottom_leftX, bottom_leftY, bottom_leftX + width, bottom_leftY + height, white)
	    Draw.Box (bottom_leftX, bottom_leftY, bottom_leftX + width, bottom_leftY + height, black)
	    for i : 1 .. 21
		for j : 1 .. 16
		    if (i + j) mod 2 = 0 then
			Draw.FillBox (bottom_leftX + (2 + j - 1) * width div 20, bottom_leftY + (2 + i - 1) * height div 25, bottom_leftX + (2 + j) * width div 20, bottom_leftY + (2 + i) * height div
			    25, 12)
		    end if
		end for
	    end for
	    Draw.Box (bottom_leftX + 2 * width div 20, bottom_leftY + 2 * height div 25, bottom_leftX + 18 * width div 20, bottom_leftY + 23 * height div 25, black)
	else
	    Draw.FillBox (bottom_leftX, bottom_leftY, bottom_leftX + height, bottom_leftY + width, white)
	    Draw.Box (bottom_leftX, bottom_leftY, bottom_leftX + height, bottom_leftY + width, black)
	    for i : 1 .. 21
		for j : 1 .. 16
		    if (i + j) mod 2 = 0 then
			Draw.FillBox (bottom_leftX + (2 + i - 1) * height div 25, bottom_leftY + (2 + j - 1) * width div 20, bottom_leftX + (2 + i) * height div
			    25, bottom_leftY + (2 + j) * width div 20, 12)
		    end if
		end for
	    end for
	    Draw.Box (bottom_leftX + 2 * height div 25, bottom_leftY + 2 * width div 20, bottom_leftX + 23 * height div 25, bottom_leftY + 18 * width div 20, black)
	end if
    end if
end drawCardBack


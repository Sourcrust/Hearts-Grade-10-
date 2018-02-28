
class Card
    export setCardColourBack, setCardColour, setCardSize, setCardCoordinates, drawCard, flipCard, setDirection, returnCardWidth, returnCardHeight, returnCardX, returnCardY, returnCardC,
	returnCardBackC, returnCardDir, returnCardN, returnCardisFlipped, returnCardSuit, setCard, changeCardSimpleG, returnCardSimpleG
    include "SpadeCard.t"
    include "HeartCard.t"
    include "ClubCard.t"
    include "DiamondCard.t"
    include "CardNumber.t"
    include "CardBack.t"
    const FACE_FILE_NAME : string := "face_cards.txt"
    const COLOUR_FILE_NAME : string := "card_colours.txt"
    var width, height : int
    var bottom_leftX, bottom_leftY : int
    var cardC : int := 7
    var backC : int := 0
    var direction : int := 1
    var cardN : int
    var flipped : boolean := false
    var suit : int
    var simpleG : boolean := false
    var backCard : int := -1
    var royalCard : int := -1

    proc changeCardSimpleG
	simpleG := ~simpleG
    end changeCardSimpleG

    proc setCardColourBack (c : int)
	backC := c
    end setCardColourBack

    proc setCardColour (c : int)
	cardC := c
    end setCardColour

    proc setCardSize (w : int, h : int)
	width := w
	height := h
    end setCardSize

    proc setCardCoordinates (x : int, y : int)
	bottom_leftX := x
	bottom_leftY := y
    end setCardCoordinates

    proc setDirection (n : int)
	direction := n
    end setDirection

    proc flipCard
	flipped := ~flipped
    end flipCard

    fcn returnCardN : int
	result cardN
    end returnCardN

    fcn returnCardSuit : int
	result suit
    end returnCardSuit

    fcn returnCardDir : int
	result direction
    end returnCardDir

    fcn returnCardWidth : int
	result width
    end returnCardWidth

    fcn returnCardHeight : int
	result height
    end returnCardHeight

    fcn returnCardX : int
	result bottom_leftX
    end returnCardX

    fcn returnCardY : int
	result bottom_leftY
    end returnCardY

    fcn returnCardSimpleG : boolean
	result simpleG
    end returnCardSimpleG

    fcn returnCardisFlipped : boolean
	result flipped
    end returnCardisFlipped

    fcn returnCardC : int
	result cardC
    end returnCardC

    fcn returnCardBackC : int
	result backC
    end returnCardBackC

    proc setCard (n, s : int)
	var faceFile : string
	var stream : int
	open : stream, FACE_FILE_NAME, get
	for i : 1 .. 14
	    get : stream, faceFile
	    if i = (s - 1) * 3 + n - 10 and n>10 then
		royalCard := Pic.FileNew ("RoyalFaces/" + faceFile)
	    end if
	end for
	get : stream, faceFile
	if faceFile = "xxxxx" then
	    backCard := -1
	else
	    backCard := Pic.FileNew ("CardBacks/" + faceFile)
	end if
	close : stream
	cardN := n
	suit := s
	var col : int
	open : stream, COLOUR_FILE_NAME, get
	get : stream, col
	backC := col
	for i : 1 .. 4
	    get : stream, col
	    if i = suit then
		cardC := col
		exit
	    end if
	end for
	close : stream
    end setCard

    proc drawCard
	if flipped then
	    drawCardBack (bottom_leftX, bottom_leftY, width, height, direction, backCard)
	else
	    case suit of
		label 0 :
		label 1 :
		    drawSpadeCard (bottom_leftX, bottom_leftY, width, height, cardN, direction, cardC, backC, royalCard, simpleG)
		label 2 :
		    drawHeartCard (bottom_leftX, bottom_leftY, width, height, cardN, direction, cardC, backC, royalCard, simpleG)
		label 3 :
		    drawClubCard (bottom_leftX, bottom_leftY, width, height, cardN, direction, cardC, backC, royalCard, simpleG)
		label 4 :
		    drawDiamondCard (bottom_leftX, bottom_leftY, width, height, cardN, direction, cardC, backC, royalCard, simpleG)
	    end case
	    drawCardNumber (bottom_leftX, bottom_leftY, width, height, cardN, direction, cardC, backC)
	end if
    end drawCard
end Card

View.Set ("offscreenonly")
var thilash : int := Time.Elapsed
var pointy : array 1 .. 52 of pointer to Card
for i : 1 .. 13
    for j : 1 .. 4
	new Card, pointy ((j - 1) * 13 + i)
	pointy ((j - 1) * 13 + i) -> changeCardSimpleG
	pointy ((j - 1) * 13 + i) -> setCard (i, j)
	pointy ((j - 1) * 13 + i) -> setCardSize (150, 187)
	pointy ((j - 1) * 13 + i) -> setDirection (1)
	%pointy ((j - 1) * 13 + i) -> flipCard
    end for
end for
put Time.Elapsed - thilash
thilash := Time.Elapsed
for i : 1 .. 13
    for j : 1 .. 4
	pointy ((j - 1) * 13 + i) -> setCardCoordinates (10 + 20 * i, 20 + 30 * j)
	pointy ((j - 1) * 13 + i) -> drawCard
    end for
end for
put Time.Elapsed - thilash
View.Update

class Hand
    import Card 
    var cardW, cardH : int
    var bottom_leftX, bottom_leftY : int
    var size, cardDis, cardDir : int
    var cards : flexible array 1 .. 0 of pointer to  Card 
end Hand


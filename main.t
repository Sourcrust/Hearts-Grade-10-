% Instructions for game http://www.bicyclecards.com/how-to-play/hearts/

import Hand in "Classes/HandClass/Hand.cla",
    Card in "Classes/CardClass/Card.cla"
    
setscreen ("Graphics:1000,685,nobuttonbar,offscreenonly")
View.Set("title:Hearts: The Game")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%VARIABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% records

type icon:                                          % records that stores variables concerning the player icon 
    record
	centerX:int                                 % coordinates where the icon is located
	centerY:int
	name:string                                 % name of the player
	size:int                                    % size of the icon
	font:int                                    % font style used to diplay the number of points, and the name of the player
	image:int                                   % address fo the image for the icon
	c:int                                       % colour of the border
    end record

type players :
    record  
	handCenterX : int                           % Typical Center Location for each hand
	handCenterY : int
	playedCardX : int                           % THe Location the playedCard needs to head to once they are played
	playedCardY : int
	selectedCard : int                          % stores what card in the hand is selected
	playedCard : pointer to Card                % card that is played
	hands : pointer to Hand                     % Main hand used
	receivedCards : pointer to Hand             % Hand that stores the important received Cards of each player
	score : int                                 % stores the score of each player
	pointsThisRound : int                       % How many points were earned in one round
	playerIcon:icon                             % The player's icon
	rank:int                                    % placing based on the score
    end record

type cardInfo :                                     % used to shuffle the deck and distribute cards
    record                                          % I rather use an array of cardINfo other than ^Card because I only need the card suit and card Number
	cardSuit : int
	cardNumber : int
    end record

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% regular variables
var mouseX, mouseY, mouseB : int                    % used to keep track of mouse inputs
var isReleased : boolean := true                    % two variables to keep track of mouse inputs and whether the mouse is held down or not
var isHeld : boolean := false
var autoIsHeld :boolean:=false                      % checks if the auto button is held currently
var pauseIsHeld:boolean:=false                      % checks if the pause button is held currently
var replayIsHeld:boolean:=false                     % checks if the replay button is held currently
var isAuto:boolean:=false                           % checks if autoMode is on in the game

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Things that could change (It is expected that users will fiddle with this)
var setPoint : int := 1000
var timeLimit:int:=15000
var tableColour:int:=2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% constants
const RAISE_TIME : int := 10                        % how long it takes for the card to be raised to it's highest 
const FPS : int := 400                               % maximum fps for the program
const DELAY_AMOUNT : int := 1000 div FPS            % delay amount based on the desired fps

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Button Coordinates
const CONFIRM_BLX : int := maxx - 230                       % Coordinates for the confirm button
const CONFIRM_BLY : int := 80
const CONFIRM_TRX : int := maxx - 30
const CONFIRM_TRY : int := 130

const PAUSE_BLX:int:=CONFIRM_BLX                            % Coordinates for the Pause button
const PAUSE_BLY:int:=40
const PAUSE_TRX:int:=(CONFIRM_BLX+CONFIRM_TRX)div 2-5
const PAUSE_TRY:int:=75

const AUTO_BLX:int:=(CONFIRM_BLX+CONFIRM_TRX)div 2+5        % Coordinates for the Auto Button
const AUTO_BLY:int:=40
const AUTO_TRX:int:=CONFIRM_TRX
const AUTO_TRY:int:=75

const REPLAY_BLX:int:=maxx div 2-75                         % Coordinates for the Replay Button
const REPLAY_BLY:int:=maxy div 2-100
const REPLAY_TRX:int:=maxx div 2+75
const REPLAY_TRY:int:=maxy div 2-65

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fonts
const MEDIUM_FONT : int := Font.New ("TimesNewRoman:20:bold")    % Font for Confirm Button   
const TIMER_FONT:int:=Font.New("TimesNewRoman:45")          % Font for the Timer
const FINAL_FONT:int:=Font.New("TimesNewRoman:50")
const WINNER_FONT:int:=Font.New("TimesNewRoman:22")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Other Constants
const ICON_COLOURS:array 1..4 of int:=init(14,30,115,77)    % The Icon colours for first, second, third, and last 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proc setupVariables (var player : array 0 .. 3 of players)              % sets up the hand and receivedCard variables for each player
    player (0).handCenterX := maxx div 2
    player (1).handCenterX := 70
    player (2).handCenterX := maxx div 2
    player (3).handCenterX := maxx - 70

    player (0).handCenterY := 30
    player (1).handCenterY := maxy div 2 + 5
    player (2).handCenterY := maxy
    player (3).handCenterY := maxy div 2 + 5

    for i : 0 .. 3
	new Hand, player (i).hands
	new Hand, player (i).receivedCards
	player (i).hands -> setDimensions (150, 187)
	player (i).receivedCards -> setCoordinates (-200, -200)
	player (i).receivedCards -> setCardDistance (10)
	player (i).receivedCards -> setAllSimpleG
	player (i).receivedCards -> setDirection (i + 1)        
	player (i).hands -> setDirection (i + 1)
	player (i).hands -> setAllSimpleG
	player (i).hands -> setCardDistance (22)
	player (i).hands -> setRaiseDis (5)

	player (i).receivedCards -> setDimensions (150, 187)
	player (i).receivedCards -> setCardDistance (20)
    end for
    player (0).hands -> setCardDistance (28)
    player (0).hands -> setRaiseDis (6)
    for i : 0 .. 3
	player (i).hands -> setCoordinatesByCenter (player (i).handCenterX, player (i).handCenterY)
    end for

    player (0).playedCardX := (maxx - 150) div 2
    player (1).playedCardX := maxx div 2 - 80 - player (1).hands -> returnCardHeight
    player (2).playedCardX := (maxx - 150) div 2
    player (3).playedCardX := maxx div 2 + 80

    player (0).playedCardY := maxy div 2 - 25 - player (0).hands -> returnCardHeight
    player (1).playedCardY := (maxy - 150) div 2
    player (2).playedCardY := maxy div 2 + 25
    player (3).playedCardY := (maxy - 150) div 2

end setupVariables

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Deck procedures
proc shuffleDeck (var deck : array 1 .. 52 of cardInfo)                                             % shuffles the deck and puts the cards in random order
    for i : 1 .. 52
	var tempNum : int := Rand.Int (1, 52)
	var tempPair : cardInfo
	tempPair := deck (i)
	deck (i) := deck (tempNum)
	deck (tempNum) := tempPair
    end for
end shuffleDeck

proc distributeCards (deck : array 1 .. 52 of cardInfo, player : array 0 .. 3 of players)           % distributes the cards to each hand
    for i : 1 .. 52
	player (i mod 4).hands -> addCard (deck (i).cardNumber, deck (i).cardSuit, "Classes/HandClass/")
    end for
end distributeCards

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Choosing Cards

proc resetRanking(var player:array 0..3 of players)                         % sets the rank of each player as first place 
    for i:0..3   
	player(i).playerIcon.c:=14
	player(i).rank:=1
    end for
end resetRanking

proc sortHands (var player : array 0 .. 3 of players)                       % sorts each hand by suit where ace is the highest card
    for i : 0 .. 3
	player (i).hands -> sortBySuit (1)
    end for
end sortHands

fcn findStartingPlayer (player : array 0 .. 3 of players) : int
    % at the beginning of the game, the person with the 2 of clubs starts the game, the fcn returns the player with the card
    for i : 0 .. 3
	for j : 1 .. player (i).hands -> returnSize
	    if player (i).hands -> returnCardNum (j) = 2 and player (i).hands -> returnCardSuit (j) = 3 then
		result i
	    end if
	end for
    end for
    result 0
end findStartingPlayer

proc setUpdatedHand (point : pointer to Hand, num : int, var handBLX, handBLY, newBLX, newBLY, person, handCenterY : int)
    case person of                                                                                  % sets the location of where the hand should end up being once done shifting
	label 0 :
	    handBLX := point -> returnHandX
	    handBLY := point -> returnHandY
	    newBLX := handBLX + point -> returnCardDis div 2
	    newBLY := handBLY
	label 1 :
	    handBLX := point -> returnHandX
	    handBLY := point -> returnHandY + point -> returnCardDis
	    newBLY := handCenterY - (point -> returnCardDis * (point -> returnSize - 2) + point -> returnCardWidth) div 2
	    newBLX := handBLX
	label 2 :
	    handBLX := point -> returnHandX + point -> returnCardDis
	    handBLY := point -> returnHandY
	    newBLX := (maxx - (point -> returnCardDis * (point -> returnSize - 2) + point -> returnCardWidth)) div 2
	    newBLY := handBLY
	label 3 :
	    handBLX := point -> returnHandX
	    handBLY := point -> returnHandY
	    newBLY := handBLY + point -> returnCardDis div 2
	    newBLX := handBLX
    end case

    point -> removeCard (num, num)                                                                  % removes the selected Card from the hand
    for i : 1 .. point -> returnSize
	if i >= num then                                                                            % shifts cards so that the cards stay at the same location when a card is removed
	    point -> shiftCards (i, point -> returnSize, point -> returnCardDis)
	    exit
	end if
    end for
end setUpdatedHand

fcn hasCardOfSuit (suit : int, hands : pointer to Hand) : boolean                                   % returns whether a card in the hand is a certain suit
    for i : 1 .. hands -> returnSize                                                                % checks each card
	if hands -> returnCardSuit (i) = suit then
	    result true
	end if
    end for
    result false
end hasCardOfSuit

proc findPossibleCards (startPlayer, person : int, hands : pointer to Hand, var heartsBroken : boolean, playedCard : pointer to Card, var possibleCards : int)
    possibleCards := 0
    % SOOOOOOOOOO
    % If a player starts the whole round, then that person must play the 2 of clubs
    % If the player starts a trick(like he plays the first card), He could play any card, except for hearts unless a heart was played before (hearts broken).
    % If the player has no other option but to play a heart when hearts is not broken, then hearts is broken and a heart can be played
    % If the player does not start a trick, the player must player another card of the same suit as the very first card
    % If the player does not have such card, he could play any card he wants
    if startPlayer = person then                                        % sees if the player starts the trick
	if hands -> returnSize = 13 then                                % Sees if player is starting the entire round, if so, only teh 2 of clubs can be played
	    for i : 1 .. hands -> returnSize
		if hands -> returnCardSuit (i) = 3 and hands -> returnCardNum (i) = 2 then
		    hands -> unshadeCard (i, i)
		    possibleCards += 1
		else
		    hands -> shadeCard (i, i)
		end if
	    end for
	elsif heartsBroken then                                         % If hearts are broken, then all cards can be played
	    hands -> unshadeCard (1, hands -> returnSize)
	    possibleCards := hands -> returnSize
	else
	    for i : 1 .. hands -> returnSize                            % If hearts are not broken, it shades all hearts
		if hands -> returnCardSuit (i) ~= 2 then
		    hands -> unshadeCard (i, i)
		    possibleCards += 1
		else
		    hands -> shadeCard (i, i)
		end if
	    end for
	    if possibleCards = 0 then                                   % If there are no possible cards to play other than Hearts, then all cards can be played (unshaded) and hearts is broken.
		possibleCards := hands -> returnSize
		hands -> unshadeCard (1, hands -> returnSize)
	    end if
	end if
    else
	if hasCardOfSuit (playedCard -> returnCardSuit, hands) then     % If the player does not start the trick and has a card of the suit of the first player
	    for i : 1 .. hands -> returnSize
		if hands -> returnCardSuit (i) = playedCard -> returnCardSuit then
		    hands -> unshadeCard (i, i)                         % unshades all cards of the suit of the firwt player
		    possibleCards += 1
		else
		    hands -> shadeCard (i, i)
		end if
	    end for
	else                                                            % If the player cannot play a card of the smae suit, any card can be played (all cards are unshaded)
	    hands -> unshadeCard (1, hands -> returnSize)
	    possibleCards := hands -> returnSize
	end if
    end if
end findPossibleCards

proc chooseRandomCard (num : int, hands : pointer to Hand, var selectedCard : int) % chooses a random card and picks the card out of all possible choices for the player
    var counter : int := 1
    for i : 1 .. hands -> returnSize
	if ~ (hands -> returnIsShaded (i)) then
	    if counter = num then
		selectedCard := i
		exit
	    else
		counter += 1
	    end if
	end if
    end for
end chooseRandomCard

fcn chooseBestCard(player: array 0 .. 3 of players,startPlayer,p:int,heartsBroken:boolean):int
    if p=startPlayer then
	if player(p).hands->returnSize=13 then
	    for i : 1 .. player(p).hands -> returnSize
		if ~ (player(p).hands -> returnIsShaded (i)) then
		    result i
		end if
	    end for 
	elsif heartsBroken then
	    result Rand.Int(1,player(p).hands->returnSize)
	else 
	    var OtherHeartsInHand:boolean:=false
	    for i:1..player(p).hands->returnSize
		if player(p).hands->returnCardSuit(i) ~=2 then
		    OtherHeartsInHand:=true
		    exit
		end if
	    end for
	    if  ~OtherHeartsInHand then
		result Rand.Int(1,player(p).hands->returnSize)                
	    else
		var tempIndex:int
		loop
		    tempIndex:=Rand.Int(1,player(p).hands->returnSize)
		    exit when player(p).hands->returnCardSuit(tempIndex)~=2
		end loop
		result tempIndex
	    end if
	end if
    else
	var current:int:=(startPlayer+1) mod 4
	var suitPlayed:int:=player(startPlayer).playedCard -> returnCardSuit
	var highestC:int:=player(startPlayer).playedCard -> returnCardN
	
	if hasCardOfSuit(suitPlayed,player(p).hands) then
	    loop
		exit when current = p mod 4
		if player(current).playedCard -> returnCardSuit= suitPlayed and player(current).playedCard -> returnCardN >highestC then
		    highestC:=player(current).playedCard->returnCardN
		end if
		current:=(current+1)mod 4
	    end loop
	    var currentlyPicked:int:=-1
	    for i:1..player(p).hands->returnSize
		if player(p).hands->returnCardSuit(i)=suitPlayed then
		    if currentlyPicked=-1 then
			currentlyPicked:=i
		    elsif player(p).hands->returnCardNum(i)>player(p).hands->returnCardSuit(currentlyPicked) and player(p).hands->returnCardNum(i)<highestC then
			currentlyPicked:=i
		    end if
		end if
	    end for
	    result currentlyPicked
	else
	    if player(startPlayer).hands->returnSize<2 then
		result 1
	    else
		var largest:int:=player(startPlayer).hands -> returnCardNum(1)
		var largestIndex:int:=1
		for i:1..player(p).hands->returnSize
		    var value:int
		    if player(p).hands->returnCardSuit(i)=1 then
			if player(p).hands->returnCardNum(i)=1 then                         % makes it so that the ai wants to rmove the ace of spades and such as quickly as possible
			    value:=16
			elsif player(p).hands->returnCardNum(i)>11 then
			    value:=player(p).hands->returnCardNum(i)+2
			else
			    value:=player(p).hands->returnCardNum(i) 
			end if
		    elsif player(p).hands->returnCardSuit(i)=2 then                         % makes it desirable to break hearts
			value:=player(p).hands->returnCardNum(i)+1
		    else 
			value:=player(p).hands->returnCardNum(i)
		    end if 
		    if value>largest then 
			largest:=value
			largestIndex:=i
		    end if
		end for
		result largestIndex
	    end if
	end if
    end if
end chooseBestCard

proc findHighestCard (var player : array 0 .. 3 of players, startPlayer : int, var highestCard : int)   % finds the highest card of the
    highestCard := startPlayer                                                                          % assumes the person with the highest card is the starting player
    % SOOOOOOOOOOOOOOOOOOOOOOOO
    % The highest Card has to the highest card with the same suit as the suit of the card played first
    for i : 1 .. 3
	if player ((i + startPlayer) mod 4).playedCard -> returnCardSuit = player (highestCard).playedCard -> returnCardSuit then
	    if (player ((i + startPlayer) mod 4).playedCard -> returnCardN > player (highestCard).playedCard -> returnCardN and player (highestCard).playedCard -> returnCardN ~= 1) or player ((i +
		    startPlayer) mod 4).playedCard -> returnCardN = 1 then
		highestCard := (i + startPlayer) mod 4                                                  % if a higher card is find, highest card is now set to be that number of that player
	    end if
	end if
    end for
end findHighestCard

proc shadeLowerCards (var player : array 0 .. 3 of players, highestCard : int)                          % shades all played cards that are not the highest card
    var colors : array 1 .. 3 of int := init (0, 7, 12)                                                 % array that stores the colors for shading and unshading
    var shadeC : array 1 .. 3 of int := init (21, 7, 184)
    for i : 0 .. 3                                                                                      % shades/unshades each card accordingly
	if i ~= highestCard then
	    player (i).playedCard -> setCardColourBack (shadeC (1))
	    if player (i).playedCard -> returnCardSuit mod 2 = 1 then
		player (i).playedCard -> setCardColour (shadeC (2))
	    else
		player (i).playedCard -> setCardColour (shadeC (3))
	    end if
	else
	    player (i).playedCard -> setCardColourBack (colors (1))
	    if player (i).playedCard -> returnCardSuit mod 2 = 1 then
		player (i).playedCard -> setCardColour (colors (2))
	    else
		player (i).playedCard -> setCardColour (colors (3))
	    end if
	end if
    end for
end shadeLowerCards

proc checkIfHeartsBroken (player : array 0 .. 3 of players, var heartsBroken : boolean) %checks the 4 played cards to see if any one of them are hearts/queen of spades
    for i : 0 .. 3
	if player (i).playedCard -> returnCardSuit = 2 or (player (i).playedCard -> returnCardSuit = 1 and player (i).playedCard -> returnCardN = 12) then
	    heartsBroken := true
	end if
    end for
end checkIfHeartsBroken

proc initializeDeck (var deck : array 1 .. 52 of cardInfo)              % initializes the deck making sure that each of the 52 cards exists
    for i : 1 .. 4
	for j : 1 .. 13
	    deck (((i - 1) * 13) + j).cardSuit := i
	    deck (((i - 1) * 13) + j).cardNumber := j
	end for
    end for
end initializeDeck

proc addReceivedCards (series : pointer to Hand, player : array 0 .. 3 of players)  %adds any important cards (hearts or queen of spades) to the player's recievedCards
    var point : pointer to Card
    new Card, point
    for i : 0 .. 3
	if player (i).playedCard -> returnCardSuit = 2 or (player (i).playedCard -> returnCardSuit = 1 and player (i).playedCard -> returnCardN = 12) then
	    point := player (i).playedCard
	    series -> pasteCard (point)
	end if
    end for
end addReceivedCards

proc shootTheMoon (var player : array 0 .. 3 of players, winner : int)      % sets each player's points in that round if someone shoots the moon, the winner will get 0 points while everyone else will get 26 points
    for i : 0 .. 3
	if i = winner then
	    player (i).pointsThisRound := 0
	else
	    player (i).pointsThisRound := 26
	end if
    end for
end shootTheMoon

proc calculateRoundPoints (var player : array 0 .. 3 of players)            % caluculates all the points each player has gotten in that specific round
    for i : 0 .. 3
	player (i).pointsThisRound := 0
	for j : 1 .. player (i).receivedCards -> returnSize
	    if player (i).receivedCards -> returnCardSuit (j) = 2 then
		player (i).pointsThisRound += 1
	    else
		player (i).pointsThisRound += 13
	    end if
	end for
	if player (i).pointsThisRound = 26 then
	    shootTheMoon (player, i)
	    exit
	end if
    end for
end calculateRoundPoints

proc addRoundPoints (var player : array 0 .. 3 of players)                          % adds up each players current score with the points they have gotten in a round
    for i : 0 .. 3
	player (i).score += player (i).pointsThisRound
    end for
end addRoundPoints

fcn reachSetPoints (var player : array 0 .. 3 of players, setPoint : int) : boolean % functions that check each player's score and returns whether a score surpasses the set number of points
    for i : 0 .. 3
	if player (i).score >= setPoint then
	    result true
	end if
    end for
    result false
end reachSetPoints

proc adjustRanking(var player:array 0..3 of players)                                % checks each players score and ranks them based on how many points they have
    var tempScores:array 0..3 of int                                                % array for sorting the scores from least to greatest
    for i:0..3
	tempScores(i):=player(i).score
	player(i).rank:=5                                                           % temperarily sets player rank as 5(which is impossible in the actual game)
    end for
    var isSorted:boolean
    loop                                                                            % bubble sorts the scores
	isSorted:=true
	for i:0..2
	    if tempScores(i)>tempScores(i+1) then
		isSorted:=false
		var tempInt:int:=tempScores(i)
		tempScores(i):= tempScores(i+1)
		tempScores(i+1):=tempInt   
	    end if
	end for
	exit when isSorted
    end loop
    for i:0..3
	for j:0..3
	    if player(j).score=tempScores(i) then                                   % the rank of each player is based on the order of the sorted scores
		player(j).rank:=min(i+1,player(j).rank)                             % any people with the same score will have the same rank, it takes the highest rank that the player could have
	    end if
	end for
    end for
end adjustRanking

proc emptyReceivedHand(var player:array 0..3 of players)                            % empties out the RecievedCards Hand at the eand of each round
    for i:0..3
	player(i).receivedCards->removeCard(1,player(i).receivedCards->returnSize)
    end for
end emptyReceivedHand

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Mouse Input
proc changeSelectedCard (var cardS : int, mx, my : int, point : pointer to Hand)                    % changes the selected card based on where the mouse is located
    if my > point -> returnHandY + point -> returnCardHeight then
	if cardS ~= -1 and mx > point -> returnHandX + (cardS - 1) * point -> returnCardDis and mx < point -> returnHandX + (cardS - 1) * point -> returnCardDis + point -> returnCardWidth then
	    cardS := -1                                                                             % unselects a card when the mouse clicks on the top portion of the selected Card
	end if
    elsif mx < point -> returnHandX + (point -> returnSize - 1) * point -> returnCardDis + point -> returnCardWidth and mx > point -> returnHandX + (point -> returnSize - 1) * point -> returnCardDis
	    and ~point -> returnIsShaded (point -> returnSize) then
	if point -> returnSize = cardS then                                                         % checks if the user is clicking on the card at the very right
	    cardS := -1                                                                             % if already selected, it will deselected the card
	else
	    cardS := point -> returnSize                                                            % if not, that card will be selected
	end if
    else
	for decreasing i : point -> returnSize .. 1                                                 % checks all cards after to see if they are selected
	    if mx > point -> returnHandX + (i - 1) * point -> returnCardDis and mx < point -> returnHandX + (i) * point -> returnCardDis and ~point -> returnIsShaded (i) then
		if i = cardS then
		    cardS := -1                                                                     % if that card is already selected, it is deselected
		else
		    cardS := i                                                                      % if not, that card will be selected
		end if
		exit
	    end if
	end for
    end if
end changeSelectedCard

fcn isInAuto(x,y:int):boolean                                                       % returns whether the mouse is clicking the auto button
    result x>AUTO_BLX and x<AUTO_TRX and y>AUTO_BLY and y<AUTO_TRY
end isInAuto

fcn isInPause(x,y:int):boolean                                                      % returns whether the mouse is clicking the pause button
    result x>PAUSE_BLX and x<PAUSE_TRX and y>PAUSE_BLY and y<PAUSE_TRY
end isInPause
    
fcn isInReplay(x,y:int):boolean                                                     % returns whether the mouse is clicking the replay button
    result x>REPLAY_BLX and x<REPLAY_TRX and y>REPLAY_BLY and y<REPLAY_TRY
end isInReplay

fcn isInConfirmBox (mx, my : int) : boolean                                                         % returns a boolean value on whether the mouse is in the confirmBox
    result mx > CONFIRM_BLX and mx < CONFIRM_TRX and my > CONFIRM_BLY and my < CONFIRM_TRY
end isInConfirmBox

fcn isInCardRange (mx, my : int, point : pointer to Hand) : boolean
    % retunns a boolena value and checks if the mouse is within the range where theres a possibility that a card is selected
    result mx > point -> returnHandX and mx < point -> returnHandX + point -> returnCardWidth + point -> returnCardDis * (point -> returnSize - 1) and
	my > point -> returnHandY and my < point -> returnHandY + point -> returnCardHeight + point -> returnRaiseDis * RAISE_TIME
end isInCardRange

proc drawConfirmBox (isPressed : boolean, selectedCard : int)                                       % draws the confirmBox
    if selectedCard = -1 then
	Draw.FillBox (CONFIRM_BLX, CONFIRM_BLY, CONFIRM_TRX, CONFIRM_TRY, 22)
    else
	if isPressed then
	    % depending on whether the button is being held down/not clickable or not, the button could be dark or light grey
	    Draw.FillBox (CONFIRM_BLX, CONFIRM_BLY, CONFIRM_TRX, CONFIRM_TRY, 26)
	else
	    Draw.FillBox (CONFIRM_BLX, CONFIRM_BLY, CONFIRM_TRX, CONFIRM_TRY, 28)
	end if
    end if
    Draw.Box (CONFIRM_BLX, CONFIRM_BLY, CONFIRM_TRX, CONFIRM_TRY, black)
    Font.Draw ("Confirm", (CONFIRM_BLX + CONFIRM_TRX - Font.Width ("Confirm", MEDIUM_FONT)) div 2, CONFIRM_BLY + 15, MEDIUM_FONT, black)
end drawConfirmBox

proc redrawPauseButton(pauseIsHeld,isPaused:boolean)                                % redraws the PauseButton based on whether the game is paused/the button is held down
    if pauseIsHeld then
	Draw.FillBox(PAUSE_BLX,PAUSE_BLY,PAUSE_TRX,PAUSE_TRY,22)
    elsif isPaused then
	Draw.FillBox(PAUSE_BLX,PAUSE_BLY,PAUSE_TRX,PAUSE_TRY,24)    
    else
	Draw.FillBox(PAUSE_BLX,PAUSE_BLY,PAUSE_TRX,PAUSE_TRY,28)     
    end if
    Draw.Box(PAUSE_BLX,PAUSE_BLY,PAUSE_TRX,PAUSE_TRY,black) 
    Font.Draw("Pause",(PAUSE_TRX+PAUSE_BLX-Font.Width("Pause",MEDIUM_FONT))div 2,PAUSE_BLY+5,MEDIUM_FONT,black)
end redrawPauseButton

proc redrawMouseButtons(autoIsHeld,pauseIsHeld,isAuto:boolean)                      % redraws the pause button and the auto button 
    if autoIsHeld then                                                              % redraws the auto button based on whether automode is on/the button is held down or not
	Draw.FillBox(AUTO_BLX,AUTO_BLY,AUTO_TRX,AUTO_TRY,22)
    elsif isAuto then
	Draw.FillBox(AUTO_BLX,AUTO_BLY,AUTO_TRX,AUTO_TRY,24)    
    else
	Draw.FillBox(AUTO_BLX,AUTO_BLY,AUTO_TRX,AUTO_TRY,28)    
    end if
    Draw.Box(AUTO_BLX,AUTO_BLY,AUTO_TRX,AUTO_TRY,black)
    Font.Draw("Auto",(AUTO_TRX+AUTO_BLX-Font.Width("Auto",MEDIUM_FONT))div 2,AUTO_BLY+5,MEDIUM_FONT,black)
    redrawPauseButton(pauseIsHeld,false)
end redrawMouseButtons

proc drawReplayButton(replayIsHeld:boolean)                                         % redraws the reaply button based on whether the replay button is held down or not
    if replayIsHeld then
	Draw.FillBox(REPLAY_BLX,REPLAY_BLY,REPLAY_TRX,REPLAY_TRY,22)    
    else
	Draw.FillBox(REPLAY_BLX,REPLAY_BLY,REPLAY_TRX,REPLAY_TRY,28)    
    end if
    Draw.Box(REPLAY_BLX,REPLAY_BLY,REPLAY_TRX,REPLAY_TRY,black)
    Font.Draw("Replay",(REPLAY_TRX+REPLAY_BLX-Font.Width("Replay",MEDIUM_FONT))div 2,REPLAY_BLY+10,MEDIUM_FONT,black)
end drawReplayButton

proc pauseGame                                                                      % pauses the game, it continually loops this prco until the pause button has been pressed again
    var x,y,b:int                                                                   % substitute variables for use only dugin the pause procedure
    var isReleased:boolean:=true
    var isHeld:boolean:=false
    var pauseIsHeld:boolean:=false
    var timer:int:=Time.Elapsed
    loop
	View.UpdateArea(0,0,maxx,maxy)
	delay (DELAY_AMOUNT - (Time.Elapsed - timer))
	timer := Time.Elapsed
	Mouse.Where(x,y,b)
	
	if b = 1 and isReleased then                                                                                                   
	    isHeld := true
	    isReleased := false                                
	    if isInPause(x,y) then                                             
		pauseIsHeld := true                                                                                                       
	    end if
	end if

	if b = 0 and isHeld then                                                                                                       
	    isHeld := false
	    exit when isInPause(x,y) and pauseIsHeld
	    pauseIsHeld:=false                                                                                    
	    isReleased := true
	end if    
	redrawPauseButton(pauseIsHeld,true)                                         % redraws the pause button
    end loop
end pauseGame

proc mouseInputs(var mx,my,b:int,var isHeld,isReleased,autoIsHeld,pauseIsHeld:boolean)  % tracks mouse controls and checks whether the mouse is clicking on the auto/pause button
    Mouse.Where(mx,my,b)
    
    if b = 1 and isReleased then                                                        % checks if the mouse has recently pressed down
	isHeld := true
	isReleased := false
	if isInAuto (mx, my) then                                                                   
	    autoIsHeld:=true                                  
	elsif isInPause(mx,my) then                                             
	    pauseIsHeld := true                                                                                                       
	end if
    end if

    if b = 0 and isHeld then                                                           % checks if the mouse has recently been realeased                                            
	isHeld := false                                                                                                                
	if isInAuto(mx,my) and autoIsHeld then
	    isAuto:=~isAuto
	elsif isInPause(mx,my) and pauseIsHeld then
	    pauseGame()
	end if
	autoIsHeld:=false
	pauseIsHeld:=false                                                                                    
	isReleased := true
    end if 
    redrawMouseButtons(autoIsHeld,pauseIsHeld,isAuto)                                   % redraws the auto and pause buttons
end mouseInputs

% combines the mouseInputs and checks if the mouse touches the confirm button or hand as well
proc selectButtonsAndCards (var mx, my, b : int, var isHeld, isReleased, autoIsHeld, pauseIsHeld,cardConfirmed,confirmIsHeld : boolean,var player : array 0 .. 3 of players,person:int) 
    Mouse.Where(mx,my,b)
    if mouseB = 1 and isReleased then                                                                                                   % Checks if mouse has been press and not simply held down
	isHeld := true
	isReleased := false
	if isInCardRange (mouseX, mouseY, player (person).hands) then                                                                   % checks if the mouse is touching a card
	    changeSelectedCard (player (person).selectedCard, mouseX, mouseY, player (person).hands)                                    % sets a new selected Card based on the mouse whereabouts
	elsif isInConfirmBox (mouseX, mouseY) and player (person).selectedCard ~= -1 then                                               
	    confirmIsHeld := true                                    
	elsif isInAuto (mx, my) then                                                                   
	    autoIsHeld:=true                                  
	elsif isInPause(mx,my) then                                             
	    pauseIsHeld := true                                                                                         
	end if
    end if

    if mouseB = 0 and isHeld then                                                                                                       % Checks if mouse has been recently released
	isHeld := false                                                                                                                 % mouse no longer held
	if isInConfirmBox (mouseX, mouseY) and confirmIsHeld then
	    % if mouse was still in the confirm box location, confirmCard is set to true and a  card is chosen
	    cardConfirmed := true
	elsif isInAuto(mx,my) and autoIsHeld then
	    isAuto:=~isAuto
	elsif isInPause(mx,my) and pauseIsHeld then
	    pauseGame()
	end if
	confirmIsHeld := false     
	autoIsHeld:=false
	pauseIsHeld:=false                                                                                                % confirmed box is no longer held and isReleased is set to true
	isReleased := true
    end if
    redrawMouseButtons(autoIsHeld,pauseIsHeld,isAuto)
    drawConfirmBox (confirmIsHeld, player (person).selectedCard) 
end selectButtonsAndCards

proc mouseFindReplay(var mx,my,b:int,var isHeld,isReleased,replayIsHeld,replayGame:boolean)     % checks if the mouse is clicking the replay Button
    Mouse.Where(mx,my,b)
    
    if b = 1 and isReleased then                                                                % sees if the mouse has been recently pressed                                 
	isHeld := true
	isReleased := false
	if isInReplay (mx, my) then                                                                   
	    replayIsHeld:=true                                                                                                    
	end if
    end if

    if b = 0 and isHeld then                                                                    % sees if the mouse has been recently released                                                                               
	isHeld := false                                                                                                                
	if isInReplay(mx,my) and replayIsHeld then
	    replayGame:=true
	end if
	replayIsHeld:=false                                                                                    
	isReleased := true
    end if 
    
    drawReplayButton(replayIsHeld)                                                              % draws the replay button
end mouseFindReplay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Card Movements

proc shiftHand (point : pointer to Hand, var handBLX, handBLY : int, newBLX, newBLY, dis : int)     % shifts the hand, so adjusting the Hand Coordinates and the shift distance of each card
    for i : 1 .. point -> returnSize                                                                % shifts the cards back to normal
	if point -> returnCardDis div 5 > abs (point -> returnShiftAmount (i)) then
	    point -> shiftCards (i, i, -point -> returnShiftAmount (i))
	elsif point -> returnShiftAmount (i) > 0 then
	    point -> shiftCards (i, i, - (point -> returnCardDis div 5))
	elsif point -> returnShiftAmount (i) < 0 then
	    point -> shiftCards (i, i, (point -> returnCardDis div 5))
	end if
    end for
    if abs (newBLX - handBLX) < dis div 8 then                                                      % gradually shifts the x coordinates of the hand back to normal
	handBLX := newBLX
    elsif newBLX - handBLX > 0 then
	handBLX += dis div 8
    elsif newBLX - handBLX < 0 then
	handBLX -= dis div 8
    end if
    if abs (newBLY - handBLY) < dis div 8 then                                                      % gradually shifts the y coordinates of the hand back to normal
	handBLY := newBLY
    elsif newBLY - handBLY > 0 then
	handBLY += dis div 8
    elsif newBLY - handBLY < 0 then
	handBLY -= dis div 8
    end if
    point -> setCoordinates (handBLX, handBLY)                                                      % sets the hand Coordinates
end shiftHand

fcn doneShifting (point : pointer to Hand) : boolean                                                % sees if the shifted cards in the hand shifted back to normal
    for i : 1 .. point -> returnSize
	if point -> returnShiftAmount (i) ~= 0 then
	    result false
	end if
    end for
    result true
end doneShifting

fcn doneMovingCard (point : pointer to Card, x, y : int) : boolean                                  % returns whether the played card is done moving
    result point -> returnCardX = x and point -> returnCardY = y
end doneMovingCard

proc movePlayedCard (point : pointer to Card, x, y : int)                                           % moves the played card to its desired position
    if abs (point -> returnCardX - x) < 10 then                                                     % adjusts the x coordinate of the card
	point -> setCardCoordinates (x, point -> returnCardY)
    elsif point -> returnCardX > x then
	point -> setCardCoordinates (point -> returnCardX - 10, point -> returnCardY)
    else
	point -> setCardCoordinates (point -> returnCardX + 10, point -> returnCardY)
    end if
    if abs (point -> returnCardY - y) < 10 then                                                     % adjusts the y coordinate of the card
	point -> setCardCoordinates (point -> returnCardX, y)
    elsif point -> returnCardY > y then
	point -> setCardCoordinates (point -> returnCardX, point -> returnCardY - 10)
    else
	point -> setCardCoordinates (point -> returnCardX, point -> returnCardY + 10)
    end if
end movePlayedCard

proc bringCardsTogether (var player : array 0 .. 3 of players)          % brings all the played cards to the very center of the screen
    for i : 0 .. 3
	if i mod 2 = 0 then
	    if abs ((maxy - player (i).playedCard -> returnCardHeight) div 2 - player (i).playedCard -> returnCardY) < 10 then
		player (i).playedCard -> setCardCoordinates (player (i).playedCard -> returnCardX, (maxy - player (i).playedCard -> returnCardHeight) div 2)
	    elsif (maxy - player (i).playedCard -> returnCardHeight) div 2 > player (i).playedCard -> returnCardY then
		player (i).playedCard -> setCardCoordinates (player (i).playedCard -> returnCardX, player (i).playedCard -> returnCardY + 10)
	    elsif (maxy - player (i).playedCard -> returnCardHeight) div 2 < player (i).playedCard -> returnCardY then
		player (i).playedCard -> setCardCoordinates (player (i).playedCard -> returnCardX, player (i).playedCard -> returnCardY - 10)
	    end if
	else
	    if abs ((maxx - player (i).playedCard -> returnCardHeight) div 2 - player (i).playedCard -> returnCardX) < 10 then
		player (i).playedCard -> setCardCoordinates ((maxx - player (i).playedCard -> returnCardHeight) div 2, player (i).playedCard -> returnCardY)
	    elsif (maxx - player (i).playedCard -> returnCardHeight) div 2 > player (i).playedCard -> returnCardX then
		player (i).playedCard -> setCardCoordinates (player (i).playedCard -> returnCardX + 10, player (i).playedCard -> returnCardY)
	    elsif (maxx - player (i).playedCard -> returnCardHeight) div 2 < player (i).playedCard -> returnCardX then
		player (i).playedCard -> setCardCoordinates (player (i).playedCard -> returnCardX - 10, player (i).playedCard -> returnCardY)
	    end if
	end if
    end for
end bringCardsTogether

fcn doneCenteringCards (var player : array 0 .. 3 of players) : boolean % checks if all the played cards are at the center of the screen
    for i : 0 .. 3
	if i mod 2 = 0 then
	    if player (i).playedCard -> returnCardY ~= (maxy - player (i).playedCard -> returnCardHeight) div 2 then
		result false
	    end if
	else
	    if player (i).playedCard -> returnCardX ~= (maxx - player (i).playedCard -> returnCardHeight) div 2 then
		result false
	    end if
	end if
    end for
    result true
end doneCenteringCards

proc sendPlayedCards (point : pointer to Card, highestCard : int)       % moves the card of the highest suit to the player who recieves all the 4 cards
    %I only change the coordinates of the highest Card because at this time, only that card will be seen now
    case highestCard of
	label 0 :
	    point -> setCardCoordinates (point -> returnCardX, point -> returnCardY - 20)
	label 1 :
	    point -> setCardCoordinates (point -> returnCardX - 20, point -> returnCardY)
	label 2 :
	    point -> setCardCoordinates (point -> returnCardX, point -> returnCardY + 20)
	label 3 :
	    point -> setCardCoordinates (point -> returnCardX + 20, point -> returnCardY)
    end case
end sendPlayedCards

proc setReceivedCards (var player : array 0 .. 3 of players)                        % Puts all the receivedCards outside of the window so that they will move into the screen
    player (0).receivedCards -> setCoordinatesByCenter (player (0).handCenterX, player (0).handCenterY - player (0).hands -> returnCardHeight)
    player (1).receivedCards -> setCoordinatesByCenter (player (1).handCenterX - player (1).hands -> returnCardHeight, player (1).handCenterY)
    player (2).receivedCards -> setCoordinatesByCenter (player (2).handCenterX, player (2).handCenterY + player (2).hands -> returnCardHeight)
    player (3).receivedCards -> setCoordinatesByCenter (player (3).handCenterX + player (3).hands -> returnCardHeight, player (3).handCenterY)
    for i:0..3                                                                      % sorts and unshades the cards also so that they look more organized
	player (i).receivedCards->unshadeCard(1,player (i).receivedCards->returnSize)
	player (i).receivedCards-> sortBySuit(1)
    end for
end setReceivedCards

proc setNewHand (var player : array 0 .. 3 of players)                              % The newHand will first appear outside of the window and gruadually move up into View
    player (0).hands -> setCoordinatesByCenter (player (0).handCenterX, player (0).handCenterY - player (0).hands -> returnCardHeight)
    player (1).hands -> setCoordinatesByCenter (player (1).handCenterX - player (1).hands -> returnCardHeight, player (1).handCenterY)
    player (2).hands -> setCoordinatesByCenter (player (2).handCenterX, player (2).handCenterY + player (2).hands -> returnCardHeight)
    player (3).hands -> setCoordinatesByCenter (player (3).handCenterX + player (3).hands -> returnCardHeight, player (3).handCenterY)
    for i:0..3
	player (i).hands-> sortBySuit(1)                                            % Sorts the hand by Suit
    end for
end setNewHand

fcn doneMovingReceivedCards(player:array 0..3 of players):boolean                   % Checks if all the RecievedCards are moved up
    for i:0..3
	if  player (i).receivedCards->returnCardCenterX~=player(i).handCenterX or player (i).receivedCards->returnCardCenterY~=player(i).handCenterY then
	    result false
	end if
    end for
    result true
end doneMovingReceivedCards

fcn doneMovingHand(player:array 0..3 of players):boolean                            % checks if all of the Hands are moved up to where it should be
    for i:0..3
	if  player (i).hands->returnCardCenterX~=player(i).handCenterX or player (i).hands->returnCardCenterY~=player(i).handCenterY then
	    result false
	end if
    end for
    result true
end doneMovingHand

proc moveReceivedCards(player:array 0..3 of players)                                % moves up each of the RecievedCards
    for i:0..3
	if abs(player (i).receivedCards->returnCardCenterX-player(i).handCenterX)<10 then
	    player (i).receivedCards->setCoordinatesByCenter (player(i).handCenterX, player (i).receivedCards->returnCardCenterY)
	elsif player (i).receivedCards->returnCardCenterX<player(i).handCenterX then
	    player (i).receivedCards->setCoordinatesByCenter (player (i).receivedCards->returnCardCenterX+10, player (i).receivedCards->returnCardCenterY)
	else
	    player (i).receivedCards->setCoordinatesByCenter (player (i).receivedCards->returnCardCenterX-10, player (i).receivedCards->returnCardCenterY)
	end if
	if abs(player (i).receivedCards->returnCardCenterY-player(i).handCenterY)<10 then
	    player (i).receivedCards->setCoordinatesByCenter (player (i).receivedCards->returnCardCenterX,player(i).handCenterY)
	elsif player (i).receivedCards->returnCardCenterY<player(i).handCenterY then
	    player (i).receivedCards->setCoordinatesByCenter (player (i).receivedCards->returnCardCenterX, player (i).receivedCards->returnCardCenterY+10)
	else
	    player (i).receivedCards->setCoordinatesByCenter (player (i).receivedCards->returnCardCenterX, player (i).receivedCards->returnCardCenterY-10)
	end if
    end for
end moveReceivedCards

proc moveNewHand(player:array 0..3 of players)                                      % moves up each Hand to where it should be
    for i:0..3
	if abs(player (i).hands->returnCardCenterX-player(i).handCenterX)<10 then
	    player (i).hands->setCoordinatesByCenter (player(i).handCenterX, player (i).hands->returnCardCenterY)
	elsif player (i).hands->returnCardCenterX<player(i).handCenterX then
	    player (i).hands->setCoordinatesByCenter (player (i).hands->returnCardCenterX+10, player (i).hands->returnCardCenterY)
	else
	    player (i).hands->setCoordinatesByCenter (player (i).hands->returnCardCenterX-10, player (i).hands->returnCardCenterY)
	end if
	if abs(player (i).hands->returnCardCenterY-player(i).handCenterY)<10 then
	    player (i).hands->setCoordinatesByCenter (player (i).hands->returnCardCenterX,player(i).handCenterY)
	elsif player (i).hands->returnCardCenterY<player(i).handCenterY then
	    player (i).hands->setCoordinatesByCenter (player (i).hands->returnCardCenterX, player (i).hands->returnCardCenterY+10)
	else
	    player (i).hands->setCoordinatesByCenter (player (i).hands->returnCardCenterX, player (i).hands->returnCardCenterY-10)
	end if
    end for
end moveNewHand

fcn doneSendingCards (p : pointer to Card) : boolean                    % returns whether the highestCard moves out of the screen or not
    result p -> returnCardY > maxy or p -> returnCardY < 0 - p -> returnCardHeight or p -> returnCardX > maxx or p -> returnCardX < 0 - p -> returnCardHeight
end doneSendingCards

proc raiseLowerCards (player : players)                                                             % raises or lowers cards based on what card is selected
    for i : 1 .. player.hands -> returnSize
	if player.hands -> returnRaiseAmount (i) < player.hands -> returnRaiseDis * RAISE_TIME and i = player.selectedCard then
	    player.hands -> raiseCards (i, i)                                                       % raises the selected card that is not fully raised
	elsif player.hands -> returnRaiseAmount (i) > 0 and i ~= player.selectedCard then
	    player.hands -> lowerCards (i, i)                                                       % lowers the selected card that is not fully unraised
	end if
    end for
end raiseLowerCards

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Player Icons

proc setupEndIconLocation(var player:array 0..3 of players)                 % sets up the location of each player icon based on the rank of each player at the ecnd of the game
    var isPlaced:array 0..3 of boolean:=init(false,false,false,false)       % checks if the icons are already placed/coordinates are given to that icon
    for i:(maxx div 2)-225..(maxx div 2)+225 by 150                         % goes through from first to last place
	var highestRank:int:=5
	var plyer:int:=0
	for j:0..3
	    if player(j).rank<highestRank and ~isPlaced(j) then             % adjusts and finds the player with the best rank whose icon has not been placed yet
		plyer:=j
		highestRank:=player(j).rank
	    end if
	end for
	isPlaced(plyer):=true
	player(plyer).playerIcon.centerX:=i                                 % sets the Coordinates of the icons
	player(plyer).playerIcon.centerY:=maxy div 2 + 65        
    end for
end setupEndIconLocation

proc setupIconLocation(var player:array 0..3 of players)                    % sets the standard location of the icons
    player(0).playerIcon.centerX:=185
    player(0).playerIcon.centerY:=80
    player(1).playerIcon.centerX:=65
    player(1).playerIcon.centerY:=maxy-40
    player(2).playerIcon.centerX:=190
    player(2).playerIcon.centerY:=maxy-40
    player(3).playerIcon.centerX:=maxx-70
    player(3).playerIcon.centerY:=maxy-40
end setupIconLocation

proc setupIcons(var player:array 0..3 of players)                           % sets up the icon size, locations, all info at the very beginning of the game         
    for i:0..3                                                              % attributes for all icons
	player(i).playerIcon.size:=65
	player(i).playerIcon.font:=Font.New("TimesNewRoman:12")
    end for
    % icon for player 0
	player(0).playerIcon.name:="Pepe"
	player(0).playerIcon.image:=Pic.FileNew("Player Icons/Pepe.jpg")
    % icon for player 1
	player(1).playerIcon.name:="BibleThump"
	player(1).playerIcon.image:=Pic.FileNew("Player Icons/BibleThump.jpg")
    % icon for player 2
	player(2).playerIcon.name:="Chris"
	player(2).playerIcon.image:=Pic.FileNew("Player Icons/Chris.jpg")
    % icon for player 3
	player(3).playerIcon.name:="MingLee"
	player(3).playerIcon.image:=Pic.FileNew("Player Icons/MingLee.jpg")
end setupIcons

proc drawIcons(player:array 0..3 of players)            % draws each player icon 
    for i:0..3
	Draw.FillBox(player(i).playerIcon.centerX-player(i).playerIcon.size div 2-5,player(i).playerIcon.centerY-player(i).playerIcon.size div 2-5,player(i).playerIcon.centerX+player(i).playerIcon.size div 2+5,player(i).playerIcon.centerY+player(i).playerIcon.size div 2+5,player(i).playerIcon.c)
	Draw.Box(player(i).playerIcon.centerX-player(i).playerIcon.size div 2-5,player(i).playerIcon.centerY-player(i).playerIcon.size div 2-5,player(i).playerIcon.centerX+player(i).playerIcon.size div 2+5,player(i).playerIcon.centerY+player(i).playerIcon.size div 2+5,black)
	Pic.Draw(player(i).playerIcon.image,player(i).playerIcon.centerX-player(i).playerIcon.size div 2,player(i).playerIcon.centerY-player(i).playerIcon.size div 2,picCopy)
	Draw.Box(player(i).playerIcon.centerX-player(i).playerIcon.size div 2,player(i).playerIcon.centerY-player(i).playerIcon.size div 2,player(i).playerIcon.centerX+player(i).playerIcon.size div 2,player(i).playerIcon.centerY+player(i).playerIcon.size div 2,black)
	Draw.FillBox(player(i).playerIcon.centerX-3*(player(i).playerIcon.size div 4),player(i).playerIcon.centerY-player(i).playerIcon.size div 2,player(i).playerIcon.centerX+3*(player(i).playerIcon.size div 4),player(i).playerIcon.centerY-player(i).playerIcon.size div 2-player(i).playerIcon.size div 3,player(i).playerIcon.c)
	Draw.Box(player(i).playerIcon.centerX-3*(player(i).playerIcon.size div 4),player(i).playerIcon.centerY-player(i).playerIcon.size div 2,player(i).playerIcon.centerX+3*(player(i).playerIcon.size div 4),player(i).playerIcon.centerY-player(i).playerIcon.size div 2-player(i).playerIcon.size div 3,black)
	Font.Draw(player(i).playerIcon.name,player(i).playerIcon.centerX-Font.Width(player(i).playerIcon.name,player(i).playerIcon.font)div 2,player(i).playerIcon.centerY-player(i).playerIcon.size div 2-player(i).playerIcon.size div 3+5,player(i).playerIcon.font,black)
	Draw.FillBox(player(i).playerIcon.centerX-(player(i).playerIcon.size div 3),player(i).playerIcon.centerY-player(i).playerIcon.size div 2-2*(player(i).playerIcon.size div 3),player(i).playerIcon.centerX+(player(i).playerIcon.size div 3),player(i).playerIcon.centerY-player(i).playerIcon.size div 2-player(i).playerIcon.size div 3,player(i).playerIcon.c)
	Draw.Box(player(i).playerIcon.centerX-(player(i).playerIcon.size div 3),player(i).playerIcon.centerY-player(i).playerIcon.size div 2-2*(player(i).playerIcon.size div 3),player(i).playerIcon.centerX+(player(i).playerIcon.size div 3),player(i).playerIcon.centerY-player(i).playerIcon.size div 2-player(i).playerIcon.size div 3,black)
	Font.Draw(intstr(player(i).score),player(i).playerIcon.centerX-Font.Width(intstr(player(i).score),player(i).playerIcon.font)div 2,player(i).playerIcon.centerY-player(i).playerIcon.size div 2-2*(player(i).playerIcon.size div 3)+5,player(i).playerIcon.font,black)
    end for
end drawIcons

proc setIconColour(var player:array 0..3 of players)                                % Sets the colour of the icon border based on the ranking of each player
    for i:0..3
	player(i).playerIcon.c:=ICON_COLOURS(player(i).rank)
    end for
end setIconColour
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Draw and Vanish Cards
proc drawSentences(var player:array 0..3 of players)        % Draws the Game over screen text
    var moreThanOneWinner:boolean:=false                    % stores whether there are more winners in the game
    var winner:int:=-1                                      % stores the index of the winning player
    for i:0..3
	if player(i).rank=1 then
	    if winner~=-1 then
		moreThanOneWinner:=true
	    else
		winner:=i
	    end if
	end if
    end for 
    var winningText:string:=player(winner).playerIcon.name  % text to store the name of the winner
    if moreThanOneWinner then
	winningText+=" et al."                              % "et al." means 
    end if

    if player(winner).score=1 then                          % Writes the actual text
	winningText+=" won the game with "+intstr(player(winner).score)+" point."
    else
	winningText+=" won the game with "+intstr(player(winner).score)+" points."
    end if
    Font.Draw(winningText,(maxx-Font.Width(winningText,WINNER_FONT))div 2,maxy div 2-50,WINNER_FONT,yellow)
    var text:string:="FINAL STANDINGS"
    Font.Draw(text,(maxx-Font.Width(text,FINAL_FONT))div 2,maxy div 2+120,FINAL_FONT,yellow)
end drawSentences

proc drawTimer(tme,limit:int,inUse:boolean)             % draws the timer when person is choosing a card
    Draw.FillOval(70,60,50,50,black)
    Draw.FillOval(70,60,45,45,30)
    Draw.FillArc(70,60,45,45,90-round(360*(tme/limit)),90,21)   % timer is based on how much time until the clock reaches itch time limit
    Draw.Oval(70,60,45,45,black)
    if inUse then
	Font.Draw(intstr((limit-tme) div 1000+1), 70-Font.Width(intstr((limit-tme) div 1000+1),TIMER_FONT) div 2,60-20,TIMER_FONT,black)
    end if
end drawTimer

proc vanishCard (point : pointer to Card, num : int)                                                % vanishes the card,replaces it with a tableColour filled box
    if num mod 2 = 1 then                                                                           % the dimensions of the rectange depends on the direction of the card
	Draw.FillBox (point -> returnCardX, point -> returnCardY, point -> returnCardX + point -> returnCardWidth, point -> returnCardY + point -> returnCardHeight, tableColour)
    else
	Draw.FillBox (point -> returnCardX, point -> returnCardY, point -> returnCardX + point -> returnCardHeight, point -> returnCardY + point -> returnCardWidth, tableColour)
    end if
end vanishCard

proc vanishHand (point : pointer to Hand)                                                           % vanishes the hand
    for i:1..point->returnSize
	vanishCard(point->returnCard(i),point->returnDir)
    end for
end vanishHand

proc drawPlayedCards (player : array 0 .. 3 of players, startPlayer, person : int) % Draws ALL the played cards from each player by order of appearance
    var num : int := person
    if person < startPlayer then
	num += 4
    end if
    for i : startPlayer .. num
	player (i mod 4).playedCard -> drawCard
    end for
end drawPlayedCards

proc drawPlayedCardsByHighest (player : array 0 .. 3 of players, highestCard : int) % Draws ALL the played cards from each player with the HIghest Card being drawn last
    for i : 1 .. 4
	player ((i + highestCard) mod 4).playedCard -> drawCard
    end for
end drawPlayedCardsByHighest

proc vanishPlayedCards (player : array 0 .. 3 of players)               % vanishes all the played cards being moved
    for i : 0 .. 3
	vanishCard (player (i).playedCard, player (i).playedCard -> returnCardDir)
    end for
end vanishPlayedCards

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Draw.FillBox (0, 0, maxx, maxy, tableColour)        % draws the popular tableColour tabletop for card games
Draw.Box (0, 0, maxx, maxy, black)
var player : array 0 .. 3 of players
var deck : array 1 .. 52 of cardInfo

setupVariables (player)
initializeDeck (deck)

var timer : int := 0
player (0).selectedCard := -1


setupIcons(player)                                                                                                                      % set up size, image, etc of each player icon
% This loop is for respeating rounds until one gets to 100 points
loop    
    setupIconLocation(player)                                                                                                           % sets icon location, then sets everyone as first place for now
    resetRanking(player)
    var roundNumber:int:=0                                                                                                              % sets the round number at the beginning of the game                                                              
    Draw.FillBox(maxx div 2 -300,maxy div 2 +200,maxx div 2 +300,maxy div 2 -200,tableColour)                                           % removes the text from FInal Standings, if they were placed  
    for i : 0 .. 3                                                                                                                      % sets eveyrone's score to 0
	player (i).score := 0
    end for
    loop
	setIconColour (player)                                                                                                          % sets icon colours based on the rank of each player
	drawIcons (player)                                                                                                              % draws the timers and icons
	drawTimer(timeLimit,timeLimit,false)                                                                                            
	exit when reachSetPoints (player, setPoint)
	Draw.FillBox(AUTO_TRX-Font.Width("Round "+intstr(roundNumber),MEDIUM_FONT),10,maxx,31,tableColour)
	roundNumber+=1
	Font.Draw("Round "+intstr(roundNumber),AUTO_TRX-Font.Width("Round "+intstr(roundNumber),MEDIUM_FONT),10,MEDIUM_FONT,white)      % increases the round number and redraws the text displaying the round number
	drawConfirmBox (false,-1)      
	mouseInputs(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld)
	View.UpdateArea(0,0,maxx,maxy)
	shuffleDeck (deck)                                                                                                              % shuffles, deals, an sorts cards
	distributeCards (deck, player)
	sortHands (player)

	for i : 0 .. 3
	    player (i).hands -> copyCard (player (i).playedCard,1)                                                                      % adds temperary value for the played Card
	end for
	for i : 1 .. 3
	    player (i).hands -> setFaceDown (1, player (i).hands -> returnSize)                                                         % makes all cards in the your opponents face down
	end for

	setNewHand (player)                                                                                                             % moves hands out of view
	% this loop is for mocing each player's hands into view for play
	loop                                                                                             
	    exit when doneMovingHand (player)                                                                                           % exits when the hands are at its appropriate location
	    View.UpdateArea(0,0,maxx,maxy)
	    delay (DELAY_AMOUNT - (Time.Elapsed - timer))
	    timer := Time.Elapsed
	    mouseInputs(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld)                                                  % tracks if mouse pressed pause/auto button
	    moveNewHand (player)                                                                                                        % moves the hand
	    for i : 0 .. 3                                                                                                              % redraws the hands
		player (i).hands -> updateCardLoc
		player (i).hands -> drawHand (1, player (i).hands -> returnSize)
	    end for
	end loop

	var heartsBroken : boolean := false                                                                                             % at the beginning of each round, hearts are not broken
	var startPlayer : int := findStartingPlayer (player)                                                                            % the starting player is determined by the player with the 2 of clubs
	% This loop is for repeating each trick (4 cards being played and worked with) until everyone's hand is empty
	loop
	    exit when player (startPlayer).hands -> returnSize = 0

	    % This for loop is for getting a card for each player (4 in total)
	    for i : 0 .. 3
		var person : int := (i + startPlayer) mod 4                                                                             % stores the index of the player currently playing
		var possibleCards : int                                                                                                 % stores number of cards th eplayer could play at the time
		findPossibleCards (startPlayer, person, player (person).hands, heartsBroken, player (startPlayer).playedCard, possibleCards)
		% finds the number of possible cards and shades any cards that are not possible to play


		if person ~= 0 then                                                                                                     % the user is player 0
		    player(person).selectedCard:=chooseBestCard(player,startPlayer,person,heartsBroken)
		    %chooseRandomCard (Rand.Int (1, possibleCards), player (person).hands, player (person).selectedCard)                 % ai just choose a random card of all possible cards for now
		else
		    % This loop is for mouse inputs so the user could select a card to play
		    var turnLength : int := 0
		    var confirmIsHeld : boolean := false                                                                                % variables for the confirm button and whether the mouse is holding the button down or not
		    var cardConfirmed : boolean := false 
		    loop
			exit when cardConfirmed                                                                                         % exits when a card is confirmed
			View.UpdateArea(0,0,maxx,maxy)
			delay (DELAY_AMOUNT - (Time.Elapsed - timer))
			% timer variable ensures that the framerate of the program is always consistent and based on the desired framerate.
			turnLength += Time.Elapsed - timer
			timer := Time.Elapsed

			%%%%%% selecting cards
			selectButtonsAndCards(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld,cardConfirmed,confirmIsHeld,player,person)
			vanishHand (player (person).hands)                                                                              % vanishes the previous hand and redraws it
			raiseLowerCards (player (person))
			% raises and lower cards from the hand based on what the selected card is

			if turnLength >= timeLimit or isAuto then                                                                       % auto chooses a card if the time limit is reached or Auto MOde is Set
			    cardConfirmed := true
			    if player (person).selectedCard = -1 then
				chooseRandomCard (Rand.Int (1, possibleCards), player (person).hands, player (person).selectedCard)
			    end if
			end if

			drawTimer (turnLength, timeLimit, true)
			player (person).hands -> updateCardLoc                                                                          % adjusts the card Coordinates
			player (person).hands -> drawHand (1, player (person).hands -> returnSize)                                                   
		    end loop
		    drawTimer (timeLimit, timeLimit, false)
		end if

		drawConfirmBox (false, -1)
		var handBLX, handBLY, newBLX, newBLY : int
		% variables to store the coordinates of the hand when readjusting the hand when removing a card
		player (person).hands -> setFaceUp (player (person).selectedCard, player (person).selectedCard)
		player (person).hands -> copyCard (player (person).playedCard, player (person).selectedCard)                                   % Saves the card selected into Played Card

		setUpdatedHand (player (person).hands, player (person).selectedCard, handBLX, handBLY, newBLX, newBLY, person, player (person).handCenterY)
		% removes a card and adjusts the hand coordinates and shift distance
		var setDist : int := max (abs (handBLX - newBLX), abs (handBLY - newBLY))
		% the Distance between the the played Card and where it should be
		player (person).selectedCard := -1                                                                                                          % sets selected Card back to -1

		loop
		    exit when newBLX = handBLX and newBLY = handBLY and doneShifting (player (person).hands) and doneMovingCard (player (person).playedCard, player (person).playedCardX,
			player (person).playedCardY)
		    % exits when the hand is done adjusting and the played card is moved
		    View.UpdateArea(0,0,maxx,maxy)
		    delay (DELAY_AMOUNT - (Time.Elapsed - timer))                                                                                           % delay, same as the delay above
		    timer := Time.Elapsed
		    mouseInputs(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld)                                                              % tracks if mouse pressed pause/auto button
		    vanishCard (player (person).playedCard, player (person).playedCard -> returnCardDir)                                                    % vanishes the card
		    vanishHand (player (person).hands)
		    shiftHand (player (person).hands, handBLX, handBLY, newBLX, newBLY, setDist)
		    % readjusts the hand Coordinates and shift amount
		    movePlayedCard (player (person).playedCard, player (person).playedCardX, player (person).playedCardY)                                   % move the played card
		    raiseLowerCards (player (person))
		    % raise and lower cards if cards are not done lowering and raising
		    player (person).hands -> updateCardLoc                                                                                                  % updates Hand Coordinates
		    drawPlayedCards (player, startPlayer, person)                                                                                           % draw all cards that have been played
		    player (person).hands -> drawHand (1, player (person).hands -> returnSize)                                                              % draws hand
		end loop
		player (person).hands -> shadeCard (1, player (person).hands -> returnSize)                             % shades the hand while other people are playing
		player (person).hands -> drawHand (1, player (person).hands -> returnSize)                              % draw the hand one more time
	    end for

	    var highestCard : int                                                                                       % THe number of the player who played the HIghest Card
	    findHighestCard (player, startPlayer, highestCard)                                                          % FInds the Highest Card
	    shadeLowerCards (player, highestCard)                                                                       % shade all the played cards that are not the highest
	    % This loop is for moving all the played cards to the center
	    loop
		exit when doneCenteringCards (player)                                                                   % checks if the all the cards are in the center
		View.UpdateArea(0,0,maxx,maxy)
		delay (DELAY_AMOUNT - (Time.Elapsed - timer))                                                           % same delay stuff
		timer := Time.Elapsed
		mouseInputs(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld)                              % tracks if mouse pressed pause/auto button
		vanishPlayedCards (player)                                                                              % vanishes cards, reajust card Coordinates, then redraws the cards
		bringCardsTogether (player)
		drawPlayedCardsByHighest (player, highestCard)
	    end loop
	    vanishPlayedCards (player)                                                                                  % erases the cards
	    % after all the cards are in the center, I have one card move towards the person who will get the 4 cards, it will appear as all 4 of them goes to that player
	    loop
		exit when doneSendingCards (player (highestCard).playedCard)                                            % exits when the cards are outside of the screen
		View.UpdateArea(0,0,maxx,maxy)
		delay (DELAY_AMOUNT - (Time.Elapsed - timer))
		timer := Time.Elapsed
		mouseInputs(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld)                              % tracks if mouse pressed pause/auto button
		vanishCard (player (highestCard).playedCard, highestCard + 1)                                           % vanishes the card
		sendPlayedCards (player (highestCard).playedCard, highestCard)                                          % moves the cards outside of the screen
		player (highestCard).hands -> drawHand (1, player (highestCard).hands -> returnSize)                    % redraws the hand as the card goes over that hand
		player (highestCard).playedCard -> drawCard
	    end loop
	    View.UpdateArea(0,0,maxx,maxy)
	    if ~heartsBroken then                                                                                       % if hearts are not broken, it checks if hearts are broken
		checkIfHeartsBroken (player, heartsBroken)
	    end if
	    addReceivedCards (player (highestCard).receivedCards, player)                                               % adds important cards to the other hand of the player
	    startPlayer := highestCard                                                                                  % adjusts the new Starting player
	end loop
	setReceivedCards (player)
	% this loop is for displaying all the hearts each peron received in the round
	loop
	    exit when doneMovingReceivedCards (player)                                                                  % exits once the recieved Cards are moved to its appropriate location
	    View.UpdateArea(0,0,maxx,maxy)
	    delay (DELAY_AMOUNT - (Time.Elapsed - timer))
	    timer := Time.Elapsed
	    mouseInputs(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld)                                  % tracks if mouse pressed pause/auto button
	    for i : 0 .. 3
		vanishHand (player (i).receivedCards)                                                                   % removes the previous hands
	    end for
	    moveReceivedCards (player)                                                                                  % moves the recieved Cards
	    for i : 0 .. 3
		player (i).receivedCards -> updateCardLoc
		player (i).receivedCards -> drawHand (1, player (i).receivedCards -> returnSize)                        % redraws the Cards
	    end for
	end loop
	mouseInputs(mouseX,mouseY,mouseB,isHeld,isReleased,autoIsHeld,pauseIsHeld)                                      % tracks if mouse pressed pause/auto button
	calculateRoundPoints (player)                                                                                   % caluculates each players points this round, then add those scores to each player
	addRoundPoints (player)
	adjustRanking (player)                                                                                          % adjusts the ranking of each player based on the scores
	emptyReceivedHand (player)                                                                                      % empties all the recievedCards
	delay(1000)                                                                                                     % gives time for user to see recieved Cards
    end loop
    setupEndIconLocation(player)                                                                                        % sets up the location of the icons for drawing the final screen
    setIconColour (player)                                                                                              % sets the icon Colour nad draws the icons
    drawIcons (player)
    drawSentences(player)                                                                                               % draws all the text for the final screen
    var replayGame:boolean:=false                                                                                       % stores whether the user chose to replay the Game
    loop
	exit when replayGame                                                                                            % exits when someone wants to play another game
	View.UpdateArea(0,0,maxx,maxy)
	delay (DELAY_AMOUNT - (Time.Elapsed - timer))
	mouseFindReplay(mouseX,mouseY,mouseB,isHeld,isReleased,replayIsHeld,replayGame)                                 % tracks if mouse pressed hte replay button
    end loop
end loop

/*
  _____           _                   _   _                                   _   _______ _ _   _         _____                                                  ____                           _           _ 
 |_   _|         | |                 | | (_)                                 | | |__   __(_) | | |       / ____|                                                / __ \                         | |         | |
   | |  _ __  ___| |_ _ __ _   _  ___| |_ _  ___  _ __  ___    __ _ _ __   __| |    | |   _| |_| | ___  | (___   ___ _ __ ___  ___ _ __  ___    __ _ _ __ ___  | |  | |_   _____ _ __ _ __ __ _| |_ ___  __| |
   | | | '_ \/ __| __| '__| | | |/ __| __| |/ _ \| '_ \/ __|  / _` | '_ \ / _` |    | |  | | __| |/ _ \  \___ \ / __| '__/ _ \/ _ \ '_ \/ __|  / _` | '__/ _ \ | |  | \ \ / / _ \ '__| '__/ _` | __/ _ \/ _` |
  _| |_| | | \__ \ |_| |  | |_| | (__| |_| | (_) | | | \__ \ | (_| | | | | (_| |    | |  | | |_| |  __/  ____) | (__| | |  __/  __/ | | \__ \ | (_| | | |  __/ | |__| |\ V /  __/ |  | | | (_| | ||  __/ (_| |
 |_____|_| |_|___/\__|_|   \__,_|\___|\__|_|\___/|_| |_|___/  \__,_|_| |_|\__,_|    |_|  |_|\__|_|\___| |_____/ \___|_|  \___|\___|_| |_|___/  \__,_|_|  \___|  \____/  \_/ \___|_|  |_|  \__,_|\__\___|\__,_|

 */


import Hand in "Hand.cla"
setscreen("graphics:1200,500")
Draw.FillBox(0,0,maxx,maxy,green)
var thilash:int:=Time.Elapsed
var point:pointer to Hand
new Hand,point
setscreen("offscreenonly")
point->setDimensions(150,187)
point->setAllSimpleG
point->setCoordinates(10,10)
point->setDirection(1)
point->setCardDistance(20)
point->setRaiseDis(30)
var chris:int:=Time.Elapsed
for decreasing i:13..1
    for j:2..2
	point->addCard(i,j)
    end for
end for
var hans:int:=Time.Elapsed
%point->removeCard(14,14)
%point->flipCards(1,point->returnSize)
var teg:int:=Time.Elapsed
point->shuffleHand(1,point->returnSize)
point->sortBySuit(1)
point->shadeCard(5,7)
point->unshadeCard(6,8)
point->updateCardLoc
var kamil:int:=Time.Elapsed
point->drawHand(1,point->returnSize)
var yak:int:=Time.Elapsed
point->drawHand(1,point->returnSize)
var wow:int:=Time.Elapsed
put hans-chris, " adding cards"
put teg-hans, " removing"
put kamil-teg," Wow sorting"
put yak-kamil
put wow-yak
View.Update

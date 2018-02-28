View.Set("offscreenonly")
var thilash:int:=Time.Elapsed
var face : int := Pic.FileNew ("standard_jackS.jpg")
for i:1..10
Pic.Draw(face,i*10,10,picCopy)
end for
put Time.Elapsed-thilash
View.Update

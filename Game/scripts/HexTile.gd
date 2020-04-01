extends Spatial

class_name HexTile
onready var Getreide = $"HexGetreide"
onready var Sheep = $"HexSheep"
onready var Wald = $"HexWald"
onready var Stein = $"HexStein"
onready var Wueste = $"HexWueste"
onready var Lehm = $"HexLehm"
onready var Coin = $"Sprite3D"
export (int,"Getreide","Schafe","Wald","Stein","Wueste","Lehm") var TYPE

func _ready():
	pass
	# Getreide.set_visible(false)
	# Sheep.set_visible(false)
	# Wald.set_visible(false)
	# Stein.set_visible(false)
	# Wueste.set_visible(false)
	# Lehm.set_visible(false)
	# if TYPE == 0:
	# 	Getreide.set_visible(true)
	# if TYPE == 1:
	# 	Sheep.set_visible(true)
	# if TYPE == 2:
	# 	Wald.set_visible(true)
	# if TYPE == 3:
	# 	Stein.set_visible(true)
	# if TYPE == 4:
	# 	Wueste.set_visible(true)
	# if TYPE == 5:
	# 	Lehm.set_visible(true)
	
func setNumber(a:int):
	var tmp = a - 2
	if tmp > 4:
		tmp = tmp - 1
		
	Coin.set_frame(tmp)
	Coin.set_visible(true)
	#print("Got: ",a," and set:",tmp)

func setType(n):
	Getreide.set_visible(false)
	Sheep.set_visible(false)
	Wald.set_visible(false)
	Stein.set_visible(false)
	Wueste.set_visible(false)
	Lehm.set_visible(false)
	if n == "Getreide":
		Getreide.set_visible(true)
		TYPE=0
	if n == "Schafe":
		Sheep.set_visible(true)
		TYPE=1
	if n == "Wald":
		Wald.set_visible(true)
		TYPE=2
	if n == "Stein":
		Stein.set_visible(true)
		TYPE=3
	if n == "Wueste":
		Wueste.set_visible(true)
		TYPE=4
	if n == "Lehm":
		Lehm.set_visible(true)
		TYPE=5

func isWueste():
	return TYPE == 4
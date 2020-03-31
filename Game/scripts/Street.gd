extends Spatial

onready var red = $"Area/CollisionShape/StreetRed"
onready var green = $"Area/CollisionShape/StreetGreen"
onready var yellow = $"Area/CollisionShape/StreetYellow"
onready var blue = $"Area/CollisionShape/StreetBlue"
onready var transparent = $"Area/CollisionShape/Transparent"
var mouseOver : bool = false
var isBuilt : bool = false

func _ready():
	$Area.connect("mouse_entered",self,"mouse_entered")
	$Area.connect("mouse_exited",self,"mouse_exited")

func mouse_entered():
	mouseOver = true
func mouse_exited():
	mouseOver = false

func _process(delta):
	if not isBuilt:
		if mouseOver:
			transparent.set_visible(true)
		else:
			transparent.set_visible(false)
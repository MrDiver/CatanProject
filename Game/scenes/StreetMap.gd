extends Spatial

func _ready():
	$Map.regenMap()

remotesync func regenMap(newseed : int):
	Globals.SEED = newseed
	$Map.regenMap()
	$Control/Label.text = "Seed: " + str(newseed)

func _on_NewMap_pressed():
	var le : LineEdit = $"Control/seedline"
	var tmp = 0
	if le.text != "":
		tmp = int(le.text)
	else:
		tmp = Globals.SEED + 1
	rpc("regenMap",tmp)

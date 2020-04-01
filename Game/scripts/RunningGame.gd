extends Spatial


var offsetrotation = 0

func _ready():
	var localPlayer = preload("res://Game/scenes/Player.tscn").instance()
	localPlayer.set_name(str(get_tree().get_network_unique_id()))
	localPlayer.set_network_master(get_tree().get_network_unique_id())
	add_child(localPlayer)
	localPlayer.updateCamera()

	print("Players: ",Globals.players)
	print("My Id:",get_tree().get_network_unique_id())
	print("My Color:",Globals.color)
	#Adding clients
	# for id in Globals.players:
	# 	var clientPlayer = preload("res://Game/scenes/Player.tscn").instance()
	# 	clientPlayer.set_name(str(id))
	# 	clientPlayer.set_network_master(id)
	# 	offsetrotation = offsetrotation + 1
	# 	add_child(clientPlayer)
	# 	print("Client ",id," Network Master: ",clientPlayer.is_network_master())

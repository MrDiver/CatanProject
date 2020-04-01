extends Spatial

func _ready():
	pass

func updateCamera():
	print("ID:",get_tree().get_network_unique_id(), "Network Master:",is_network_master())
	#if is_network_master():
		#$Camera.make_current()

extends Spatial

func _ready():
	$Camera/Label.text = "Farbe: " + Globals.color

func _process(delta):
	if Input.is_key_pressed(KEY_D):
		rotate_y(PI/2*delta)
	if Input.is_key_pressed(KEY_A):
		rotate_y(-PI/2*delta)
	if Input.is_key_pressed(KEY_S):
		var dir = $Camera.get_global_transform().basis.z
		dir.y = 0
		$Camera.global_translate(dir)
	if Input.is_key_pressed(KEY_W):
		var dir = -$Camera.get_global_transform().basis.z
		dir.y = 0
		$Camera.global_translate(dir)

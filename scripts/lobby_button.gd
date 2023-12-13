extends Button

var selected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !GameVars.connected_players.is_empty():
		if Input.is_joy_button_pressed(GameVars.connected_players[0],JOY_BUTTON_A) and selected:
			emit_signal("pressed")
		if Input.is_action_just_pressed("space") and GameVars.connected_players[0] == 4 and selected:
			emit_signal("pressed")

func _on_area_2d_body_entered(body):
	if !GameVars.connected_players.is_empty():
		if str(0) in body.name:
			selected = true


func _on_area_2d_body_exited(body):
	if !GameVars.connected_players.is_empty():
		if str(0) in body.name:
			selected = false

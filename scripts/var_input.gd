extends Label

@export var selected_var = 0
var selected_by_down = []
var selected_by_up = []
@export var num = 20
var delay = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

@onready var timer = get_node("delay")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if selected_var == 0:
		GameVars.victory_score = num
	if selected_var == 1:
		GameVars.flip_interval = num
	text = str(num)
	
	if !selected_by_down.is_empty():
		for id in selected_by_down:
			if Input.is_joy_button_pressed(id,JOY_BUTTON_A) and !delay:
				delay = true
				timer.start(0.1)
				num = clamp(num-1,-1,100)
	
	if !selected_by_up.is_empty():
		for id in selected_by_up:
			if Input.is_joy_button_pressed(id,JOY_BUTTON_A) and !delay:
				delay = true
				timer.start(0.1)				
				num = clamp(num+1,0,100)


func _on_up_input_body_entered(body):
	if body.is_in_group("cursor"):
		selected_by_up.append(int(str(body.player_input)))


func _on_up_input_body_exited(body):
	if body.is_in_group("cursor"):
		selected_by_up.erase(int(str(body.player_input)))


func _on_down_input_body_entered(body):
	if body.is_in_group("cursor"):
		selected_by_down.append(int(str(body.player_input)))


func _on_down_input_body_exited(body):
	if body.is_in_group("cursor"):
		selected_by_down.erase(int(str(body.player_input)))


func _on_delay_timeout():
	delay = false

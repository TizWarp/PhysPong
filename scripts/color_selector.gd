extends ColorRect

var colors = ["Red","Blue","Green","Yellow","White","Black","Purple","Cyan"]
@export var selected_color = 0

@onready var label = get_node("Label")
@onready var delay_timer = get_node("delay")
@export var player = 0

@export var selected = false
var delayed = false

func _ready():
	pass

func _process(delta):
	
	if GameVars.connected_players.size()-1 >= player:
		show()
		
		if GameVars.connected_players[player] == 4:
			if Input.is_action_just_pressed("space"):
				delayed = true
				delay_timer.start(0.3)
				if selected_color+1 > colors.size()-1:
					selected_color = 0
				else:
					selected_color = selected_color+1		
		elif Input.is_joy_button_pressed(GameVars.connected_players[player],JOY_BUTTON_A) and selected and !delayed:
			delayed = true
			delay_timer.start(0.3)
			if selected_color+1 > colors.size()-1:
				selected_color = 0
			else:
				selected_color = selected_color+1
	else:
		hide()
	color = GameVars.color_index[colors[selected_color]]
	
	if player == 0:
		GameVars.player1color = colors[selected_color]
		label.text = "Player 1 Color"
	if player == 1:
		GameVars.player2color = colors[selected_color]
		label.text = "Player 2 Color"		
	if player == 2:
		GameVars.player3color = colors[selected_color]
		label.text = "Player 3 Color"		
	if player == 3:
		GameVars.player4color = colors[selected_color]
		label.text = "Player 4 Color"		
	
func _on_right_arrow_body_entered(body):
	if str(player) in body.name:
		selected = true


func _on_right_arrow_body_exited(body):
	if str(player) in body.name:
		selected = false


func _on_delay_timeout():
	delayed = false

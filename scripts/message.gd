extends Label

var time = 2
@onready var animations = get_node("AnimationPlayer")
var color = Color(255,255,255)

func _process(delta):
	if GameVars.in_game:
		modulate = color
	if self_modulate.a > 0 and GameVars.in_game:
		animations.play("fade_out")

func _ready():
	Signals.connect("reset_game",reset_game)
	Signals.connect("start_game",start_game)
	

func reset_game():
	modulate = Color(255,255,255)
	animations.play("fade_in")
	await get_tree().create_timer(time).timeout
	animations.play("fade_out")
	await get_tree().create_timer(1).timeout
	text = "PhysPong"
	animations.play("fade_in")

func start_game():
	animations.play("fade_out")

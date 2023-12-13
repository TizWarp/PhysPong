extends Camera2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("scroll_down"):
		zoom -= Vector2(0.01,0.01)
	if Input.is_action_just_released("scroll_up"):
		zoom += Vector2(0.01,0.01)

extends StaticBody2D

@onready var collision = get_node("CollisionShape2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameVars.soccer_mode:
		hide()
		collision.disabled = true
	if !GameVars.soccer_mode:
		show()
		collision.disabled = false
		

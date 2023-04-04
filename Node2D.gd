extends Node2D
@onready var mousepad = $Area2D/CollisionShape2D
@onready var aim = $Aim
var mousepad_active = false
var SCREEN_X
var SCREEN_Y

func _ready():
	SCREEN_X = get_viewport().size.x
	SCREEN_Y = get_viewport().size.y



func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		mousepad_active = event.pressed
	if mousepad_active:
		var R = mousepad.shape.radius
		aim.position = (get_global_mouse_position() - mousepad.position + Vector2(R,R)) * Vector2(SCREEN_X, SCREEN_Y) * 1.5 / (2 * Vector2(R,R)) - Vector2(SCREEN_X, SCREEN_Y)*0.25
	

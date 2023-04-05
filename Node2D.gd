extends Node2D
@onready var mousepad = $Area2D/CollisionShape2D
@onready var aim = $Aim
@onready var chain = $Chain
var mousepad_active = false
var SCREEN_X
var SCREEN_Y

var grab_closed = false
var grabbed_items = []


func _ready():
	SCREEN_X = get_viewport().size.x
	SCREEN_Y = get_viewport().size.y



func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		mousepad_active = event.pressed
	if mousepad_active:
		var R = mousepad.shape.radius
		aim.position = (get_global_mouse_position() - mousepad.position + Vector2(R,R)) * Vector2(SCREEN_X, SCREEN_Y) * 1.5 / (2 * Vector2(R,R)) - Vector2(SCREEN_X, SCREEN_Y)*0.25
		chain.size.x = aim.position.y/chain.scale.x
		chain.stretch_mode = TextureRect.STRETCH_TILE
		chain.position.x = aim.position.x + chain.size.y*.15/2 - 3
		for i in grabbed_items:
			i.get_parent().position = aim.position + Vector2(0, 30)

func _input(event):
	if event is InputEventKey and event.keycode == 32:
		if event.is_pressed() and !grab_closed:
			grab_closed = true
			aim.play("close")
			for i in $Aim/Area2D.get_overlapping_areas():
				grabbed_items.append(i)
		if !event.is_pressed() and grab_closed:
			grabbed_items = []
			grab_closed = false
			aim.play("open")
		

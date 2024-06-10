extends Area2D

@onready var col = $Col
@onready var sprite = $Sprite

var tex_idle = preload("res://texture/Daiyousei.png")
var tex_held = preload("res://texture/Daiyousei2.png")

var held = false
var mouse_rel_pos:Vector2

func _ready():
	update_polygon()
	
func update_polygon():
	var p = col.polygon
	for i in range(p.size()):
		p[i] = to_global(p[i])
	get_window().mouse_passthrough_polygon = p

func _input(event):
	if held and event is InputEventMouseMotion:
		get_window().position = DisplayServer.mouse_get_position() - (mouse_rel_pos as Vector2i)
		if event.relative.x > 0.01:
			sprite.flip_h = true
		elif  event.relative.x < -0.01:
			sprite.flip_h = false
		

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		held = event.pressed
		if held:
			mouse_rel_pos = event.position
		
		sprite.texture = tex_held if held else tex_idle

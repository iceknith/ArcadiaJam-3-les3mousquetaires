class_name ButtonTouch3D extends Button

@export var effectSize:float = 0.75

var has_mouse_in:bool = false

func _ready() -> void:
	material = ShaderMaterial.new()
	material.shader = preload("res://src/customScripts/3Dshader.gdshader")
	material.set_shader_parameter("isInRadians", true)
	material.set_shader_parameter("pivotPoint", get_rect().size/2)
	for child in get_children():
		child.material = material
	
	#Connect signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(delta: float) -> void:
	if has_mouse_in:
		var mouse_pos:Vector2 = -(get_local_mouse_position() - get_rect().size/2) / get_rect().size * effectSize
		material.set_shader_parameter("xRadians", mouse_pos.y)
		material.set_shader_parameter("yRadians", mouse_pos.x)
	else:
		material.set_shader_parameter("xRadians", 0)
		material.set_shader_parameter("yRadians", 0)
		material.set_shader_parameter("zRadians", 0)

func _on_mouse_entered() -> void:
	has_mouse_in = true


func _on_mouse_exited() -> void:
	has_mouse_in = false

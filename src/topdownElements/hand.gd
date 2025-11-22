class_name hand extends Sprite2D

@export var distToEndPosY = 500
var endPos:Vector2

func _ready() -> void:
	endPos = position
	position.y = distToEndPosY + endPos.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y = distToEndPosY + endPos.y

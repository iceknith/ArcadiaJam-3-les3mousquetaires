extends Container


# Called when the node enters the scene tree for the first time.
func _ready():
	load_organs()

func load_organs():
	var image:TextureRect
	var oldImage:TextureRect = get_child(0).duplicate()
	for child in get_children(): child.queue_free()
	
	for organ in PlayerVars.organes:
		for i in range(PlayerVars.organes[organ]):
			image = oldImage.duplicate()
			image.texture = load(OrganVars.organs[organ]["image"])
			add_child(image)

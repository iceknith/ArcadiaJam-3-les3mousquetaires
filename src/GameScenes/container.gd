extends Container


# Called when the node enters the scene tree for the first time.
func _ready():
	load_organs()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_organs():
	var image:TextureRect
	for organ in PlayerVars.organes:
		print(organ)
		for i in range(PlayerVars.organes[organ]):
			print(PlayerVars.organes[organ])
			image = $TextureRect.duplicate()
			print(OrganVars.organs[organ]["image"])
			image.texture = load(OrganVars.organs[organ]["image"])

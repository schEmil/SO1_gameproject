extends ColorRect

@export var color_ramp : Texture2D
@onready var img_ramp : Image = color_ramp.get_image()

var ratio : float = 0.0

func set_ratio(val : float = 0.0):
	ratio = val
	
	var pixel_pos : int = 0
	pixel_pos = clamp(int(float(img_ramp.get_size().x)*ratio)-1,0,img_ramp.get_size().x)
	#print(pixel_pos)
	color = img_ramp.get_pixel(pixel_pos,0)

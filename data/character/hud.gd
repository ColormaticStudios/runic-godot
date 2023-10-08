extends Control


var padding = 30


func resize():
	var viewport_size = get_viewport().size
	position.x = (-(viewport_size[0]/2))+padding
	position.y = (-(viewport_size[1]/2))+padding
	size.x = (viewport_size[0])-padding*2 #I don't know why padding needs to be doubled
	size.y = (viewport_size[1])-padding*2

func _ready():
	resize()
	get_tree().get_root().size_changed.connect(resize)

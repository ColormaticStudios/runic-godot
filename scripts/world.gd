@tool
extends Node2D


var objects = [
	"res://data/objects/stone.tscn",
	"res://data/objects/tree.tscn"
]
var object_ammount = 20 #the ammount of each type of object
var this_seed = 1234


func _ready():
	seed(this_seed)
	for object in objects:
		for iter in range(object_ammount):
			var this_object = load(object).instantiate()
			this_object.position.x = randf_range(-4000, 4000)
			this_object.position.y = randf_range(-4000, 4000)
			$objects.add_child(this_object)

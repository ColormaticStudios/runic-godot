@tool
extends Node2D


var objects = {
	"forest": [
		"res://data/objects/stone.tscn",
		"res://data/objects/tree.tscn"
	],
	"desert": [
		"res://data/objects/stone.tscn"
	]
}
var object_ammount = 20 #the ammount of each type of object
var this_seed = 1234


func _ready():
	seed(this_seed)
	
	#generate objects in forest
	for object in objects.forest:
		for iter in range(object_ammount):
			var this_object = load(object).instantiate()
			$biomes/forest.add_child(this_object)
			this_object.position.x = randf_range(-4000, 4000)
			this_object.position.y = randf_range(-4000, 4000)
			this_object.rotation_degrees = randf_range(0, 360)
			this_object.z_index = 10
	
	#generate objects in desert
	for object in objects.desert:
		for iter in range(object_ammount):
			var this_object = load(object).instantiate()
			$biomes/desert.add_child(this_object)
			this_object.position.x = randf_range(-4000, 4000)
			this_object.position.y = randf_range(-4000, 4000)
			this_object.rotation_degrees = randf_range(0, 360)
			this_object.z_index = 10

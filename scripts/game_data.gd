extends Node


var tools = {
	"none": {
		"image": "res://textures/tools/none.svg",
		"offset": Vector2(0, 0)
	},
	"stick": {
		"image": "res://textures/tools/stick.svg",
		"offset": Vector2(-80, -120)
	},
	"stone_axe": {
		"image": "res://textures/tools/stone_axe.svg",
		"offset": Vector2(-80, -195)
	}
}

var level_tools = {
	1: "stick",
	5: "stone_axe"
}

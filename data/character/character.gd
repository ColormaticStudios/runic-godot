extends CharacterBody2D


var speed = 150
var accel = 10
var immobile = false

var inventory = {
	"points": 0,
	"stone": 0,
	"wood": 0,
	"food": 0
}
var status = {
	"health": 100,
	"stamina": 100,
	"level": 1
}
var current_tool = "none"


func get_total_points_for_next_level(): #Yes, this name is very long. Deal with it
	return status.level*10

func change_tool(tool):
	current_tool = tool
	$body_pivot/body/tool.texture = load(game_data.tools[tool].image)
	$body_pivot/body/tool.position = game_data.tools[tool].offset

func _ready():
	change_tool("stick")

func _physics_process(delta):
	var pre_velocity = Vector2(0, 0)
	if !immobile:
		pre_velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = lerp(velocity, pre_velocity * speed, accel*delta)
	move_and_slide()

func _process(delta):
	if Input.is_action_pressed("game_interact"):
		if !$animation.is_playing():
			$animation.play("hit")
			if $body_pivot/raycast.is_colliding():
				var hit_object = $body_pivot/raycast.get_collider()
				if hit_object.type == "resource":
					inventory[hit_object.resource_type] += 1
					inventory.points += 1
					hit_object.get_node("animation").play("hit")
	
	#update inventory HUD
	$hud/inventory/stone_label.text = str(inventory.stone)
	$hud/inventory/wood_label.text = str(inventory.wood)
	$hud/level/points.text = str(inventory.points) + "/" + str(get_total_points_for_next_level())
	$hud/level/level_bar.value = inventory.points
	
	#update status HUD
	$hud/bars/health.value = status.health
	$hud/bars/stamina.value = status.stamina
	$hud/level/level.text = "Level " + str(status.level)
	$hud/level/level_bar.max_value = get_total_points_for_next_level()
	
	#level up
	if inventory.points >= (get_total_points_for_next_level()):
		inventory.points -= get_total_points_for_next_level()
		status.level += 1

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = get_global_mouse_position()
		$body_pivot.rotation = atan2((mouse_pos.y-position.y), (mouse_pos.x-position.x)) + (PI * 0.5)

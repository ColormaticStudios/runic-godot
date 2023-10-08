extends CharacterBody2D


var speed = 150
var accel = 10
var immobile = false

var inventory = {
	"stone": 0,
	"wood": 0,
	"food": 0
}
var status = {
	"health": 100,
	"stamina": 100
}


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
					hit_object.get_node("animation").play("hit")
	
	#update inventory HUD
	$hud/inventory/stone_label.text = str(inventory.stone)
	$hud/inventory/wood_label.text = str(inventory.wood)
	
	#update status HUD
	$hud/bars/health.value = int(lerp($hud/bars/health.value, float(status.health), 20*delta))
	$hud/bars/stamina.value = int(lerp($hud/bars/stamina.value, float(status.stamina), 20*delta))

func _input(event):
	if event is InputEventMouseMotion:
		var mouse_pos = get_global_mouse_position()
		$body_pivot.rotation = atan2((mouse_pos.y-position.y), (mouse_pos.x-position.x)) + (PI * 0.5)

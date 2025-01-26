extends CharacterBody2D

const SPEED = 25
var player_chase = false
var player = null
var last_direction

func _physics_process(delta: float) -> void:

	$AnimatedSprite2D.play("down_idle")

	# if player_chase:
	# 	var direction = global_position.direction_to(player.global_position)
	# 	velocity = direction * SPEED

	# 	if abs(direction.x) > abs(direction.y):

	# 		if direction.x > 0:
	# 			$AnimatedSprite2D.flip_h = false
	# 			last_direction = "right"
	# 		else:
	# 			$AnimatedSprite2D.flip_h = true
	# 			last_direction = "left"

	# 		$AnimatedSprite2D.play("side_move")

	# 	else:
	# 		if direction.y > 0:
	# 			$AnimatedSprite2D.play("down_move")
	# 			last_direction = "down"
	# 		else:
	# 			$AnimatedSprite2D.play("up_move")
	# 			last_direction = "up"

	# 	move_and_slide()

	# else:

	# 	match last_direction:
	# 		"right":
	# 			$AnimatedSprite2D.flip_h = false
	# 			$AnimatedSprite2D.play("side_idle")
	# 		"left":
	# 			$AnimatedSprite2D.flip_h = true
	# 			$AnimatedSprite2D.play("side_idle")
	# 		"up":
	# 			$AnimatedSprite2D.play("up_idle")
	# 		"down":
	# 			$AnimatedSprite2D.play("down_idle")
	# 		_:
	# 			$AnimatedSprite2D.play("down_idle")

# func _on_dectection_area_body_entered(body:Node2D) -> void:
# 	player = body
# 	player_chase = true


# func _on_dectection_area_body_exited(body:Node2D) -> void:
# 	player = null
# 	player_chase = false

# func _take_damage(damage:int) -> void:
	match last_direction:
			"right":
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("side_hurt")
			"left":
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("side_hurt")
			"up":
				$AnimatedSprite2D.play("up_hurt")
			"down":
				$AnimatedSprite2D.play("down_hurt")
			_:
				$AnimatedSprite2D.play("down_hurt")
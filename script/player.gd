extends CharacterBody2D
enum Directions{
	UP,
	DOWN,
	LEFT,
	RIGHT
}

enum Actions{
	WALK,
	IDLE
}

const SPEED = 100
var current_dir = Directions.DOWN
var current_action = Actions.IDLE
var last_direction = Directions.DOWN

var enemy_inattack_range = false
var enemy_attack_cooldown = false
var health = 100
const DAMAGE = 5

func _physics_process(delta: float) -> void:
	_player_movement(delta)
	player_take_damage(delta)
	
func _player_movement(delta: float) -> void:
	
	current_action = Actions.WALK
	
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("move_right"):
		current_dir = Directions.RIGHT
		velocity.x = SPEED
		velocity.y = 0

	elif  Input.is_action_pressed("ui_left") or Input.is_action_pressed("move_left"):
		current_dir = Directions.LEFT
		velocity.x = -SPEED
		velocity.y = 0

	elif Input.is_action_pressed("ui_down") or Input.is_action_pressed("move_down"):
		current_dir = Directions.DOWN
		velocity.x = 0
		velocity.y = SPEED

	elif Input.is_action_pressed("ui_up") or Input.is_action_pressed("move_up"):
		current_dir = Directions.UP
		velocity.x = 0
		velocity.y = -SPEED

	else:
		current_dir = last_direction
		current_action = Actions.IDLE
		velocity.x = 0
		velocity.y = 0
	
	_play_animation(current_dir,current_action)
	move_and_slide()

func _play_animation(direction, action) -> void:
	var animation = $AnimatedSprite2D
	
	match direction:
		Directions.RIGHT:

#			Right Direction

			$AnimatedSprite2D.flip_h = false
			last_direction = Directions.RIGHT

			match action:
				Actions.WALK:
					animation.play("side_walk")
					pass
				_:
					animation.play("side_idle")
					pass
			pass
		Directions.LEFT:
#			Left Direction
			$AnimatedSprite2D.flip_h = true
			last_direction = Directions.LEFT

			match action:
				Actions.WALK:
					animation.play("side_walk")
					pass
				_:
					animation.play("side_idle")
					pass

			pass
		Directions.UP:
#			Up Direction

			last_direction = Directions.UP

			match action:
				Actions.WALK:
					animation.play("up_walk")
					pass
				_:
					animation.play("up_idle")
					pass

			pass
		
		Directions.DOWN:
#			Down Direction

			last_direction = Directions.DOWN

			match action:
				Actions.WALK:
					animation.play("down_walk")
					pass
				_:
					animation.play("down_idle")
					pass

			pass

		_:
			#IDLE

			match last_direction:
				Directions.RIGHT:

					$AnimatedSprite2D.flip_h = false
					animation.play("side_idle")
					
					pass
				Directions.LEFT:
					$AnimatedSprite2D.flip_h = true
					animation.play("side_idle")
					pass
				Directions.UP:
					animation.play("up_idle")
					pass
				Directions.DOWN:
					animation.play("down_idle")
					pass
				_:
					animation.play("down_idle")
					pass
				


func _on_hitbox_body_entered(body:Node2D) -> void:
	print(body.has_method("enemy"))
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_hitbox_body_exited(body:Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false


func player_take_damage(delta) -> void:
	if enemy_inattack_range and enemy_attack_cooldown == false:
		print(health)
		health -= DAMAGE * delta
		print(health)
		enemy_attack_cooldown = true
		$Attack_cooldown.start()
		if health <= 0:
			queue_free()
		pass


func _on_attack_cooldown_timeout() -> void:
	print("Attack Cooldown")
	enemy_attack_cooldown = false

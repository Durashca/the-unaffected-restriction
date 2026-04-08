extends CharacterBody2D

# Параметры движения
@export var speed: float = 150.0           # скорость бега
@export var jump_velocity: float = -400.0  # скорость прыжка (отрицательная т.к. y вверх)
@export var gravity: float = 1200.0        # сила гравитации

# Получение ввода
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# 1. Горизонтальное движение (влево/вправо)
	var direction: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# 2. Применение гравитации (только если не на полу)
	if not is_on_floor():
		velocity.y += gravity * delta

	# 3. Прыжок (только на полу)
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# 4. Движение с помощью move_and_slide()
	move_and_slide()

	# 5. Анимации (опционально)
	update_animations(direction)

func update_animations(direction: float) -> void:
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
			# Поворот спрайта в зависимости от направления
			sprite.flip_h = direction < 0
	else:
		if velocity.y < 0:
			sprite.play("jump")
		else:
			sprite.play("fall")

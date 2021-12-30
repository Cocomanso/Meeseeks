extends Node2D

export var lives := 10
var saved_lives := 0
export var objective := 5
export var total_time := 5.0
var game_speed:= 50
var game_speed_change:= 5
var meeseek = preload("res://Scenes/Meeseek/Meeseek.tscn");
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# Replace with function body.

func _enter_tree():
	pass	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _speed_changed(value):
	pass
	#change actual value of spawn time on timer
func _spawn_meeseek():
	if lives>0:
		lives -= 1
		var newMeeseek = meeseek.instance()
		newMeeseek.position = $Spawn.position
		add_child(newMeeseek)
func meeseek_saved():
	saved_lives += 1
	print('Salvado maradona')
	if saved_lives == objective:
		pass
		#fin
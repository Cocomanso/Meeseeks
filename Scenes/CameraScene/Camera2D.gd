extends Camera2D

var viewport_size;
var width_half
var height_half
var zoom_dif_h
var zoom_dif_v
var w_h_times_zoom
var h_h_times_zoom
var TileMapBorder

export var tween_duration := 0.5
export var max_zoom := 2.0
export var min_zoom := 0.5
var zoom_level := 1.0 setget _set_zoom_level
var _zoom_factor := 0.1

onready var tween : Tween = $Tween

func _ready():
	TileMapBorder = $"../TileMap".get_used_rect();
	#print(TileMapBorder.position);
	self.limit_top = TileMapBorder.position.x*64;
	self.limit_left = TileMapBorder.position.y *64;
	self.limit_right = TileMapBorder.end.x*64;
	self.limit_bottom = TileMapBorder.end.y *64;
	#print(TileMapBorder.position.x);
	viewport_size = get_viewport().size;
	width_half = viewport_size.x/2;
	height_half = viewport_size.y/2;
	w_h_times_zoom = width_half * self.zoom.x;
	h_h_times_zoom = height_half * self.zoom.y;

func _process(delta):
	var move_vector = Vector2();
	var mouse_pos = get_viewport().get_mouse_position();
	_update_wiewport()
	if mouse_pos.x < 30 && self.position.x - w_h_times_zoom > self.limit_left:
			move_vector.x = -1;
	elif mouse_pos.x > viewport_size.x - 15 && self.position.x + w_h_times_zoom < self.limit_right:
		move_vector.x = 1;
	if mouse_pos.y < 30 && self.position.y - h_h_times_zoom > self.limit_top:
		move_vector.y = -1;
	if mouse_pos.y > viewport_size.y - 15  && self.position.y + h_h_times_zoom < self.limit_bottom:
		move_vector.y = 1;

	global_translate(move_vector * delta * 300 * self.zoom.x)

func _update_wiewport():
	viewport_size = get_viewport().size;
	width_half = viewport_size.x/2;
	height_half = viewport_size.y/2;
	w_h_times_zoom = width_half * self.zoom.x;
	h_h_times_zoom = height_half * self.zoom.y;

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		_set_zoom_level(zoom_level - _zoom_factor)
	if event.is_action_pressed("zoom_out"):
		_set_zoom_level(zoom_level + _zoom_factor)
		
#el zoom ahora mismo permite ver fuera del mapa.
func _set_zoom_level(value: float): 
	zoom_level = clamp(value, min_zoom, max_zoom);
	tween.interpolate_property(
		self, 
		'zoom', 
		zoom,
		zoom_level * Vector2.ONE,
		tween_duration,
		Tween.TRANS_SINE,
		Tween.EASE_OUT);
	tween.start();


func _on_DiggerSideButton_pressed():
	get_parent().mouse_pointer = 'DigSide';

func _on_DiggerDownButton_pressed():
	get_parent().mouse_pointer = 'DigDown';

func _on_StopperButton_pressed():
	get_parent().mouse_pointer = 'Stopper';

func _on_UmbrellaButton_pressed():
	get_parent().mouse_pointer = 'Umbrella';

func _on_StairButton_pressed():
	get_parent().mouse_pointer = 'Stair';

func _on_ClimbButton_pressed():
	get_parent().mouse_pointer = 'Climb';

func _on_RestartButton_pressed():
	pass

func _on_TimeDownButton_pressed():
	pass

func _on_TimeUpButton_pressed():
	pass

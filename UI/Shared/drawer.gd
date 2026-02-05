extends PanelContainer
class_name Drawer

@onready var drawer := self

##Is the Drawer open from the start.
@export var is_open: bool = false

##Time for the animation to play.
@export var animation_time: float = 0.25

##Define how wide the draw is as a % of the Windows total width.
@export_range(0.0, 1.0, 0.05)
var drawer_width_ratio: float = 0.25

##Defines where a drawer is placed. If [member drawer_width_ratio] is set to 1, this has no effect.
##[br][b]Examples: [/b]
##[br]0: Left; 0.5: Center; 1: Right;
@export_range(0.0, 1.0, 0.05)
var drawer_horizontal_anchor: float = 0.5

##Define how heigh the draw is as a % of the Windows total height.
@export_range(0.0, 1.0, 0.05)
var drawer_height_ratio: float = 1.0

##Defines where a drawer is placed. If [member drawer_height_ratio] is set to 1, this has no effect.
##[br][b]Examples: [/b]
##[br]0: Top; 0.5: Center; 1: Bottom;
@export_range(0.0, 1.0, 0.05)
var drawer_vertical_anchor: float = 0.5

##Select where the Drawer will come from.
@export var drawer_placement: DrawerPlacement = DrawerPlacement.RIGHT

enum DrawerPlacement{
	##Drawer Will come out from the left.
	LEFT,
	##Drawer Will come out from the right.
	RIGHT,
	##Drawer Will come out from the top.
	TOP,
	##Drawer Will come out from the bottom.
	BOTTOM
}

var _property_x: String = "position:x"
var _property_y: String = "position:y"

var _property: String = "position:x"

var _call_open: Callable = Callable(self, "_right_open_coords")
var _call_close: Callable = Callable(self, "_right_close_coords")

func _ready() -> void:
	
	match drawer_placement:
		DrawerPlacement.LEFT:
			self.anchor_left = 0
			self.anchor_top = 0
			self.anchor_right = 0
			self.anchor_bottom = 1
			
			_property = _property_x
			_call_open = Callable(self, "_left_open_coords")
			_call_close = Callable(self, "_left_close_coords")
		DrawerPlacement.RIGHT:
			self.anchor_left = 1
			self.anchor_top = 0
			self.anchor_right = 1
			self.anchor_bottom = 1
			
			_property = _property_x
			_call_open = Callable(self, "_right_open_coords")
			_call_close = Callable(self, "_right_close_coords")
		DrawerPlacement.TOP:
			self.anchor_left = 0
			self.anchor_top = 0
			self.anchor_right = 1
			self.anchor_bottom = 0
			
			_property = _property_y
			_call_open = Callable(self, "_top_open_coords")
			_call_close = Callable(self, "_top_close_coords")
		DrawerPlacement.BOTTOM:
			self.anchor_left = 0
			self.anchor_top = 1
			self.anchor_right = 1
			self.anchor_bottom = 1
			
			_property = _property_y
			_call_open = Callable(self, "_bottom_open_coords")
			_call_close = Callable(self, "_bottom_close_coords")
	
	get_window().size_changed.connect(_on_window_resized)
	_on_window_resized()

#region DrawerControls
##Toggle to open or close the drawer depending on it's current position
func toggle() -> void: 
	var value: float = 0
	
	is_open = !is_open
	if is_open:
		#Open Drawer
		value = _call_open.call()
	else:
		#Close Drawer
		value = _call_close.call()
	
	_move_drawer(_property, value)
	
##Checks if the Drawer is open, if true it closes it.
func close()-> void:
	if is_open:
		is_open = false
		var value: float = _call_close.call()
		_move_drawer(_property, value)
#endregion

#region Drawer resize and animation
func _on_window_resized() -> void:
	drawer.size.x = get_drawer_width()
	drawer.size.y = get_drawer_height()
	
	if drawer_placement == DrawerPlacement.LEFT or drawer_placement == DrawerPlacement.RIGHT:
		# Vertical Position from 0(top) to drawers top side
		var vertical_free_space = get_window().size.y - get_drawer_height()
		drawer.position.y = vertical_free_space * drawer_vertical_anchor
		
		if is_open:
			#Set Open Position
			drawer.position.x = _call_open.call()
		else:
			#Set Closed Position
			drawer.position.x = _call_close.call()
	
	if drawer_placement == DrawerPlacement.TOP or drawer_placement == DrawerPlacement.BOTTOM:
		# Horizontal Position from 0(left) to the drawers left side
		var horizontal_free_space = get_window().size.x - get_drawer_width()
		drawer.position.x = horizontal_free_space * drawer_horizontal_anchor
	
		if is_open:
			#Set Open Position
			drawer.position.y = _call_open.call()
		else:
			#Set Closed Position
			drawer.position.y = _call_close.call()

func _move_drawer(property: String, value: float) -> void:
	var tween: Tween = create_tween()
	
	tween.tween_property(drawer, property, value, animation_time)\
	.set_trans(Tween.TRANS_QUAD)\
	.set_ease(Tween.EASE_OUT)
#endregion

#region Get Drawer Size
func get_drawer_width() -> float:
	return get_window().size.x * drawer_width_ratio

func get_drawer_height() -> float:
	return get_window().size.y * drawer_height_ratio
#endregion

#region DrawerPlacementFunctions
#Left
func _left_open_coords() -> float:
	return 0.0

func _left_close_coords() -> float:
	return -get_drawer_width()
	
#Right
func _right_open_coords() -> float:
	return get_window().size.x - get_drawer_width()

func _right_close_coords() -> float:
	return get_window().size.x

#Top
func _top_open_coords() -> float:
	return 0.0

func _top_close_coords() -> float:
	return -get_window().size.y

#Bottom
func _bottom_open_coords() -> float:
	return get_window().size.y - get_drawer_height()

func _bottom_close_coords() -> float:
	return get_window().size.y

#endregion

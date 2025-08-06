@tool
class_name Vector2InspectorPlugin
extends EditorInspectorPlugin

func _can_handle(object):
	# Accepts all objects, but we filter inside _parse_property
	return true


func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide):
	if type == TYPE_VECTOR2:
		var editor = Vector2EditorProperty.new()
		editor.setup(object, name)
		add_property_editor(name, editor)
		return true  # prevent the default Vector2 editor from appearing
	return false


class Vector2EditorProperty:
	extends EditorProperty

	var target_object: Object
	var target_property: String

	func setup(obj: Object, prop_name: String):
		target_object = obj
		target_property = prop_name
		var drawer = Vector2Drawer.new()
		add_child(drawer)
		drawer.custom_minimum_size = Vector2(120, 120)
		drawer.property_changed.connect(_on_drawer_property_changed)

	func _on_drawer_property_changed(new_value: Vector2):
		emit_changed(target_property, new_value)


class Vector2Drawer:
	extends Control
	signal property_changed(new_value: Vector2)

	var value: Vector2 = Vector2(50, 0)

	func _gui_input(event):
		if event is InputEventMouseButton and event.pressed:
			var center = size / 2
			value = event.position - center
			property_changed.emit(value)
			queue_redraw()

	func _draw():
		var center = size / 2
		var radius = clamp(value.length(), 5, min(size.x, size.y) / 2 - 5)

		draw_circle(center, radius, Color(0.3, 0.3, 0.3, 0.3))
		draw_line(center, center + value, Color(1, 0, 0), 2.0)
		draw_circle(center + value, 4, Color.RED)

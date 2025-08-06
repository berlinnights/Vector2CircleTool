@tool
extends EditorPlugin


@onready var inspector_plugin: Vector2InspectorPlugin #= load("res://addons/vector2_circle_inspector_tool/vector2_circle_tool.gd")

func _enter_tree():
	inspector_plugin = Vector2InspectorPlugin.new()
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)

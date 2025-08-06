@tool
extends EditorPlugin


@onready var inspector_plugin: Vector2InspectorPlugin

func _enter_tree():
	inspector_plugin = Vector2InspectorPlugin.new()
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)

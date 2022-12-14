extends Node

class Segment:
	var name: String
	var children: Array = []
	var visibility: bool
	var node: Node
	
	func _init(node: Node):
		self.node = node
		self.name = node.name
		self.visibility = node.visible
		pass

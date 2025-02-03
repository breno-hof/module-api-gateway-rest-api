locals {
	is_http			= var.protocol_type == "HTTP"
	is_websocket	= var.protocol_type == "WEBSOCKET"
}
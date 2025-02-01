variable "aws_region" {
	description		= "The AWS region to deploy resources"
	type			= string
	default			= "us-east-1"
}

variable "apigateway_v2_name" {
	description		= "The AWS API Gateway V2 name"
	type			= string
}

variable "apigateway_v2_protocol_type" {
	description		= "The AWS API Gateway V2 protocol type (HTTP or WEBSOCKET)"
	type			= string
	default			= "HTTP"
}

variable "apigateway_v2_route_selection_expression" {
	description		= "The AWS API Gateway V2 websocket route selection expression"
	type			= string
	default			=  "$request.body.action"
}

variable "apigateway_v2_websocket_identity_sources" {
	description		= "The AWS API Gateway V2 websocket identity sources"
	type			= list(string)
	default			= null
}

variable "apigateway_v2_authorizer_name" {
	description		= "The AWS API Gateway V2 authorizer name"
	type			= string
}

variable "use_jwt_authorizer" {
	description 	= "JWT configuration settings"
	type 			= object({
		audience 	= list(string)
		issuer   	= string
	})
	default 		= null
}

variable "openapi_file_path" {
	description		= "The AWS API Gateway V2 openapi filename"
	type			= string
	default			= "openapi.json"
}

variable "apigateway_v2_stage_name" {
	description		= "The AWS API Gateway V2 stage name"
	type			= string
}

variable "apigateway_v2_vpc_link_name" {
	description		= "The AWS API Gateway V2 vpc link name"
	type			= string
}

variable "security_groups_ids" {
	description		= "The AWS API Gateway V2 vpc link name"
	type			= set(string)
}

variable "subnet_ids" {
	description		= "The AWS API Gateway V2 vpc link name"
	type			= set(string)
}

variable "create_vpc_link" {
	description		= "Flag to determine if a VPC Link should be created"
	type			= bool
	default			= false
}

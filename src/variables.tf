variable "tags" {
	description					= "A mapping of tags to assign to API gateway resources"
	type						= map(string)
	default						= {}
}

variable "name" {
	description					= "The AWS API Gateway V2 name"
	type						= string
}

variable "route_selection_expression" {
	description					= "The AWS API Gateway V2 websocket route selection expression"
	type						= string
	default						= "$request.body.action"
}

variable "api_key_selection_expression" {
	description					= "The AWS API Gateway V2 websocket api key selection expression"
	type						= string
	default						= null
}

variable "openapi_file_path" {
	description					= "The AWS API Gateway V2 openapi filename"
	type						= string
}

variable "cors_configuration" {
	description					= "The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs"
	type = object({
		allow_credentials		= optional(bool)
		allow_headers			= optional(list(string))
		allow_methods			= optional(list(string))
		allow_origins			= optional(list(string))
		expose_headers			= optional(list(string), [])
		max_age					= optional(number)
	})
	default						= null
}

variable "credentials_arn" {
	description					= "Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs"
	type						= string
	default						= null
}

variable "description" {
	description					= "The description of the API. Must be less than or equal to 1024 characters in length"
	type						= string
	default						= null
}

variable "protocol_type" {
	description					= "The AWS API Gateway V2 protocol type (HTTP or WEBSOCKET)"
	type						= string
	default						= "HTTP"
}

variable "disable_execute_api_endpoint" {
	description					= "Whether clients can invoke the API by using the default execute-api endpoint. By default, clients can invoke the API with the default `{api_id}.execute-api.{region}.amazonaws.com endpoint`. To require that clients use a custom domain name to invoke the API, disable the default endpoint"
	type						= bool
	default						= false
}

variable "fail_on_warnings" {
	description					= "Whether warnings should return an error while API Gateway is creating or updating the resource using an OpenAPI specification. Defaults to `false`. Applicable for HTTP APIs"
	type						= bool
	default						= null
}

variable "route_key" {
	description					= "Part of quick create. Specifies any route key. Applicable for HTTP APIs"
	type						= string
	default						= null
}

variable "target" {
	description					= "Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs"
	type						= string
	default						= null
}

variable "api_version" {
	description					= "A version identifier for the API. Must be between 1 and 64 characters in length"
	type						= string
	default						= null
}

variable "authorizer" {
	description					= "Map of API gateway authorizers to create"
	type						= object({
		credentials_arn			= optional(string)
		payload_format_version	= optional(string)
		result_ttl_in_seconds	= optional(number)
		type					= optional(string, "REQUEST")
		uri						= optional(string)
		enable_simple_responses	= optional(bool)
		identity_sources		= optional(list(string))
		jwt_configuration		= optional(object({
			audience			= optional(list(string))
			issuer				= optional(string)
		}))
	})
	default						= {}
}

variable "create_stage" {
	description					= "Whether to create default stage"
	type						= bool
	default						= true
}

variable "stage_client_certificate_id" {
	description					= "The identifier of a client certificate for the stage. Use the `aws_api_gateway_client_certificate` resource to configure a client certificate. Supported only for WebSocket APIs"
	type						= string
	default						= null
}

variable "stage_description" {
	description					= "The description for the stage. Must be less than or equal to 1024 characters in length"
	type						= string
	default						= null
}

variable "stage_name" {
	description					= "The name of the stage. Must be between 1 and 128 characters in length"
	type						= string
	default						= "$default"
}

variable "stage_variables" {
	description					= "A map that defines the stage variables for the stage"
	type						= map(string)
	default						= {}
}

variable "deploy_stage" {
	description					= "Whether to deploy the stage. `HTTP` APIs are auto-deployed by default"
	type						= bool
	default						= true
}

variable "security_groups_ids" {
	description					= "The AWS API Gateway V2 vpc link name"
	type						= set(string)
}

variable "subnet_ids" {
	description					= "The AWS API Gateway V2 vpc link name"
	type						= set(string)
}

variable "create_vpc_link" {
	description					= "Flag to determine if a VPC Link should be created"
	type						= bool
	default						= false
}

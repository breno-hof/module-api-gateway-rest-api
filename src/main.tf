resource "aws_apigatewayv2_api" "this" {
	name										= var.name

	api_key_selection_expression				= local.is_websocket ? var.api_key_selection_expression : null
	route_selection_expression					= local.is_websocket ? var.route_selection_expression : null
	
	body 										= file("${var.openapi_file_path}")

	dynamic "cors_configuration" {
    	for_each = local.is_http && var.cors_configuration != null ? [var.cors_configuration] : []

    	content {
			allow_credentials 					= cors_configuration.value.allow_credentials
			allow_headers						= cors_configuration.value.allow_headers
			allow_methods						= cors_configuration.value.allow_methods
			allow_origins						= cors_configuration.value.allow_origins
			expose_headers						= cors_configuration.value.expose_headers
			max_age								= cors_configuration.value.max_age
		}
	}

	credentials_arn								= local.is_http ? var.credentials_arn : null
	description									= var.description
	protocol_type								= var.protocol_type
	
	# disable_execute_api_endpoint 				= local.is_http && var.create_domain_name ? true : var.disable_execute_api_endpoint
	disable_execute_api_endpoint 				= var.disable_execute_api_endpoint
	fail_on_warnings							= local.is_http ? var.fail_on_warnings : null
	route_key									= local.is_http ? var.route_key : null
	target										= local.is_http ? var.target : null
	version										= var.api_version

	tags										= var.tags
}

resource "aws_apigatewayv2_authorizer" "this" {
	api_id										= aws_apigatewayv2_api.this.id

	name										= "${var.name}-authorizer"
	authorizer_credentials_arn					= var.authorizer.credentials_arn
	authorizer_payload_format_version			= var.authorizer.payload_format_version
	authorizer_result_ttl_in_seconds			= var.authorizer.result_ttl_in_seconds
	authorizer_type								= var.authorizer.type
	authorizer_uri								= var.authorizer.uri
	enable_simple_responses						= var.authroizer.enable_simple_responses
	identity_sources							= var.authorizer.identity_sources

	dynamic "jwt_configuration" {
		for_each								= var.authorizer.jwt_configuration != null ? [var.authorizer.jwt_configuration] : []
		content {
			audience							= var.authorizer.jwt_configuration.audience
			issuer								= var.authorizer.jwt_configuration.issuer
		}
	}

	depends_on									= [
		aws_apigatewayv2_api.this
	]
}

resource "aws_apigatewayv2_deployment" "this" {
	api_id						= aws_apigatewayv2_api.this.id
	
	lifecycle {
		create_before_destroy	= true
	}

	depends_on					= [
		aws_apigatewayv2_api.this
	]
}

resource "aws_apigatewayv2_stage" "this" {
	api_id						= aws_apigatewayv2_api.this.id
	name						= var.apigateway_v2_stage_name
	deployment_id				= aws_apigatewayv2_deployment.this.id

	depends_on					= [
		aws_apigatewayv2_api.this,
		aws_apigatewayv2_deployment.this
	]
}

resource "aws_apigatewayv2_vpc_link" "this" {
	count						= var.create_vpc_link ? 1 : 0
	name						= var.apigateway_v2_vpc_link_name
	security_group_ids			= var.security_groups_ids
	subnet_ids					= var.subnet_ids
}
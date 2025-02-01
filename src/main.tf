resource "aws_apigatewayv2_api" "this" {
	name						= var.apigateway_v2_name
	protocol_type				= var.apigateway_v2_protocol_type
	route_selection_expression	= var.apigateway_v2_protocol_type == "WEBSOCKET" ? var.apigateway_v2_route_selection_expression : null
	body = file("${path.module}/${var.openapi_file_path}")
}

resource "aws_apigatewayv2_authorizer" "this" {
	api_id						= aws_apigatewayv2_api.this.id
	name						= var.apigateway_v2_authorizer_name
	authorizer_type				= var.use_jwt_authorizer != null ? "JWT" : "REQUEST"
	identity_sources			= var.apigateway_v2_protocol_type == "HTTP" ? ["$request.header.Authorization"] : var.apigateway_v2_websocket_identity_sources
	authorizer_payload_format_version = "2.0"

	dynamic "jwt_configuration" {
		for_each				= var.use_jwt_authorizer != null ? [1] : []
		content {
			audience			= var.use_jwt_authorizer.audience
			issuer				= var.use_jwt_authorizer.issuer
		}
	}
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
}

resource "aws_apigatewayv2_vpc_link" "this" {
	count						= var.create_vpc_link ? 1 : 0
	name						= var.apigateway_v2_vpc_link_name
	security_group_ids			= var.security_groups_ids
	subnet_ids					= var.subnet_ids
}
output "aws_apigatewayv2_vpc_link_id" {
	description	= "ID of the API Gateway VPC Link"
	value		= var.create_vpc_link ? aws_apigatewayv2_vpc_link.this[0].id : null
}

output "aws_apigatewayv2_stage_id" {
	description	= "ID of the API Gateway Stage"
	value		= aws_apigatewayv2_stage.this.id
}

output "aws_apigatewayv2_deployment_id" {
	description	= "ID of the API Gateway Deployment"
	value		= aws_apigatewayv2_deployment.this.id
}

output "aws_apigatewayv2_authorizer_id" {
	description	= "ID of the API Gateway Authorizer"
	value		= aws_apigatewayv2_authorizer.this.id
}

output "aws_apigatewayv2_api_id" {
	description	= "ID of the API Gateway"
	value		= aws_apigatewayv2_api.this.id
}

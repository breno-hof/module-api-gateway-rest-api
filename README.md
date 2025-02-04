# AWS API Gateway V2 Terraform Module

This Terraform module provisions an AWS API Gateway V2 (HTTP or WebSocket) along with associated resources such as authorizers, VPC links, and routes.

## Usage

```hcl
locals {
	name				= "pool-monitoring"
	openapi_file_path	= "${path.module}/openapi.yaml"

	tags				= {
		Application		= local.name,
		GitHubRepo		= "pool-monitoring-api-gateway"
	}
}

module "apigateway_v2" {
	source = "github.com/breno-hof/module-api-gateway-rest-api//src?ref=1.0.0"

	name					= "${local.name}-api-gateway-v2"
	openapi_file_path		= local.openapi_file_path

	cors_configuration		= {
		allow_headers		= ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
		allow_methods		= ["*"]
		allow_origins		= ["*"]
	}

	description				= "My awesome HTTP API Gateway"
	fail_on_warnings		= false

	# authorizer = {
	# 	authorizer_type		= "JWT"
	# 	identity_sources	= ["$request.header.Authorization"]
	# 	name				= "cognito"
	# 	jwt_configuration	= {
	# 		audience		= ["d6a38afd-45d6-4874-d1aa-3c5c558aqcc2"]
	# 		issuer			= "https://${aws_cognito_user_pool.this.endpoint}"
	# 	}
	# }
	
	tags = local.tags
}
```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `tags` | `map(string)` | `{}` | A mapping of tags to assign to API gateway resources. |
| `name` | `string` | N/A | The AWS API Gateway V2 name. |
| `protocol_type` | `string` | `HTTP` | The AWS API Gateway V2 protocol type (`HTTP` or `WEBSOCKET`). |
| `api_key_selection_expression` | `string` | `null` | The AWS API Gateway V2 websocket api key selection expression. |
| `route_selection_expression` | `string` | `"$request.body.action"` | The AWS API Gateway V2 WebSocket route selection expression. |
| `cors_configuration` | `object({allow_credentials = optional(bool) allow_headers = optional(list(string)) allow_methods = optional(list(string)) allow_origins = optional(list(string)) expose_headers = optional(list(string), []) max_age = optional(number)})` | `null` | The cross-origin resource sharing (CORS) configuration. Applicable for HTTP APIs. |
| `credentials_arn` | `string` | `null` | Part of quick create. Specifies any credentials required for the integration. Applicable for HTTP APIs. |
| `description` | `string` | `null` | JWT configuration settings, including audience and issuer. |
| `openapi_file_path` | `string` | N/A | The AWS API Gateway V2 OpenAPI specification file path. |
| `stage_name` | `string` | `dev` | The AWS API Gateway V2 stage name. |
| `stage_description` | `string` | `null` | The description for the stage. Must be less than or equal to 1024 characters in length. |
| `route_key` | `string` | `null` | Part of quick create. Specifies any route key. Applicable for HTTP APIs. |
| `target` | `string` | `null` | Part of quick create. Quick create produces an API with an integration, a default catch-all route, and a default stage which is configured to automatically deploy changes. For HTTP integrations, specify a fully qualified URL. For Lambda integrations, specify a function ARN. The type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. Applicable for HTTP APIs. |
| `authorizer` | `object({credentials_arn = optional(string) payload_format_version	= optional(string) result_ttl_in_seconds = optional(number) type = optional(string, "REQUEST") uri = optional(string) enable_simple_responses	= optional(bool) identity_sources		= optional(list(string)) jwt_configuration = optional(object({ audience = optional(list(string)) issuer = optional(string)})) })` | `{}` | Map of API gateway authorizers to create. |
| `api_version` | `string` | `null` | A version identifier for the API. Must be between 1 and 64 characters in length. |
| `stage_client_certificate_id` | `string` | `null` | The identifier of a client certificate for the stage. Use the `aws_api_gateway_client_certificate` resource to configure a client certificate. Supported only for WebSocket APIs. |
| `security_groups_ids` | `set(string)` | N/A | The security group IDs associated with the VPC Link. |
| `subnet_ids` | `set(string)` | N/A | The subnet IDs associated with the VPC Link. |
| `create_vpc_link` | `bool` | `false` | Flag to determine if a VPC Link should be created. |
| `disable_execute_api_endpoint` | `bool` | `false` | Whether clients can invoke the API by using the default execute-api endpoint. By default, clients can invoke the API with the default `{api_id}.execute-api.{region}.amazonaws.com endpoint`. To require that clients use a custom domain name to invoke the API, disable the default endpoint. |
| `fail_on_warnings` | `bool` | `null` | Whether warnings should return an error while API Gateway is creating or updating the resource using an OpenAPI specification. Defaults to `false`. Applicable for HTTP APIs. |
| `deploy_stage` | `bool` | `true` | Whether to deploy the stage. `HTTP` APIs are auto-deployed by default. |
| `create_stage` | `bool` | `true` | WWhether to create default stage. |
| `stage_variables` | `map(string)` | `{}` | A map that defines the stage variables for the stage. |

## Outputs

| Name | Description |
|------|-------------|
| `aws_apigatewayv2_api_id` | ID of the API Gateway. |
| `aws_apigatewayv2_stage_id` | ID of the API Gateway Stage. |
| `aws_apigatewayv2_deployment_id` | ID of the API Gateway Deployment. |
| `aws_apigatewayv2_authorizer_id` | ID of the API Gateway Authorizer. |
| `aws_apigatewayv2_vpc_link_id` | ID of the API Gateway VPC Link (if created). |

## Requirements

- Terraform >= 0.12
- AWS Provider >= 3.0

## License

This project is licensed under the GNU General Public License - see the LICENSE file for details.


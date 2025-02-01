# module-api-gateway-rest-api
A Terraform module to provision an AWS API Gateway REST API.

# AWS API Gateway V2 Terraform Module

This Terraform module provisions an AWS API Gateway V2 (HTTP or WebSocket) along with associated resources such as authorizers, VPC links, and routes.

## Usage

```hcl
module "apigateway_v2" {
  source = "./modules/apigateway_v2"

  aws_region                             = "us-east-1"
  apigateway_v2_name                     = "my-api-gateway"
  apigateway_v2_protocol_type            = "HTTP"
  apigateway_v2_route_selection_expression = "$request.body.action"
  apigateway_v2_stage_name               = "dev"
  apigateway_v2_vpc_link_name            = "my-vpc-link"
  security_groups_ids                    = ["sg-0123456789abcdef0"]
  subnet_ids                             = ["subnet-0123456789abcdef0", "subnet-abcdef0123456789"]
  create_vpc_link                        = true

  use_jwt_authorizer = {
    audience = ["my-audience"]
    issuer   = "https://issuer.example.com"
  }
}
```

## Variables

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `aws_region` | `string` | `us-east-1` | The AWS region to deploy resources. |
| `apigateway_v2_name` | `string` | N/A | The AWS API Gateway V2 name. |
| `apigateway_v2_protocol_type` | `string` | `HTTP` | The AWS API Gateway V2 protocol type (`HTTP` or `WEBSOCKET`). |
| `apigateway_v2_route_selection_expression` | `string` | `"$request.body.action"` | The AWS API Gateway V2 WebSocket route selection expression. |
| `apigateway_v2_websocket_identity_sources` | `list(string)` | `null` | The AWS API Gateway V2 WebSocket identity sources. |
| `apigateway_v2_authorizer_name` | `string` | N/A | The AWS API Gateway V2 authorizer name. |
| `use_jwt_authorizer` | `object({ audience = list(string), issuer = string })` | `null` | JWT configuration settings, including audience and issuer. |
| `openapi_file_path` | `string` | N/A | The AWS API Gateway V2 OpenAPI specification file path. |
| `apigateway_v2_stage_name` | `string` | N/A | The AWS API Gateway V2 stage name. |
| `apigateway_v2_vpc_link_name` | `string` | N/A | The AWS API Gateway V2 VPC Link name. |
| `security_groups_ids` | `set(string)` | N/A | The security group IDs associated with the VPC Link. |
| `subnet_ids` | `set(string)` | N/A | The subnet IDs associated with the VPC Link. |
| `create_vpc_link` | `bool` | `false` | Flag to determine if a VPC Link should be created. |

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


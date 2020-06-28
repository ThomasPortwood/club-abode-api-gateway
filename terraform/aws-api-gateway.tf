resource "aws_apigatewayv2_api" "club-abode-api" {
  name          = "club-abode-api-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_authorizer" "club-abode-auth0-authorizer" {
  api_id           = aws_apigatewayv2_api.club-abode-api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "club-abode-auth0-authorizer"

  jwt_configuration {
    audience = ["https://api.somesoftwareteam.com"]
    issuer   = "https://somesoftwareteam.auth0.com"
  }
}

resource "aws_apigatewayv2_integration" "club-abode-integration" {
  api_id             = aws_apigatewayv2_api.club-abode-api.id
  integration_type   = "HTTP_PROXY"
  integration_method = "POST"
  integration_uri    = "https://e35e00df-graphql-graphql-41d3-2003767172.us-east-1.elb.amazonaws.com"
}

resource "aws_apigatewayv2_route" "club-abode-route" {
  api_id             = aws_apigatewayv2_api.club-abode-api.id
  authorization_type = "JWT"
  route_key          = "/graphql"
  operation_name     = "POST"
  authorizer_id      = aws_apigatewayv2_authorizer.club-abode-auth0-authorizer.id
}

resource "aws_apigatewayv2_stage" "club-abode-stage-prod" {
  api_id = aws_apigatewayv2_api.club-abode-api.id
  name   = "prod"
}
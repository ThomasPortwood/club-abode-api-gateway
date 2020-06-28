resource "aws_apigatewayv2_api" "club-abode-api" {
  name                       = "club-abode-api-gateway"
  protocol_type              = "HTTP"
}

resource "aws_apigatewayv2_authorizer" "example" {
  api_id           = aws_apigatewayv2_api.club-abode-api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "example-authorizer"

  jwt_configuration {
    audience = ["https://api.somesoftwareteam.com"]
    issuer   = "https://somesoftwareteam.auth0.com"
  }
}

resource "aws_apigatewayv2_route" "club-abode-route" {
  api_id    = aws_apigatewayv2_api.club-abode-api.id
  route_key = "$default"
}


resource "aws_apigatewayv2_deployment" "club-abode-deployment" {
  api_id      = aws_apigatewayv2_route.club-abode-route.api_id
  description = "Club Abode API Gateway deployment"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_apigatewayv2_stage" "club-abode-stage" {
  api_id = aws_apigatewayv2_api.club-abode-api.id
  name   = "example-stage"
}


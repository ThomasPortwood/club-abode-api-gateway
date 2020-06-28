resource "aws_apigatewayv2_api" "club-abode-api" {
  name          = "club-abode-api-gateway"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_authorizer" "club-abode-auth0-authorizer" {
  api_id           = aws_apigatewayv2_api.club-abode-api.id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "example-authorizer"

  jwt_configuration {
    audience = ["https://api.somesoftwareteam.com"]
    issuer   = "https://somesoftwareteam.auth0.com"
  }
}

resource "aws_apigatewayv2_integration" "example" {
  api_id           = aws_apigatewayv2_api.club-abode-api.id
  integration_type = "AWS"
  integration_method = "ANY"
}


resource "aws_apigatewayv2_route" "club-abode-route" {
  api_id        = aws_apigatewayv2_api.club-abode-api.id
  route_key     = "$default"
  authorizer_id = aws_apigatewayv2_authorizer.club-abode-auth0-authorizer.id

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


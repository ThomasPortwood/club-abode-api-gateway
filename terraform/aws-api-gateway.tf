resource "aws_apigatewayv2_api" "club-abode-api-gateway" {
  name                       = "club-abode-api-gateway"
  protocol_type              = "HTTP"
  route_selection_expression = "$request.body.action"
}

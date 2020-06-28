resource "aws_api_gateway_rest_api" "club-abode-gateway" {
  name        = "Club-Abode"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "club-abode-resource" {
  rest_api_id = aws_api_gateway_rest_api.club-abode-gateway.id
  parent_id   = aws_api_gateway_rest_api.club-abode-gateway.root_resource_id
  path_part   = "rest"
}

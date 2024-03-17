resource "aws_api_gateway_rest_api" "foodieflow" {
  name        = "foodieflow"
  description = "API for foodieflow application"
}

# Crie uma variável para armazenar o conteúdo do diretório de rotas
data "archive_file" "routes" {
  type        = "zip"
  source_dir  = "${path.module}/Routes"
  output_path = "${path.module}/routes.zip"
}

# Crie um recurso de recurso para importar as rotas
resource "aws_api_gateway_resource" "routes" {
  rest_api_id = aws_api_gateway_rest_api.foodieflow.id
  parent_id   = aws_api_gateway_rest_api.foodieflow.root_resource_id
  path_part   = "Routes"
}

# Crie uma integração de lambda para importar as rotas
resource "aws_api_gateway_integration" "routes_integration" {
  rest_api_id = aws_api_gateway_rest_api.foodieflow.id
  resource_id = aws_api_gateway_resource.routes.id
  http_method = "POST"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:importRoutes/invocations"
}

# Anexe um método à rota de recursos para importar as rotas
resource "aws_api_gateway_method" "routes_method" {
  rest_api_id   = aws_api_gateway_rest_api.foodieflow.id
  resource_id   = aws_api_gateway_resource.routes.id
  http_method   = "POST"
  authorization = "NONE"
}

# Associe a integração ao método
resource "aws_api_gateway_integration_response" "routes_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.foodieflow.id
  resource_id = aws_api_gateway_resource.routes.id
  http_method = aws_api_gateway_method.routes_method.http_method
  status_code = aws_api_gateway_method.routes_method.http_method == "POST" ? "200" : "400"

  response_templates = {
    "application/json" = jsonencode({
      message = "Routes imported successfully"
    })
  }
}

# Crie uma saída para a URL da API Gateway
output "api_gateway_endpoint" {
  value = aws_api_gateway_rest_api.foodieflow.invoke_url
}
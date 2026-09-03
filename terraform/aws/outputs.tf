# Outputs são valores exibidos no terminal após o "terraform apply".
# Servem para expor informações do recurso criado (nome, ARN, região, etc.) sem precisar entrar no console da AWS.

# Nome do bucket S3 criado.
output "bucket_name" {
    description = "Nome do bucket S3 provisionado"
    value = aws_s3_bucket.bucket-aponti.bucket
}

# ARN (identificador único) do bucket.
output "bucket_arn" {
    description = "ARN do bucket S3 provisionado"
    value = aws_s3_bucket.bucket-aponti.arn
}

# ID da conta AWS utilizada, que é obtido via data source (data.tf).
output "account_id" {
    description = "ID da conta AWS em que o recurso foi criado"
    value = data.aws_caller_identity.current.account_id
}

# Região usada pelo provider.
output "region_used" {
    description = "Região da AWS em que os recursos foram provisionados"
    value = data.aws_region.current.name
}

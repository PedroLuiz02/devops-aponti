# Outputs são valores exibidos no terminal após o "terraform apply".
# Servem para expor rapidamente informações do recurso criado (nome, URL,
# região, etc.) sem precisar entrar no console do GCP.

# Nome do bucket criado.
output "bucket_name" {
    description = "Nome do bucket provisionado"
    value       = google_storage_bucket.bucket-aponti.name
}

# URL do bucket (equivalente ao ARN da AWS), usado para referenciar o
# recurso em outras configurações.
output "bucket_url" {
    description = "URL do bucket provisionado"
    value       = google_storage_bucket.bucket-aponti.url
}

# Número do projeto GCP utilizado, obtido via data source (data.tf).
output "project_number" {
    description = "Número do projeto GCP em que o recurso foi criado"
    value       = data.google_project.current.number
}

# Região efetivamente usada pelo bucket.
output "region_used" {
    description = "Região do GCP em que os recursos foram provisionados"
    value       = google_storage_bucket.bucket-aponti.location
}

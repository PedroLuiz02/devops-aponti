# As variáveis definem um parâmetro e referenciam elas em outras partes do código.

# Define o ID do projeto no Google Cloud.
variable "project_id" {
    type        = string
    description = "o ID do projeto no Google Cloud onde os recursos serão criados"
}

# Define a região do serviço.
variable "region" {
    type        = string
    description = "a região em que o serviço vai subir"
    default     = "southamerica-east1"
}

# Define o ambiente que vai provisionar o bucket.
variable "environment" {
  type        = string
  description = "Define o ambiente no qual o bucket está sendo provisionado, utilizado como label para identificação do recurso."
  default     = "Dev"
}

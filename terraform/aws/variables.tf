# As variáveis definem um parâmetro e referenciam elas em outras partes do código.

# Define a região do serviço.
variable "region" {
    type = string
    description = "a região em que o serviço vai subir"
    default = "sa-east-1"
}

# Define o ambiente que vai provisionar o bucket.
variable "environment" {
  type        = string
  description = "Define o ambiente no qual o bucket está sendo provisionado, utilizado como tag para identificação do recurso."
  default     = "Dev"
}
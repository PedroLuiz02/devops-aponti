# Data sources servem para CONSULTAR informações que já existem no provedor (GCP), sem criar nada novo. 
# Usada para confirmar/ler dados do projeto, sem precisar "hardcodar" valores.

# Consulta informações do projeto configurado no provider. Equivalente ao "aws_caller_identity" da AWS.
data "google_project" "current" {
    project_id = var.project_id
}

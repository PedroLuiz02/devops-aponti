# Data sources servem para consultar informações que já existem no provedor, sem criar nada.
# E usada para confirmar/ler dados da conta e da região, sem precisar "hardcodar" valores.

# Consulta informações da conta AWS autenticada no momento (ex: account id). Usada, por exemplo, para compor nomes de recursos únicos por conta.
data "aws_caller_identity" "current" {}

# Consulta informações da região configurada no provider.
data "aws_region" "current" {}
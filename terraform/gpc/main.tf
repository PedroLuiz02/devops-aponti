# Ferramenta IAC Infraestrutura como Código (IaC) que serve para provisionar, alterar e versionar recursos de TI de forma automatizada e segura.
terraform {
    # Declara quais provedores o terraform requer, para que possa instalá-los e utilizá-los.
    required_providers {
        google = {
            source  = "hashicorp/google"
            version = "~> 5.0"
        }
    }
}

# São plugins para interagir com provedores de nuvem, provedores de SaaS e outras APIs.
provider "google" {
    #Opções de configuração
    project = var.project_id
    region  = var.region
}

# Define um componente de infraestrutura real que será criado, modificado ou destruído no seu provedor de nuvem.
# Equivalente direto ao bucket S3 da AWS.
resource "google_storage_bucket" "bucket-aponti" {
    name     = "bucket-aponti-gcp" # precisa ser único globalmente em todo o GCP
    location = var.region

    # Servem para organizar, monitorar custos e identificar recursos na nuvem por meio de pares de chave-valor. Além de evitar repetir as mesmas tags em dezenas de recursos.
    # No GCP, esse conceito equivalente às "tags" da AWS chama-se "labels".
    labels = {
        name        = "my-bucket"
        environment = var.environment
    }
}

# Ferramenta IAC Infraestrutura como Código (IaC) que serve para provisionar, alterar e versionar 
# recursos de TI de forma automatizada e segura.
terraform {
    # Declara quais provedores o terraform requer, para que possa instalá-los e utilizá-los.
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "6.61.0"
        }
    }
}

# São plugins para interagir com provedores de nuvem, provedores de SaaS e outras APIs. 
provider "aws" {
    #Opções de configuração
    region = var.region
}

# Define um componente de infraestrutura real que será criado, modificado ou destruído no seu provedor de nuvem.
resource "aws_s3_bucket" "bucket-aponti" {
    bucket = "bucket-aponti"

    # Servem para organizar, monitorar custos e identificar recursos na nuvem por meio de pares de chave-valor. 
    # Além de evitar repetir as mesmas tags em dezenas de recursos.
    tags = {
        Name = "My Bucket"
        Environment = var.environment
    }
}
# Atividade Terraform - Provisionamento Multi-Cloud

Projeto desenvolvido em sala para praticar Infraestrutura como Código (IaC) utilizando Terraform, provisionando um recurso de armazenamento equivalente em diferentes provedores de nuvem.

## Estrutura de pastas

O repositório está organizado em uma pasta por provedor de nuvem, cada uma com seu próprio conjunto de arquivos Terraform independente:

```
devops-aponti/
├── .gitignore
├── README.md
├── aws/
│   └── README.md
├── azure/
│   └── README.md
└── gcp/
    └── README.md
```

Cada pasta contém os mesmos seis arquivos, seguindo o padrão definido em sala:

- `main.tf` — provider e recurso principal
- `data.tf` — data sources (consultas a informações já existentes no provedor)
- `variables.tf` — declaração das variáveis
- `terraform.tfvars` — valores reais atribuídos às variáveis
- `outputs.tf` — informações expostas após o `terraform apply`
- `README.md` — explicação detalhada daquele provedor específico

## Por que pastas separadas em vez de um único projeto?

Cada nuvem tem seu próprio `provider`, suas próprias credenciais de autenticação e seu próprio ciclo de vida de infraestrutura. Separar por pasta permite:

- Rodar `terraform init/plan/apply` de forma independente em cada nuvem, sem misturar estados.
- Deixar claro, para quem for ler o repositório, qual conjunto de arquivos pertence a qual provedor.
- Reaproveitar a mesma lógica (bucket de armazenamento) para comparar como cada nuvem resolve o mesmo problema.

## Equivalência de recursos entre os provedores

| Conceito                    | AWS                                            | Azure                                                          | GCP                          |
|------------------------------|-------------------------------------------------|-----------------------------------------------------------------|-------------------------------|
| Recurso de armazenamento      | `aws_s3_bucket`                                 | `azurerm_storage_account` + `azurerm_storage_container`         | `google_storage_bucket`       |
| Agrupador obrigatório         | não existe                                       | `azurerm_resource_group` (obrigatório antes de qualquer recurso) | projeto GCP (já existe previamente) |
| Pares chave-valor de organização | `tags`                                        | `tags`                                                           | `labels`                       |
| Identidade/conta (data source) | `aws_caller_identity`                          | `azurerm_client_config`                                          | `google_project`               |

## Boas práticas de versionamento (válidas para todo o repositório)

- Um único `.gitignore` na raiz: padrões como `.terraform/` e `*.tfstate` se aplicam automaticamente a todas as subpastas (`aws/`, `azure/`, `gcp/`), sem precisar duplicar o arquivo em cada uma.
- `.terraform/` e arquivos de estado (`*.tfstate`) não devem ser versionados, pois são gerados localmente e podem conter dados sensíveis.
- `.terraform.lock.hcl` **deve** ser versionado em cada pasta, pois garante que todos que executem o projeto utilizem exatamente a mesma versão do provider.

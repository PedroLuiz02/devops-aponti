# Atividade Terraform - Provisionamento de Cloud Storage Bucket (GCP)

Projeto desenvolvido em sala para praticar Infraestrutura como Código (IaC) utilizando Terraform, provisionando um bucket do Cloud Storage no Google Cloud.

## Estrutura do projeto

- `main.tf` — declaração do provider Google e do recurso `google_storage_bucket`.
- `variables.tf` — declaração das variáveis `project_id`, `region` e `environment`.
- `terraform.tfvars` — valores reais atribuídos às variáveis.
- `data.tf` — consulta informações que já existem no projeto GCP (número do projeto), sem criar recursos novos.
- `outputs.tf` — expõe no terminal, após o `apply`, dados do recurso criado (nome do bucket, URL, número do projeto e região usada).
- `.terraform.lock.hcl` — trava as versões dos providers (versionado propositalmente).

## Data Sources e Outputs

O `data.tf` usa um data source para evitar "hardcodar" valores que já existem no provedor:

- `data.google_project.current` — retorna dados do projeto GCP configurado no provider (usado para o `number`, número identificador do projeto). É o equivalente ao `aws_caller_identity` da AWS.

O `outputs.tf` expõe essa informação (e dados do bucket) para consulta rápida no terminal, sem entrar no console do GCP:

- `bucket_name` e `bucket_url` — vêm diretamente do recurso `google_storage_bucket.bucket-aponti`.
- `project_number` — vem do data source acima.
- `region_used` — também vem do próprio recurso do bucket (`location`).

## Processo de conexão com a Cloud (GCP)

Durante o desenvolvimento, o projeto foi estruturado para se conectar ao Google Cloud através do provider oficial `hashicorp/google`, declarado no bloco `terraform { required_providers { } }`.

Para que o Terraform consiga de fato criar recursos no GCP, é necessário fornecer credenciais válidas. As formas mais comuns de autenticação são:

1. **gcloud CLI configurada via terminal** — usando o comando `gcloud auth application-default login`, que abre o navegador para autenticação da conta Google e salva as credenciais localmente.

   Esses dados são salvos em um arquivo de credenciais de aplicação padrão (ADC), geralmente em:
   - `~/.config/gcloud/application_default_credentials.json`

2. **Variável de ambiente apontando para uma Service Account** — definindo `GOOGLE_APPLICATION_CREDENTIALS` com o caminho de um arquivo `.json` de chave de uma Service Account criada no projeto GCP.

3. **Credenciais implícitas da própria infraestrutura GCP** — usada quando o Terraform roda dentro de um recurso do próprio Google Cloud (ex: uma Compute Engine ou Cloud Build) que já possui uma Service Account vinculada (não é o caso deste projeto, já que ele roda localmente).

### Tentativa de execução e erro encontrado

Ao rodar `terraform plan` sem nenhuma conta GCP configurada, se obtém o erro:

```
Error: Attempted to load application default credentials since neither `credentials` nor `access_token`
was set in the provider block. No credentials loaded. To use your gcloud credentials, run
'gcloud auth application-default login'

with provider["registry.terraform.io/hashicorp/google"],
on main.tf line 13, in provider "google":
13: provider "google" {

google: could not find default credentials. See
https://cloud.google.com/docs/authentication/external/set-up-adc for more information
```

Esse erro confirma que, como nenhuma credencial (`credentials`) ou token de acesso (`access_token`) foi definido diretamente no bloco `provider "google"` (linha 13 do `main.tf`), o Terraform tentou automaticamente carregar as **Application Default Credentials (ADC)** — o mecanismo padrão de autenticação do GCP — e não encontrou nenhuma configurada na máquina local. A própria mensagem já indica o comando necessário para resolver (`gcloud auth application-default login`), reforçando o processo de conexão descrito acima.

A validação do projeto foi feita através do comando `terraform validate`, que verifica a **sintaxe e a consistência do código** sem exigir credenciais nem se conectar ao GCP.

O `terraform plan`/`apply` não foram executados de fato por falta de credenciais válidas.

## Boas práticas de versionamento

- `.terraform/` e arquivos de estado (`*.tfstate`) não devem ser versionados, pois são gerados localmente e podem conter dados sensíveis.
- `.terraform.lock.hcl` **deve** ser versionado, pois garante que todos que executem o projeto utilizem exatamente a mesma versão do provider, evitando o problema de "na minha máquina funciona".
- Mesmo quando um `.tfvars` não contém dados sensíveis, é uma prática comum ignorá-lo por padrão e versionar um `terraform.tfvars.example` com valores fictícios, como medida preventiva de segurança. Aqui, especial atenção ao `project_id`, que identifica um projeto real no GCP.
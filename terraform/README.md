# Atividade Terraform - Provisionamento de Bucket S3 (AWS)

Projeto desenvolvido em sala para praticar Infraestrutura como Código (IaC) utilizando Terraform, provisionando um bucket S3 na AWS.

## Estrutura do projeto

- `main.tf` — declaração do provider AWS e do recurso `aws_s3_bucket`.
- `variables.tf` — declaração das variáveis `region` e `environment`.
- `terraform.tfvars` — valores reais atribuídos às variáveis.
- `.terraform.lock.hcl` — trava as versões dos providers (versionado propositalmente).

## Processo de conexão com a Cloud (AWS)

Durante o desenvolvimento, o projeto foi estruturado para se conectar à AWS através do provider oficial `hashicorp/aws`, declarado no bloco `terraform { required_providers { } }`.

Para que o Terraform consiga de fato criar recursos na AWS, é necessário fornecer credenciais válidas. As formas mais comuns de autenticação são:

1. **AWS CLI configurada via terminal** — usando o comando `aws configure`, que solicita interativamente:
   - Access Key ID
   - Secret Access Key
   - Região padrão
   - Formato de saída (ex: json)

   Esses dados são salvos em dois arquivos dentro da pasta oculta `.aws`, na pasta do usuário:
   - `~/.aws/credentials` — guarda as chaves de acesso.
   - `~/.aws/config` — guarda região e formato de saída.

2. **Variáveis de ambiente do sistema** — definindo `AWS_ACCESS_KEY_ID` e `AWS_SECRET_ACCESS_KEY` diretamente no terminal/sessão.

3. **IAM Role** — usada quando o Terraform roda dentro de uma instância EC2 real, que já possui uma role vinculada (não é o caso deste projeto, já que ele roda localmente).

### Tentativa de execução e erro encontrado

Ao rodar `terraform plan` sem nenhuma conta AWS configurada, se obtém o erro:

```
Error: No valid credential sources found
Error: failed to refresh cached credentials, no EC2 IMDS role found...
```

Esse erro confirma que o Terraform tentou localizar credenciais em todas as fontes possíveis (variáveis de ambiente, arquivos `.aws`, role de instância) e não encontrou nenhuma 

A validação do projeto foi feita através do comando `terraform validate`, que verifica a **sintaxe e a consistência do código** sem exigir credenciais nem se conectar à AWS. 

O `terraform plan`/`apply` não foram executados de fato por falta de credenciais válidas.

## Boas práticas de versionamento

- `.terraform/` e arquivos de estado (`*.tfstate`) não devem ser versionados, pois são gerados localmente e podem conter dados sensíveis.
- `.terraform.lock.hcl` **deve** ser versionado, pois garante que todos que executem o projeto utilizem exatamente a mesma versão do provider, evitando o problema de "na minha máquina funciona".
- Mesmo quando um `.tfvars` não contém dados sensíveis, é prática comum ignorá-lo por padrão e versionar um `terraform.tfvars.example` com valores fictícios, como medida preventiva de segurança.
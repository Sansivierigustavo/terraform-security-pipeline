# Terraform Security Pipeline

Pipeline de Infraestrutura como Código (Terraform) com scan de segurança
automatizado (tfsec, checkov, gitleaks) rodando em Jenkins, contra um
ambiente AWS simulado localmente com LocalStack — 100% gratuito, sem
necessidade de conta cloud real.

## Arquitetura

[Notebook - VSCode] [Servidor Linux]
escreve o código --push--> Jenkins (self-hosted)
|
gitleaks / tfsec / checkov
|
terraform apply
|
LocalStack (Docker) <- simula a AWS


## Stack utilizada

- Terraform
- Jenkins (self-hosted, pipeline declarativo)
- LocalStack (simulação local da AWS via Docker)
- tfsec — scan estático de más práticas Terraform
- checkov — scan de compliance (CIS Benchmarks)
- gitleaks — detecção de segredos/credenciais vazadas no código

## Como rodar

```bash
# 1. Suba o LocalStack no servidor
docker run -d --name localstack -p 4566:4566 localstack/localstack

# 2. Rode o Terraform manualmente (fora do Jenkins, para testar)
cd terraform
terraform init
terraform plan

# 3. Ou dispare o job no Jenkins apontando para este repositório
```

## Relatório de Segurança: Antes → Depois

### Antes da correção

(cole aqui a saída do tfsec/checkov com os findings)


### Problemas identificados
- [ ] Bucket S3 com ACL pública (`public-read`)
- [ ] Bloqueio de acesso público desativado
- [ ] Ausência de criptografia em repouso no bucket
- [ ] Ausência de versionamento no bucket
- [ ] Política IAM com permissão total (`Action: "*"`, `Resource: "*"`)

### Depois da correção

(cole aqui a saída após corrigir e rodar novamente)


## Autor

Gustavo Cuebra — [https://www.linkedin.com/in/gustavosansivieri/](#) | [https://github.com/Sansivierigustavo](#)
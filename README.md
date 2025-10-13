# Módulo Terraform - AWS VPC com Flow Logs

Este módulo Terraform cria uma VPC (Virtual Private Cloud) na AWS com suporte opcional para VPC Flow Logs, permitindo monitoramento e análise do tráfego de rede.

## 📋 Funcionalidades

- ✅ Criação de VPC com CIDR block customizável
- ✅ VPC Flow Logs opcionais para monitoramento de tráfego
- ✅ Suporte a múltiplos destinos para logs (S3, CloudWatch Logs)
- ✅ Configuração flexível de tipos de tráfego a serem registrados
- ✅ Sistema de tags personalizáveis

## 🏗️ Estrutura do Módulo

```
devops-terraform-mod-aws-vpc/
├── main.tf          # Recursos principais (VPC e Flow Logs)
├── variables.tf     # Definição das variáveis de entrada
├── outputs.tf       # Valores de saída do módulo
├── README.md        # Documentação do módulo
└── .gitignore       # Arquivos ignorados pelo Git
```

## 📦 Recursos Criados

### 1. VPC (aws_vpc)
- **Recurso**: `aws_vpc.vpc_id`
- **Descrição**: Virtual Private Cloud principal
- **Configurações**: CIDR block e tags personalizáveis

### 2. VPC Flow Logs (aws_flow_log)
- **Recurso**: `aws_flow_log.vpc_flow_log`
- **Descrição**: Logs de tráfego da VPC (opcional)
- **Configurações**: Destino, tipo de tráfego e tags

## 🔧 Variáveis de Entrada

| Variável | Tipo | Obrigatória | Padrão | Descrição |
|----------|------|-------------|--------|-----------|
| `vpc_cidr_block` | `string` | ✅ | - | CIDR block da VPC (ex: "10.0.0.0/16") |
| `enable_flow_log` | `bool` | ✅ | - | Ativa ou desativa os VPC Flow Logs |
| `flow_log_destination_type` | `string` | ❌ | `"s3"` | Tipo de destino: "s3" ou "cloud-watch-logs" |
| `flow_log_traffic_type` | `string` | ✅ | - | Tipo de tráfego: "ALL", "ACCEPT" ou "REJECT" |
| `flow_log_log_destination` | `string` | ✅ | - | ARN do destino dos logs (bucket S3 ou log group) |
| `domain` | `string` | ✅ | - | Domínio/ambiente para nomenclatura dos recursos |
| `tags` | `map(string)` | ❌ | `{}` | Tags personalizadas para os recursos |

## 📤 Saídas (Outputs)

| Output | Tipo | Descrição |
|--------|------|----------|
| `vpc_id` | `string` | ID da VPC criada |

## 🚀 Como Usar

### Exemplo Básico

```hcl
module "vpc" {
  source = "./devops-terraform-mod-aws-vpc"

  vpc_cidr_block              = "10.0.0.0/16"
  enable_flow_log             = true
  flow_log_destination_type   = "s3"
  flow_log_traffic_type       = "ALL"
  flow_log_log_destination    = "arn:aws:s3:::meu-bucket-logs/vpc-flow-logs/"
  domain                      = "producao"

  tags = {
    Environment = "production"
    Project     = "meu-projeto"
    Owner       = "devops-team"
  }
}
```

### Exemplo com CloudWatch Logs

```hcl
module "vpc" {
  source = "./devops-terraform-mod-aws-vpc"

  vpc_cidr_block              = "172.16.0.0/16"
  enable_flow_log             = true
  flow_log_destination_type   = "cloud-watch-logs"
  flow_log_traffic_type       = "REJECT"
  flow_log_log_destination    = "arn:aws:logs:us-east-1:123456789012:log-group:vpc-flow-logs"
  domain                      = "desenvolvimento"

  tags = {
    Environment = "development"
    Project     = "teste-vpc"
  }
}
```

### Exemplo Sem Flow Logs

```hcl
module "vpc" {
  source = "./devops-terraform-mod-aws-vpc"

  vpc_cidr_block              = "192.168.0.0/16"
  enable_flow_log             = false
  flow_log_traffic_type       = "ALL"  # Obrigatório mesmo quando desabilitado
  flow_log_log_destination    = ""      # Pode ser vazio quando desabilitado
  domain                      = "teste"
}
```

## 📋 Pré-requisitos

- **Terraform**: >= 0.12
- **Provider AWS**: Configurado com credenciais adequadas
- **Permissões IAM**: 
  - `ec2:CreateVpc`
  - `ec2:CreateFlowLogs`
  - `ec2:DescribeVpcs`
  - `ec2:DescribeFlowLogs`
  - Permissões para o destino dos logs (S3 ou CloudWatch)

## 🔍 VPC Flow Logs - Detalhes

### Tipos de Tráfego
- **ALL**: Registra todo o tráfego (aceito e rejeitado)
- **ACCEPT**: Registra apenas tráfego aceito
- **REJECT**: Registra apenas tráfego rejeitado

### Destinos Suportados
- **S3**: Armazenamento em bucket S3
  - Formato: `arn:aws:s3:::bucket-name/prefix/`
- **CloudWatch Logs**: Log groups do CloudWatch
  - Formato: `arn:aws:logs:region:account:log-group:log-group-name`

## 🏷️ Nomenclatura de Recursos

O módulo segue o padrão de nomenclatura:
- **Flow Log**: `rm-{domain}-flow-log`

Onde `{domain}` é o valor da variável `domain`.

## 🔧 Personalização

Para personalizar o módulo:

1. **Tags adicionais**: Use a variável `tags` para adicionar metadados
2. **CIDR customizado**: Ajuste `vpc_cidr_block` conforme sua arquitetura
3. **Logs seletivos**: Configure `flow_log_traffic_type` para filtrar logs

## 📚 Referências

- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)
- [VPC Flow Logs Guide](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)

## 🤝 Contribuição

Para contribuir com este módulo:

1. Faça um fork do repositório
2. Crie uma branch para sua feature
3. Implemente as mudanças
4. Teste as alterações
5. Submeta um pull request

---
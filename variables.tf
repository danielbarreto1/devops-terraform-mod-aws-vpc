variable "vpc_cidr_block" {
  type = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags para aplicar nos recursos"
}

variable "enable_flow_log" {
  description = "Ativa os VPC Flow Logs"
  type        = bool
}

variable "flow_log_destination_type" {
  description = "Tipo de destino do flow log: s3 ou cloud-watch-logs"
  type        = string
  default     = "s3"
}

variable "flow_log_traffic_type" {
  description = "Tráfego a ser registrado: ALL, ACCEPT ou REJECT"
  type        = string
}

variable "flow_log_log_destination" {
  description = "Destino dos logs"
  type        = string
}

variable "domain" {
  type = string
}
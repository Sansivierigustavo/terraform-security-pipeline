variable "project_name" {
  description = "Nome do projeto, usado como prefixo dos recursos"
  type        = string
  default     = "terraform-security-pipeline"
}

variable "bucket_name" {
  description = "Nome do bucket S3 (precisa ser único no LocalStack local)"
  type        = string
  default     = "tsp-app-data-bucket"
}
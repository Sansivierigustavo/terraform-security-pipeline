resource "aws_s3_bucket" "app_data" {
  bucket = var.bucket_name
}

# FALHA 1: ACL pública
resource "aws_s3_bucket_acl" "app_data_acl" {
  bucket = aws_s3_bucket.app_data.id
  acl    = "public-read"
}

# FALHA 2: bloqueio de acesso público desativado
resource "aws_s3_bucket_public_access_block" "app_data_block" {
  bucket = aws_s3_bucket.app_data.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# FALHA 3 e 4: sem criptografia e sem versionamento (recursos ausentes de propósito)

resource "aws_iam_role" "app_role" {
  name = "${var.project_name}-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# FALHA 5: permissão total
resource "aws_iam_policy" "app_policy" {
  name = "${var.project_name}-overly-permissive-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.app_role.name
  policy_arn = aws_iam_policy.app_policy.arn
}
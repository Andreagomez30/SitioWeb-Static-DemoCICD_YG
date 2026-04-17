provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = "bucket-johansuesucnstate-terraform" 
    key     = "github-actions-demo-yennyfer/terraform.tfstate" 
    region  = "us-east-1"
    encrypt = true
  }
}

# 1. Creación del Bucket
resource "aws_s3_bucket" "web" {
  bucket = "yennyfergomez-githubaccions-demo"
}

# 2. Configuración de sitio web estático
resource "aws_s3_bucket_website_configuration" "web_config" {
  bucket = aws_s3_bucket.web.id
  index_document {
    suffix = "index.html"
  }
}

# 3. DESACTIVAR el Bloqueo de Acceso Público
# Este paso es indispensable antes de aplicar la política
resource "aws_s3_bucket_public_access_block" "web_public" {
  bucket = aws_s3_bucket.web.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 4. Política de lectura pública
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.web.id

  # IMPORTANTE: Espera a que el bloqueo se desactive antes de aplicar la política
  depends_on = [aws_s3_bucket_public_access_block.web_public]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Sid       = "PublicReadGetObject",
      Effect    = "Allow",
      Principal = "*",
      Action    = "s3:GetObject",
      Resource  = "${aws_s3_bucket.web.arn}/*"
    }]
  })
}

# Salidas (Outputs)
output "bucket_name" {
  value = aws_s3_bucket.web.bucket
}

output "website_url" {
  value = "http://${aws_s3_bucket.web.bucket}.s3-website-us-east-1.amazonaws.com"
}
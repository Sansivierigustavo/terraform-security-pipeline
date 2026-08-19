pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = "test"
        AWS_SECRET_ACCESS_KEY = "test"
        AWS_DEFAULT_REGION    = "us-east-1"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init & Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform init -input=false'
                    sh 'terraform validate'
                }
            }
        }

        stage('Secret Scan - gitleaks') {
            steps {
                sh 'gitleaks detect --source . --no-git -v --exit-code 1'
            }
        }

        stage('Security Scan - tfsec') {
            steps {
                dir('terraform') {
                    sh 'tfsec . --format json --out tfsec-report.json --soft-fail'
                    sh 'tfsec . --soft-fail'
                }
            }
        }

        stage('Security Scan - checkov') {
            steps {
                dir('terraform') {
                    sh 'checkov -d . --output cli --output json --output-file-path console,checkov-report.json --soft-fail'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }

        stage('Aprovação Manual') {
            steps {
                input message: 'Scans revisados? Aplicar infraestrutura no LocalStack?', ok: 'Aplicar'
            }
        }

        stage('Terraform Apply (LocalStack)') {
            steps {
                dir('terraform') {
                    sh 'terraform apply -input=false tfplan'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'terraform/*-report.json', allowEmptyArchive: true
        }
    }
}
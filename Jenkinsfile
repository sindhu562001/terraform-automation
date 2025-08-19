pipeline {
    agent any

    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'qa'], description: 'Select environment to deploy')
        choice(name: 'ACTION', choices: ['plan', 'apply', 'destroy'], description: 'Terraform action to perform')
    }


    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: "https://github.com/sindhu562001/terraform-automation.git"
            }
        }

        stage('Terraform Init') {
            steps {
                dir("vpc_usage/${ENVIRONMENT}") {
                    sh "terraform init"
                }
            }
        }

        stage('Terraform Plan/Apply/Destroy') {
            steps {
                dir("vpc_usage/${ENVIRONMENT}") {
                    script {
                        if (params.ACTION == 'plan') {
                            sh "terraform plan "
                        } else if (params.ACTION == 'apply') {
                            sh "terraform apply -auto-approve "
                        } else if (params.ACTION == 'destroy') {
                            sh "terraform destroy -auto-approve"
                        }
                    }
                }
            }
        }
    }

}


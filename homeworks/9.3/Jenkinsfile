pipeline {
    agent {
        node {
            label 'jenkins_agent'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/ZenovAndrew/example-playbook.git'
            }
        }
        stage('Prepare') {
            steps {
                sh 'ansible-vault decrypt secret --vault-password-file vault_pass'
                sh 'mv secret ~/.ssh/id_rsa'
                sh 'eval `ssh-agent -s` && ssh-add ~/.ssh/id_rsa && eval `ssh -T git@github.com -o StrictHostKeyChecking=no`'
                sh '#ssh-add ~/.ssh/id_rsa'



            }
        }
        stage('Playbook') {
            steps {
                sh 'ansible-galaxy role install -r requirements.yml'
                sh 'ansible-playbook site.yml -i inventory/prod.yml'
                
            }
        }
    }
}

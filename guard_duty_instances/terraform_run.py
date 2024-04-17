import os
import subprocess


def deploy_plan(os_flavor, os_platform, home_dir, tf_environment):
    if os_platform == 'Windows' or os_platform == 'windows':
        tf_deploy = f'terraform apply {os_flavor}\\\\_{os_flavor}_{tf_environment}.tfplan'
        os.system(tf_deploy)
    if os_platform == 'Linux' or os_platform == 'linux' or os_platform == 'Darwin':
        tf_deploy = f'terraform apply {os_flavor}/_{os_flavor}_{tf_environment}.tfplan'
        os.system(tf_deploy)


def build_plan(os_flavor, team, home_dir, os_platform, tf_environment):
    tf_clean = ''
    tf_plan = ''
    tf_init = (f'/usr/local/bin/terraform init -backend-config "bucket=terraform-statefiles" -backend-config '
               f'key={team}-{tf_environment}.tfstate -backend-config "region=us-east-1"')
    if os_platform == 'Linux' or os_platform == 'linux' or os_platform == "Darwin":
        tf_clean = 'rm -rf .terraform'
        tf_plan = (f'/usr/local/bin/terraform plan -var-file=./{os_flavor}/_{os_flavor}_{tf_environment}.tfvars -state={team}'
                   f'-{tf_environment}.tfstate -out=./{os_flavor}/_{os_flavor}_{tf_environment}.tfplan')

    os.system(tf_clean)
    os.system(tf_init)
    try:
        output = subprocess.check_output("/usr/local/bin/terraform workspace list", shell=True)
        tf_output = str(output)
        if team in tf_output:
            tf_workspace = 'terraform workspace select ' + team
        else:
            tf_workspace = 'terraform workspace new ' + team
        os.system(tf_workspace)
    except Exception as e:
        print(f'workspace error {e}')
        os.system('terraform workspace select ' + team)

    os.system(tf_plan)
    deploy_plan(os_flavor, os_platform, home_dir, tf_environment)

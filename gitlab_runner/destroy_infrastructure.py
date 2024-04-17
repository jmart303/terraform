import os
import platform
import get_platform


def destroy_infrastructure(os_system, tf_environment):
    os_platform = platform.system()
    home_dir = get_platform.home_dir(os_platform)
    team = 'development'

    # if os_platform == 'Windows' or os_platform == 'windows':
    #     tf_clean = 'rmdir /Q /S ' + home_dir + '.terraform'
    #     tf_init = 'terraform init -backend-config "bucket=terraform-statefiles" -backend-config ' \
    #               '"key=' + team + '-' + os_system + '.tfstate" -backend-config "region=us-east-1" '
    #     tf_destroy = 'terraform destroy -auto-approve -var-file=' + home_dir + os_system + '\\\\_' + os_system + '.tfvars -state=' \
    #                  + os_system + '-' + team + '.tfstate'
    #     os.system(tf_clean)
    #     os.system(tf_init)
    #     os.system('terraform workspace select ' + team)
    #     os.system(tf_destroy)
    if os_platform == 'Linux' or os_platform == 'linux' or os_platform == 'Darwin':
        tf_clean = 'rm -rf .terraform'
        tf_init = (f'terraform init -backend-config "bucket=terraform-statefiles" -backend-config '
                   f'key={team}-{tf_environment}.tfstate -backend-config "region=us-east-1"')

        tf_destroy = (
            f'terraform destroy -auto-approve -var-file={home_dir}{os_system}/_{os_system}_{tf_environment}.tfvars '
            f'-state={team}-{tf_environment}.tfstate')
        print(tf_destroy)
        os.system(tf_clean)
        os.system(tf_init)
        os.system('terraform workspace select ' + team)
        os.system(tf_destroy)


def grab_input():
    sys = input('Select [1-3] for the OS to destroy\n1: {0}\n2: {1}\n3: {2}\n4: {3}\n[selection]: '.format('amzlinux2',
                                                                                                           'centos7',
                                                                                                           'win2019',
                                                                                                           'Quit'))
    environment = input('type the environment you want to destroy. This can be found in the tfvars file: \n')
    if sys == '1':
        os_system = 'amzlinux2'
        tf_environment = environment
        print(f'destroying {os_system} for environment {tf_environment}')
        destroy_infrastructure(os_system, tf_environment)
    if sys == '2':
        os_system = 'centos7'
        print('destroying ', os_system)
        destroy_infrastructure(os_system)
    if sys == '3':
        os_system = 'win2019'
        print('destroying ', os_system)
        destroy_infrastructure(os_system)
    if sys == '4' or sys != '1' or sys != '2' or sys != '3':
        print('Exiting...')
        exit()


grab_input()

import os
import platform
import build_configuration
import get_platform


def create_config():
    team = 'development'
    os_flavor = 'amzlinux2'
    os_system = '"amzlinux2"'
    tf_environment = 'gitlab-runner'
    environment = '"gitlab-runner"'
    amz_ami = '"ami-008677ef1baf82eaf"'
    vpc_id = '"<add_vpc_id>"'
    aws_subnet_id = '"<add_subnet>"'
    ingress_port_mgmt = '"22"'
    ingress_port_service = '"8080"'
    ingress_port_service_2 = '"443"'
    public_ip = os.environ['public_ip']
    email = os.environ['email']
    public_key_path = f'"{ssh_dir}automation.pub"'
    private_key_path = f'"{ssh_dir}automation"'
    iam_instance_profile = '"<IAM_instance_profile>"'
    build_configuration.create_configuration_files(team, os_flavor, os_system, amz_ami, ingress_port_mgmt,
                                                   ingress_port_service, ingress_port_service_2, public_ip, email,
                                                   public_key_path, private_key_path, home_dir, os_platform,
                                                   iam_instance_profile, tf_environment, environment, vpc_id, aws_subnet_id)


if __name__ == "__main__":
    os_platform = platform.system()
    ssh_dir = get_platform.ssh_dir(os_platform)
    home_dir = get_platform.home_dir(os_platform)
    create_config()


import os
import platform
import build_configuration
import get_platform


def create_config():
    team = 'ir_development'
    os_flavor = 'amzlinux2'
    os_system = '"amzlinux2"'
    tf_environment = 'guard_duty_automation'
    environment = '"guard_duty_automation"'
    amz_ami = '"ami-033a1ebf088e56e81"'
    vpc_id = '"<insert_vpc_ip>"'
    aws_subnet_id = '"insert_subnet"'
    public_ip = os.environ['public_ip']
    email = os.environ['email']
    public_key_path = f'"{ssh_dir}automation.pub"'
    private_key_path = f'"{ssh_dir}automation"'
    iam_instance_profile = '"<IAM_instance_profile>"'
    build_configuration.create_configuration_files(team, os_flavor, os_system, amz_ami, public_ip, email,
                                                   public_key_path, private_key_path, home_dir, os_platform,
                                                   iam_instance_profile, tf_environment, environment, vpc_id,
                                                   aws_subnet_id)


if __name__ == "__main__":
    os_platform = platform.system()
    ssh_dir = get_platform.ssh_dir(os_platform)
    home_dir = get_platform.home_dir(os_platform)
    create_config()


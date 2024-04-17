import terraform_run


def format_file(file, os_flavor, os_system, image, public_ip, email, ingress_port_mgmt, ingress_port_service,
                ingress_port_service_2, public_key_path, private_key_path, iam_instance_profile, environment,
                vpc_id, aws_subnet_id):
    file.write(
        f'ami = {image}\ninstance_type = "t2.large"\nregion = "us-east-1" \nenvironment = {environment}\n'
        f'namespace = {os_system}\navailability_zone = "us-east-1c"\ncidr_block_pub = '
        f'"{public_ip}/32"\nemail = "{email}"\nos = {os_system}\nvpc_id = {vpc_id}\naws_subnet_id '
        f'= {aws_subnet_id}\ningress_port_mgmt = {ingress_port_mgmt}\ningress_port_service = '
        f'{ingress_port_service}\ningress_port_service_2 = {ingress_port_service_2}\npublic_key_path = {public_key_path}'
        f'\nprivate_key_path = {private_key_path}\niam_instance_profile={iam_instance_profile}')


def create_configuration_files(team, os_flavor, os_system, win2019_ami, ingress_port_mgmt, ingress_port_service,
                               ingress_port_service_2, public_ip, email, public_key_path, private_key_path, home_dir,
                               os_platform, iam_instance_profile, tf_environment, environment, vpc_id, aws_subnet_id):
    with open(f'./{os_flavor}/_{os_flavor}_{tf_environment}.tfvars', 'w') as file:
        ami = win2019_ami
        ingress_port_mgmt = ingress_port_mgmt
        ingress_port_service = ingress_port_service
        public_key_path = public_key_path
        private_key_path = private_key_path
        format_file(file, os_flavor, os_system, ami, public_ip, email, ingress_port_mgmt, ingress_port_service,
                    ingress_port_service_2, public_key_path, private_key_path, iam_instance_profile, environment,
                    vpc_id, aws_subnet_id)

    terraform_run.build_plan(os_flavor, team, home_dir, os_platform, tf_environment)

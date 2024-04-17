def ssh_dir(os_platform):
    if os_platform == 'Windows' or os_platform == 'windows':
        from pathlib import Path
        my_ssh_dir = str(Path.home()) + '\.ssh\\'
        my_ssh_dir = my_ssh_dir.split('\\')
        sep = '\\\\'
        my_ssh_dir = sep.join(my_ssh_dir)
        return my_ssh_dir
    if os_platform == 'Linux' or os_platform == 'linux' or os_platform == 'Darwin':
        my_ssh_dir = '~/.ssh/'
        return my_ssh_dir


def home_dir(os_platform):
    if os_platform == 'Windows' or os_platform == 'windows':
        from pathlib import Path
        my_home_dir = str(Path.home()) + '\\'
        my_home_dir = my_home_dir.split('\\')
        sep = '\\\\'
        my_home_dir = sep.join(my_home_dir)
        my_home_dir = my_home_dir + 'infrastructure\\\instances\\\\'
        return my_home_dir
    if os_platform == 'Linux' or os_platform == 'linux' or os_platform == 'Darwin':
        my_home_dir = './'
        return my_home_dir

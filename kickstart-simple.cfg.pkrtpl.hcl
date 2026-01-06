cmdline
cdrom
reboot

keyboard --vckeymap=us
lang en_US.UTF-8
timezone "${system_timezone}" --utc

rootpw --lock
user --name "${admin_user_name}" --groups wheel --password "${admin_user_pwd}"
sshkey --username "${admin_user_name}" "${admin_public_key}"
user --name "${packer_user_name}" --password "${packer_user_pwd}"
sshkey --username "${packer_user_name}" "${packer_public_key}"

eula --agreed
skipx
firewall --enabled --ssh
selinux --enforcing
network --bootproto=dhcp --device=enp0s2 --onboot=yes --noipv6 --hostname="${hostname}"

zerombr
clearpart --all --initlabel --drives=sda
part /boot/efi --fstype="efi" --ondisk=sda --size=500 --asprimary
part /boot --fstype="xfs" --ondisk=sda --size=1024 --asprimary
part / --fstype="xfs" --ondisk=sda --size=1 --grow

bootloader --location=none --efi

%packages
@minimal-install
%end
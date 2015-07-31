#!/bin/sh

set +x
#
# Returns the name of the Boot2Docker VM. This is the official identifier used
# by VirtualBox.
#
function find_boot2docker_vm_name {
  boot2docker cfg | grep "^VM = " | sed -e 's/VM = "\(.*\)"/\1/'
}

#
# Usage: find_vboxsf_mounted_folders
#
# Returns mounted volumes with vboxsf-type in boot2docker instance.
#
function find_vboxsf_mounted_folders {
  boot2docker ssh mount | grep 'type vboxsf' | awk '{print $3}'
}

#
# Usage: umount_vboxsf_mounted_folder SHARED_FOLDERS
#
# Remove the VirtualBox shared folder from the boot2docker VM.
# SHARED_FOLDERS should be the output of the
# find_vboxsf_mounted_folders function.
#
function umount_vboxsf_mounted_folder {
  local readonly vbox_shared_folders="$1"
  local vbox_shared_folder=''
  while read -r vbox_shared_folder; do
    echo "Removing shared folder: $vbox_shared_folder"
    echo boot2docker ssh sudo umount -l "$vbox_shared_folder"
    boot2docker ssh sudo umount -l "$vbox_shared_folder"
  done <<< "$vbox_shared_folders"
}

#
# Checks if the Boot2Docker VM has any VirtualBox shared folders. If so, prompt
# the user if they would like to remove them, as they will void any benefits
# from using rsync.
#
function check_for_shared_folders {
  local readonly vm_name=$(find_boot2docker_vm_name)
  local readonly vbox_shared_folders=$(find_vboxsf_mounted_folders)

  if [[ ! -z "$vbox_shared_folders" ]]; then
    echo "Found VirtualBox shared folders on your Boot2Docker VM. These may void any performance benefits from using docker-osx-dev:\n$vbox_shared_folders"
    umount_vboxsf_mounted_folder "$vbox_shared_folders"
  fi
}

check_for_shared_folders
set +x
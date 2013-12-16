#!/bin/bash

#-----------------------------------------------------------------------------#
# this is a helper script to easily switch forth and back between virtualbox  #
# instances of differing openstack versions. i use it to easily test the      #
# ansible-openstack-modules on both versions of openstack. to use it, create  #
# an openstack grizzly installation of 4 machines with the following names:   #
# - grizzly_controller                                                        #
# - grizzly_network                                                           #
# - grizzly_storage                                                           #
# - grizzly_compute                                                           #
#                                                                             #
# then create another openstack installation on 4 machines, using the same    #
# ip addresses, and name them:                                                #
# - havana_controller                                                         #
# - havana_network                                                            #
# - havana_storage                                                            #
# - havana_compute                                                            #
#                                                                             #
# now it's easy to switch between the different versions of openstack:        #
# openstack_version_switch.sh havana savestate;                               #
# openstack_version_switch.sh grizzly resume;                                 #
# openstack_version_switch.sh grizzly savestate;                              #
# openstack_version_switch.sh havana resume;                                  #
#-----------------------------------------------------------------------------#

help() {
  echo "vbox_control.sh <havana|grizzly> <savestate|resume>"
  exit 1
}

if [[ "${1}" != "havana" && "${1}" != "grizzly" ]]
then
  help
fi

if [[ "${2}" != "savestate" && "${2}" != "resume" ]]
then
  help
fi

VMS="_controller _network _storage _compute"

for i in ${VMS}
do
  CMD="VBoxManage controlvm ${1}${i} ${2}"
  echo ${CMD}
  ${CMD}
done

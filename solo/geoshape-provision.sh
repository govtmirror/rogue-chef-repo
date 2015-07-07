#!/bin/bash
# exit if anything returns failure
set -e

if [ "$1" = "silent" ];
then
  GEOSHAPE_SILENT=true
fi

if [ "$GEOSHAPE_SILENT" != true ]; then
    echo "====[ Note:
      This command will re-run the installation of geoshape with the same version already
      on the machine. you can run this command to apply any changes you have made in dna.json
      or re-download the corresponding geoserver.war"

    while true; do
        read -p "=> Are you sure you want to continue? " yn
        case $yn in
            [Yy]* ) break;;
            [Nn]* ) echo "    geoshape provision exited. ";exit;;
            * ) echo "    Please answer yes or no.";;
        esac
    done
fi


# Note: cannot be in the /opt/rogue-chef-repo when running this command.
#       ruby shadow install failes because chef failes to find some 
#       packages such as pg and shadow
cd /opt/chef-run
chef-solo -c /opt/chef-run/solo.rb -j /opt/chef-run/dna.json

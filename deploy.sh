#!/bin/bash
# deployment script for the redcap_security_settings GLID patch
# Clone the repo that has this file via
#
#   git clone git@ctsit-forge.ctsi.ufl.edu:redcap_security_settings.git
#
# Call this script with two parameters:
#
#   REDCAP_ROOT - the top level redcap directory.  typically this directory contains cron.php
#   REDCAP_VERSION - the version of the code being patched/deployed.
#

set -e

export REDCAP_ROOT=$1
export REDCAP_VERSION=$2

# determine the directory where this script resides
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $REDCAP_ROOT/redcap_v$REDCAP_VERSION/ControlCenter/
patch -p1 < $DIR/security_settings.php.patch

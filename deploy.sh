#!/bin/bash
# deployment script for the change_from_address patch for the ReminderUserAccessDashboardEmail cron job
# Clone the repo that has this file via
#
#   git clone git@ctsit-forge.ctsi.ufl.edu:change_from_address_in_ReminderUserAccessDashboardEmail.git
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

cd $REDCAP_ROOT/redcap_v$REDCAP_VERSION/Classes/
patch -p1 < $DIR/patch.patch

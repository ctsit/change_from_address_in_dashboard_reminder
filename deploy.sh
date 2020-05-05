#!/bin/bash
# deployment script for the change_from_address patch for the ReminderUserAccessDashboardEmail cron job
# Clone the repo that has this file via
#
#   git clone git@github.com:ctsit/change_from_address_in_dashboard_reminder.git
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

PATCH_VERSIONS=$(mktemp)
$(ls *.patch | grep -v "sql" | sed "s/\.patch//;" > $PATCH_VERSIONS)
if [[ $(cat $PATCH_VERSIONS | grep "$REDCAP_VERSION") ]]; then
    REDCAP_PATCH_VERSION=$REDCAP_VERSION
else
    echo "${REDCAP_VERSION}" >> "$PATCH_VERSIONS"
    if [[ "$(cat $PATCH_VERSIONS | sort -V | head -n 1)" == "$REDCAP_VERSION" ]]; then
        # provided version is earlier than any updated version, use base patch.patch file
        REDCAP_PATCH_VERSION="patch"
    else
        # use closest lower version patch file
        REDCAP_PATCH_VERSION=$(cat $PATCH_VERSIONS | sort -V | grep "$REDCAP_VERSION" -B 1 | head -n1)
    fi
fi
rm $PATCH_VERSIONS

cd $REDCAP_ROOT/redcap_v$REDCAP_VERSION/Classes/
patch -p1 < $DIR/${REDCAP_PATCH_VERSION}.patch

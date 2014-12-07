#!/usr/bin/env bash

#
## Overview
#
# Builds application (project) specific API docs.
#
# NOTE: The Event Scan app is ignored as it's an app from a client

echo -e "\ninfo: Building application API docs\n"

appledoc \
--project-name "ANZ Task iOS Applications" \
--project-company "Australia and New Zealand Banking Group Limited" \
--company-id "ANZ" \
--create-html \
--output docs/_static/app_api_docs \
--clean-output \
--keep-undocumented-objects \
--keep-undocumented-members \
--keep-intermediate-files \
--warn-empty-description \
--no-install-docset \
--no-repeat-first-par \
--no-warn-invalid-crossref \
--verbose 2 \
--exit-threshold 2 \
--ignore *.m \
--ignore "event scan" \
./Project/AnzTask

echo -e "\ninfo: App API docs built\n"
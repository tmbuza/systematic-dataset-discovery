#!/bin/bash

##############################################################################
# Create Discovery Output Files
##############################################################################
# Purpose:
#   Create the standard output directory and placeholder files used by the
#   CDI Systematic Dataset Discovery workflow.
##############################################################################

set -euo pipefail

mkdir -p outputs

touch outputs/candidate-studies.tsv
touch outputs/screened-studies.tsv
touch outputs/included-studies.tsv
touch outputs/excluded-studies.tsv
touch outputs/prioritization-table.tsv
touch outputs/cdi-das-input-accessions.txt

echo "Discovery output files created:"
echo "outputs/candidate-studies.tsv"
echo "outputs/screened-studies.tsv"
echo "outputs/included-studies.tsv"
echo "outputs/excluded-studies.tsv"
echo "outputs/prioritization-table.tsv"
echo "outputs/cdi-das-input-accessions.txt"
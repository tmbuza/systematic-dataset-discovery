#!/bin/bash

##############################################################################
# Run Healthy Human Gut Microbiome Case Study
# scripts/bash/09-run-case-study.sh
##############################################################################
# Purpose:
#   Execute the full CDI Systematic Dataset Discovery case-study workflow
#   using the default healthy human gut microbiome settings.
#
# Default case-study settings:
#   Primary BioProject: PRJNA802976
#   Primary test subset:
#     SRR17868090
#     SRR17868091
#     SRR17868092
#   Secondary comparison: PRJNA322554
#
# Outputs:
#   outputs/discovery-plan.tsv
#   outputs/repository-sources.tsv
#   outputs/search-strategy.tsv
#   outputs/bioproject-search-results.tsv
#   outputs/literature-search-results.tsv
#   outputs/candidate-studies.tsv
#   outputs/inclusion-criteria.tsv
#   outputs/exclusion-criteria.tsv
#   outputs/screened-studies.tsv
#   outputs/included-studies.tsv
#   outputs/excluded-studies.tsv
#   outputs/review-studies.tsv
#   outputs/prioritization-table.tsv
#   outputs/included-study-package.tsv
#   outputs/cdi-das-input-accessions.txt
#   outputs/cdi-das-test-accessions.txt
##############################################################################

set -euo pipefail

##############################################################################
# Start
##############################################################################

echo "========================================"
echo "CDI Systematic Dataset Discovery"
echo "Healthy Human Gut Microbiome Case Study"
echo "========================================"
echo
echo "Primary BioProject: PRJNA802976"
echo "Primary test subset:"
echo "  SRR17868090"
echo "  SRR17868091"
echo "  SRR17868092"
echo "Secondary comparison: PRJNA322554"
echo

##############################################################################
# Ensure required directories
##############################################################################

mkdir -p outputs
mkdir -p logs

LOG_FILE="logs/09-case-study.log"

echo "Writing log to: $LOG_FILE"
echo

##############################################################################
# Run workflow
##############################################################################

{
    echo "========================================"
    echo "Step 01: Create discovery outputs"
    echo "========================================"
    bash scripts/bash/01-create-discovery-outputs.sh
    echo

    echo "========================================"
    echo "Step 02: Create discovery plan"
    echo "========================================"
    bash scripts/bash/02-create-discovery-plan.sh
    echo

    echo "========================================"
    echo "Step 03: Create repository source table"
    echo "========================================"
    bash scripts/bash/03-create-repository-sources.sh
    echo

    echo "========================================"
    echo "Step 04a: Search BioProjects"
    echo "========================================"
    bash scripts/bash/04a-search-bioprojects.sh
    echo

    echo "========================================"
    echo "Step 04b: Search literature"
    echo "========================================"
    bash scripts/bash/04b-search-literature.sh
    echo

    echo "========================================"
    echo "Step 04c: Create candidate studies template"
    echo "========================================"
    bash scripts/bash/04c-create-candidate-studies-template.sh
    echo

    echo "========================================"
    echo "Step 05a: Build inclusion criteria"
    echo "========================================"
    bash scripts/bash/05a-build-inclusion-criteria.sh
    echo

    echo "========================================"
    echo "Step 05b: Build exclusion criteria"
    echo "========================================"
    bash scripts/bash/05b-build-exclusion-criteria.sh
    echo

    echo "========================================"
    echo "Step 06a: Screen candidate studies"
    echo "========================================"
    bash scripts/bash/06a-screen-candidate-studies.sh
    echo

    echo "========================================"
    echo "Step 07a: Build prioritization table"
    echo "========================================"
    bash scripts/bash/07a-build-prioritization-table.sh
    echo

    echo "========================================"
    echo "Step 08a: Build included study package"
    echo "========================================"
    bash scripts/bash/08a-build-included-study-package.sh
    echo

} 2>&1 | tee "$LOG_FILE"

##############################################################################
# Final summary
##############################################################################

echo
echo "========================================"
echo "Case study workflow complete"
echo "========================================"
echo
echo "Key outputs:"
echo "outputs/cdi-das-input-accessions.txt"
echo "outputs/cdi-das-test-accessions.txt"
echo "outputs/included-study-package.tsv"
echo "outputs/prioritization-table.tsv"
echo
echo "CDI-DAS input accession:"
cat outputs/cdi-das-input-accessions.txt
echo
echo "CDI-DAS test accessions:"
cat outputs/cdi-das-test-accessions.txt
echo
echo "Full log:"
echo "$LOG_FILE"
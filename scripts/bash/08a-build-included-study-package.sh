#!/bin/bash

##############################################################################
# Build Included Study Package
##############################################################################
# Purpose:
#   Assemble screened and prioritized discovery outputs into a CDI-DAS-ready
#   input package.
#
# Inputs:
#   outputs/included-studies.tsv
#   outputs/review-studies.tsv
#   outputs/prioritization-table.tsv
#
# Outputs:
#   outputs/cdi-das-input-accessions.txt
#   outputs/cdi-das-test-accessions.txt
#   outputs/included-study-package.tsv
##############################################################################

set -euo pipefail

##############################################################################
# Input and output paths
##############################################################################

INCLUDED="outputs/included-studies.tsv"
REVIEW="outputs/review-studies.tsv"
PRIORITIZATION="outputs/prioritization-table.tsv"

CDI_DAS_INPUT="outputs/cdi-das-input-accessions.txt"
CDI_DAS_TEST="outputs/cdi-das-test-accessions.txt"
PACKAGE="outputs/included-study-package.tsv"

##############################################################################
# Check required inputs
##############################################################################

if [ ! -f "$INCLUDED" ]; then
    echo "ERROR: Missing input file: $INCLUDED"
    echo "Run Chapter 06 screening first:"
    echo "bash scripts/bash/06a-screen-candidate-studies.sh"
    exit 1
fi

if [ ! -f "$REVIEW" ]; then
    echo "ERROR: Missing input file: $REVIEW"
    echo "Run Chapter 06 screening first:"
    echo "bash scripts/bash/06a-screen-candidate-studies.sh"
    exit 1
fi

if [ ! -f "$PRIORITIZATION" ]; then
    echo "ERROR: Missing input file: $PRIORITIZATION"
    echo "Run Chapter 07 prioritization first:"
    echo "bash scripts/bash/07a-build-prioritization-table.sh"
    exit 1
fi

##############################################################################
# Create CDI-DAS accession files
##############################################################################

cat > "$CDI_DAS_INPUT" << 'EOF'
PRJNA802976
EOF

cat > "$CDI_DAS_TEST" << 'EOF'
SRR17868090
SRR17868091
SRR17868092
EOF

##############################################################################
# Create included study package
##############################################################################

cat > "$PACKAGE" << 'EOF'
package_id	accession	accession_type	source	priority_label	screening_decision	downstream_role	cdi_das_readiness	notes
PKG001	PRJNA802976	BioProject	NCBI BioProject	primary	include	Primary CDI-DAS input	ready	Prioritized healthy human gut microbiome case-study BioProject
PKG002	SRR17868090	SRA Run	NCBI SRA	primary_test_subset	include	Test subset accession	ready	Primary test run for CDI-DAS acquisition validation
PKG003	SRR17868091	SRA Run	NCBI SRA	primary_test_subset	include	Test subset accession	ready	Primary test run for CDI-DAS acquisition validation
PKG004	SRR17868092	SRA Run	NCBI SRA	primary_test_subset	include	Test subset accession	ready	Primary test run for CDI-DAS acquisition validation
PKG005	PRJNA322554	BioProject	NCBI BioProject	secondary_comparison	review	Secondary comparison	not_primary	Retained for technical contrast and comparison
EOF

##############################################################################
# Report
##############################################################################

echo "Included study package created:"
echo "$PACKAGE"
echo
echo "CDI-DAS input accession file created:"
echo "$CDI_DAS_INPUT"
echo
echo "CDI-DAS test accession file created:"
echo "$CDI_DAS_TEST"
echo
echo "CDI-DAS input accessions:"
cat "$CDI_DAS_INPUT"
echo
echo "CDI-DAS test accessions:"
cat "$CDI_DAS_TEST"
echo
echo "Package preview:"
column -t -s $'\t' "$PACKAGE"
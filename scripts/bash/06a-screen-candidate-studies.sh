#!/bin/bash

##############################################################################
# Screen Candidate Studies
##############################################################################
# Purpose:
#   Apply structured screening decisions to candidate studies generated during
#   CDI Systematic Dataset Discovery.
#
# Inputs:
#   outputs/candidate-studies.tsv
#   outputs/inclusion-criteria.tsv
#   outputs/exclusion-criteria.tsv
#
# Outputs:
#   outputs/screened-studies.tsv
#   outputs/included-studies.tsv
#   outputs/excluded-studies.tsv
#   outputs/review-studies.tsv
##############################################################################

set -euo pipefail

##############################################################################
# Input and output paths
##############################################################################

CANDIDATES="outputs/candidate-studies.tsv"
SCREENED="outputs/screened-studies.tsv"
INCLUDED="outputs/included-studies.tsv"
EXCLUDED="outputs/excluded-studies.tsv"
REVIEW="outputs/review-studies.tsv"

##############################################################################
# Check required inputs
##############################################################################

if [ ! -f "$CANDIDATES" ]; then
    echo "ERROR: Missing input file: $CANDIDATES"
    echo "Run Chapter 04 scripts first:"
    echo "bash scripts/bash/04a-search-bioprojects.sh"
    echo "bash scripts/bash/04b-search-literature.sh"
    echo "bash scripts/bash/04c-create-candidate-studies-template.sh"
    exit 1
fi

if [ ! -f "outputs/inclusion-criteria.tsv" ]; then
    echo "ERROR: Missing input file: outputs/inclusion-criteria.tsv"
    echo "Run: bash scripts/bash/05a-build-inclusion-criteria.sh"
    exit 1
fi

if [ ! -f "outputs/exclusion-criteria.tsv" ]; then
    echo "ERROR: Missing input file: outputs/exclusion-criteria.tsv"
    echo "Run: bash scripts/bash/05b-build-exclusion-criteria.sh"
    exit 1
fi

##############################################################################
# Create screened studies table
##############################################################################

cat > "$SCREENED" << 'EOF'
candidate_id	source	title_or_record_name	accession	publication_id	organism	sample_context	data_type	repository_link_or_accession	screening_decision	screening_reason	priority_level	notes
CAND001	NCBI BioProject	Healthy human gut microbiome case-study BioProject	PRJNA802976		Human	Gut or stool microbiome	Microbiome sequencing	PRJNA802976	include	Matches organism, sample context, data type, public accession, and CDI-DAS readiness	primary	Prioritized case-study BioProject
CAND002	NCBI SRA	Primary PRJNA802976 test run	SRR17868090		Human	Gut or stool microbiome	Microbiome sequencing	SRR17868090	include	Test run from prioritized BioProject suitable for acquisition validation	primary	Primary test subset
CAND003	NCBI SRA	Primary PRJNA802976 test run	SRR17868091		Human	Gut or stool microbiome	Microbiome sequencing	SRR17868091	include	Test run from prioritized BioProject suitable for acquisition validation	primary	Primary test subset
CAND004	NCBI SRA	Primary PRJNA802976 test run	SRR17868092		Human	Gut or stool microbiome	Microbiome sequencing	SRR17868092	include	Test run from prioritized BioProject suitable for acquisition validation	primary	Primary test subset
CAND005	NCBI BioProject	Secondary comparison BioProject	PRJNA322554		Human	Gut or stool microbiome	Microbiome sequencing	PRJNA322554	review	Relevant human gut microbiome BioProject, retained as secondary technical comparison	secondary	Review for comparison use
EOF

##############################################################################
# Split screened studies by decision
##############################################################################

head -n 1 "$SCREENED" > "$INCLUDED"
awk -F '\t' 'NR > 1 && $10 == "include"' "$SCREENED" >> "$INCLUDED"

head -n 1 "$SCREENED" > "$EXCLUDED"
awk -F '\t' 'NR > 1 && $10 == "exclude"' "$SCREENED" >> "$EXCLUDED"

head -n 1 "$SCREENED" > "$REVIEW"
awk -F '\t' 'NR > 1 && $10 == "review"' "$SCREENED" >> "$REVIEW"

##############################################################################
# Report
##############################################################################

echo "Screening complete."
echo
echo "Created:"
echo "$SCREENED"
echo "$INCLUDED"
echo "$EXCLUDED"
echo "$REVIEW"
echo
echo "Screening summary:"
echo "Included studies/runs:"
awk -F '\t' 'NR > 1 && $10 == "include" {count++} END {print count + 0}' "$SCREENED"

echo "Excluded studies/runs:"
awk -F '\t' 'NR > 1 && $10 == "exclude" {count++} END {print count + 0}' "$SCREENED"

echo "Review studies/runs:"
awk -F '\t' 'NR > 1 && $10 == "review" {count++} END {print count + 0}' "$SCREENED"

echo
echo "Preview:"
column -t -s $'\t' "$SCREENED"
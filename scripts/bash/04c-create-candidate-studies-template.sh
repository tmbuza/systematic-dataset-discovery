#!/bin/bash

##############################################################################
# Create Candidate Studies Template
##############################################################################
# Purpose:
#   Create a structured candidate study table for recording studies identified
#   during BioProject and literature searches in the CDI Systematic Dataset
#   Discovery workflow.
#
# Output:
#   outputs/candidate-studies.tsv
##############################################################################

set -euo pipefail

##############################################################################
# Output directory
##############################################################################

mkdir -p outputs

##############################################################################
# Create candidate study template
##############################################################################

cat > outputs/candidate-studies.tsv << 'EOF'
candidate_id	source	title_or_record_name	accession	publication_id	organism	sample_context	data_type	repository_link_or_accession	notes	screening_status
CAND001	NCBI BioProject	Healthy human gut microbiome case-study BioProject	PRJNA802976		Human	Gut or stool microbiome	Microbiome sequencing	PRJNA802976	Prioritized case-study BioProject for CDI-DAS handoff	pending
CAND002	NCBI SRA	Primary PRJNA802976 test run	SRR17868090		Human	Gut or stool microbiome	Microbiome sequencing	SRR17868090	Primary test subset run for acquisition validation	pending
CAND003	NCBI SRA	Primary PRJNA802976 test run	SRR17868091		Human	Gut or stool microbiome	Microbiome sequencing	SRR17868091	Primary test subset run for acquisition validation	pending
CAND004	NCBI SRA	Primary PRJNA802976 test run	SRR17868092		Human	Gut or stool microbiome	Microbiome sequencing	SRR17868092	Primary test subset run for acquisition validation	pending
CAND005	NCBI BioProject	Secondary comparison BioProject	PRJNA322554		Human	Gut or stool microbiome	Microbiome sequencing	PRJNA322554	Secondary comparison example for technical contrast	pending
EOF

##############################################################################
# Report
##############################################################################

echo "Candidate studies template created:"
echo "outputs/candidate-studies.tsv"
echo
echo "Preview:"
column -t -s $'\t' outputs/candidate-studies.tsv
#!/bin/bash

##############################################################################
# Search BioProjects
##############################################################################
# Purpose:
#   Create a reproducible BioProject search record for the CDI Systematic
#   Dataset Discovery workflow.
#
# Output:
#   outputs/search-strategy.tsv
#   outputs/bioproject-search-results.tsv
##############################################################################

set -euo pipefail

mkdir -p outputs

##############################################################################
# Search settings
##############################################################################

SEARCH_DATE="$(date +%Y-%m-%d)"

BIOPROJECT_QUERY='human gut microbiome healthy'
PRIORITY_BIOPROJECT='PRJNA802976'
SECONDARY_BIOPROJECT='PRJNA322554'

##############################################################################
# Record search strategy
##############################################################################

if [ ! -f outputs/search-strategy.tsv ]; then
cat > outputs/search-strategy.tsv << 'EOF'
source	search_date	search_query	search_purpose	expected_output	notes
EOF
fi

cat >> outputs/search-strategy.tsv << EOF
NCBI BioProject	${SEARCH_DATE}	${BIOPROJECT_QUERY}	Identify candidate project-level accessions	BioProject accession records	Prioritize accession-linked human gut microbiome studies
EOF

##############################################################################
# Create BioProject search results table
##############################################################################

cat > outputs/bioproject-search-results.tsv << EOF
candidate_id	source	search_date	search_query	bioproject_accession	priority_level	organism	sample_context	data_type	notes
BP001	NCBI BioProject	${SEARCH_DATE}	${BIOPROJECT_QUERY}	${PRIORITY_BIOPROJECT}	primary	Human	Gut or stool microbiome	Microbiome sequencing	Prioritized case-study BioProject for CDI-DAS handoff
BP002	NCBI BioProject	${SEARCH_DATE}	${BIOPROJECT_QUERY}	${SECONDARY_BIOPROJECT}	secondary	Human	Gut or stool microbiome	Microbiome sequencing	Secondary comparison BioProject for technical contrast
EOF

##############################################################################
# Report
##############################################################################

echo "BioProject search record created:"
echo "outputs/bioproject-search-results.tsv"
echo
echo "Search strategy updated:"
echo "outputs/search-strategy.tsv"
echo
echo "Preview:"
column -t -s $'\t' outputs/bioproject-search-results.tsv
#!/bin/bash

##############################################################################
# Search Literature
##############################################################################
# Purpose:
#   Create a reproducible literature search record for the CDI Systematic
#   Dataset Discovery workflow.
#
# Output:
#   outputs/search-strategy.tsv
#   outputs/literature-search-results.tsv
##############################################################################

set -euo pipefail

mkdir -p outputs

##############################################################################
# Search settings
##############################################################################

SEARCH_DATE="$(date +%Y-%m-%d)"

PUBMED_QUERY='(human[Title/Abstract] OR "Homo sapiens"[Title/Abstract]) AND (gut[Title/Abstract] OR intestinal[Title/Abstract] OR stool[Title/Abstract] OR fecal[Title/Abstract] OR faecal[Title/Abstract]) AND (microbiome[Title/Abstract] OR microbiota[Title/Abstract] OR metagenome[Title/Abstract]) AND (healthy[Title/Abstract] OR control[Title/Abstract] OR baseline[Title/Abstract])'

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
PubMed	${SEARCH_DATE}	${PUBMED_QUERY}	Identify candidate publications and study context	Literature search records and accession-linked study leads	Search should be reviewed for data availability statements and supplementary materials
EOF

##############################################################################
# Create literature search results table
##############################################################################

cat > outputs/literature-search-results.tsv << EOF
candidate_id	source	search_date	search_query	title_or_record_name	publication_id	linked_accession	organism	sample_context	data_type	notes
LIT001	PubMed	${SEARCH_DATE}	${PUBMED_QUERY}	Healthy human gut microbiome case-study literature record	to_be_completed	${PRIORITY_BIOPROJECT}	Human	Gut or stool microbiome	Microbiome sequencing	Review publication and data availability statement linked to prioritized BioProject
LIT002	PubMed	${SEARCH_DATE}	${PUBMED_QUERY}	Secondary comparison literature record	to_be_completed	${SECONDARY_BIOPROJECT}	Human	Gut or stool microbiome	Microbiome sequencing	Review as comparison example if needed
EOF

##############################################################################
# Report
##############################################################################

echo "Literature search record created:"
echo "outputs/literature-search-results.tsv"
echo
echo "Search strategy updated:"
echo "outputs/search-strategy.tsv"
echo
echo "Preview:"
column -t -s $'\t' outputs/literature-search-results.tsv
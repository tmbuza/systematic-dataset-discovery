#!/bin/bash

##############################################################################
# Create Discovery Planning Template
##############################################################################
# Purpose:
#   Create a structured planning file that documents the research question,
#   discovery objective, scope, and downstream handoff for the CDI Systematic
#   Dataset Discovery workflow.
##############################################################################

set -euo pipefail

##############################################################################
# Output directory
##############################################################################

mkdir -p outputs

##############################################################################
# Create discovery planning template
##############################################################################

cat > outputs/discovery-plan.tsv << 'EOF'
field	value
research_topic	Healthy human gut microbiome
discovery_question	Which public omics studies contain healthy human gut microbiome sequencing data suitable for reference dataset assembly?
discovery_objective	Identify, screen, and prioritize public studies containing healthy human gut microbiome sequencing data, and assemble a curated accession list for CDI-DAS data acquisition.
organism	Human
body_site	Gut or stool
health_status	Healthy or non-diseased
data_type	Microbiome sequencing
unit_of_inclusion	Public study or BioProject
repository_scope	NCBI BioProject, SRA, ENA, PubMed, linked publications
downstream_system	CDI Data Acquisition System
expected_handoff	Curated accession list for CDI-DAS
EOF

##############################################################################
# Report
##############################################################################

echo "Discovery planning template created:"
echo "outputs/discovery-plan.tsv"
echo
echo "Preview:"
column -t -s $'\t' outputs/discovery-plan.tsv
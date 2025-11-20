#!/bin/bash
# Use this script to delete ALL generated files/cache
echo "Deleting Nextflow Run Directories & Files"
rm -r work
rm .nextflow.log*
rm -r .nextflow
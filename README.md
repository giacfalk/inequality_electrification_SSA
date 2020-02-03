[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)

# Replication scripts and data for the paper 'Satellite observations reveal inequalities in the progress and effectiveness of recent electrification in sub-Saharan Africa'

This repository hosts:

 - A JavaScript file to process remotely-sensed data into Google Earth Engine (step 1)
 - A R script, to be run after the successful completion of the Google Earth Engine processing (step 2)
 - Supporting files to run the analysis (e.g. a shapefile of provinces, validation data, etc.)

- Create a Google account, if you do not have one, and require access to Earth Engine https://signup.earthengine.google.com.
- Make sure your Google Drive has enough cloud storage space available.
- Clone the repository.
- Run the JavaScript file in Google Earth Engine and wait that the data processing is complete **(can take >24 hours)**
- Run the R script, which will reproduce the analysis and the figures contained in the paper.
- Open the QGIS project files to replicate maps with the appropriate layout.

Source code-related issues should be opened directly on GitHub. Broader questions of the methods should be addressed to giacomo.falchetta@feem.it

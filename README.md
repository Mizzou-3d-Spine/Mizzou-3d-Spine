# Mizzou 3D SPinE – 
A program used to extract measurements from sterEOS Advanced Spine Workflow

# Content
- [Introduction](#Introduction)
  - [Step 1: sterEOS Advanced Spine WorkflowFile Preparation](#Step-1-Advanced-Spine-Workflow-File-Preparation)
  - [Step 2: Setup](#Step-2-Setup)
  - [Step 3: Data Aggregations](#Step-3-Data-Aggregations)
- [Understanding the Mizzou 3D SPinE Result File ](#Understanding-the-Mizzou-3D-SPinE-Result-File)

# Introduction
**Mizzou 3D SPinE** is used to organize and extract measurements from many sterEOS Advanced Spine Workflow assessments, this can be mulitple assessments for an individual and/or many individuals.  All measurements from the sterEOS Advanced Spine Workflow are located in the Excel file of the sterEOS Advanced Spine Workflow resulting infiles. This file contains the measurements for “Scoliosis parameters”, “Sagittal Balance”, “Vertebral Orientations” which includes frontal, lateral, and axial perspectives in both the patient and radio planes, “Intervertebral rotations” with frontal, lateral, and axial perspectives in the radio plane, “Pelvic parameters” for both the patient and Radio plane, and the “3D Tools”.  For each of these sections, the name of each measurement, along with the measured value, are extracted, such that each measurement label would be a formatted as a column name and the measured value would be extracted as the value for that column, in the resulting **Mizzou 3D SPinE** output file.  The output file is formatted such that each row of data, corresponds to one assessment for one individual; multiple assessments for one individual are organized by their participant id and date of assesmsent, in separate rows. Any measurements which are missing or empty from the EOS Advanced Spine Workflow .xlsx file are empty in the output file. 

## Step 1: sterEOS Advanced Spine Workflow File Preparation
To use **Mizzou 3D SPinE**, files must be named and organized in a specified format.  All patient assessments, intended for use with the **Mizzou 3D SPinE** should be saved within a single parent folder, for example, “Test Data”, as shown in Figure 1.  The parent folder should not contain any files, data, or subfolders which are not output from the sterEOS Advanced Spine Workflow.  Empty folders should also not be saved within the parent folder. Within the parent folder, each patient should have a folder in which all files for each sterEOS assessment, for that patient should be saved, named using the patient identifier. Then, output files for each sterEOS assessment of each patient should be saved within a subfolder, named using the EOS assessment date using the “MM-DD-YYYY” format and located within each patient folder. The resulting file structure should be that all output files for the sterEOS Advanced Spine Workflow associated with each patient-specific EOS assessment has its own folder, named using the date, and that these are all stored within the main folder for each patient, named using the numerical patient identifier (Figure 1). An example of the organized EOS files is available at [Example Data](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Data).

---
<p align="center">
    <em> Figure 1: EOS File Preparation </em>
</p>

<p align="center">
  <img src="https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Fig/EOS_Files.PNG" width="400">
</p>

---

## Step 2: Setup
### Downloading RStudio
Users can find and download RStudio Desktop at [https://www.rstudio.com](https://www.rstudio.com/products/rstudio/download/#download).

### Loading Mizzou 3D SPinE
**Mizzou 3D SPinE** to continue (Figure 2):
```r
if(!require("devtools")){
  install.packages("devtools")
}
devtools::source_url("https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Code/Function.R")
```

---
<p align="center">
    <em> Figure 2: Loading the Function.R program </em> 
</p>

<p align="center">
  <img src="https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Fig/Loading_Program.png" width="800">
</p>
---

## Step 3: Data Aggregations
Once the sterEOS Advanced Spine Workflow files have been organized, the data aggregations can be conducted by typying the following codes in RStudio and **press Enter** to process:

```r
datamerge()
```

This program would direct the user to specify the parent folder where all sterEOS patient assessments were saved  (Figure 3), and the output folder file path where user would like the aggregated data to be saved (Figure 4). The output folder must be outside of the parent folder. 

---
<p align="center">
    <em> Figure 3: Selecting the path of parent folder </em>
</p>

<p align="center">
  <img src="https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Fig/Data_Aggregation_Input.PNG" width="600">
</p>

<p align="center">
    <em> Figure 4: Selecting the path of merged data </em>
</p>

<p align="center">
  <img src="https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Fig/Data_Aggregation_Output.PNG" width="600">
</p>

---

Once the input and output file locations have been specified, **Mizzou 3D SPinE** will aggregate all data into a single file “MergedData_YYYYMMDD.xlsx” in the assigned output folder, where the “YYYYMMDD” corresponds to the date that the **Mizzou 3D SPinE** was run (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Output)).

## Understanding the Mizzou 3D SPinE Result File 
Extracted measurements for each sterEOS Advanced Spine Workflow assessment are combined into one row in the newly aggregated **Mizzou 3D SPineE** result file.  Patients with multiple assessments will have each assessment appear in one row, indexed by visit date.  The aggregated measurements are color coded to denote their original location in the sterEOS Advanced Spine Workflow file from which the measurement was extracted. Further, all variable names are named using the abbreviation from the location headers in the original sterEOS Advanced Spine Workflow Excel file.  For example, all measurements from “Scolisosis Parameters” are colored salmon and the variable names have been defined using the location of the parameter, e.g., LumbarCobbPP denotes the Cobb Angle of the thoracolumbar deformity in the patient plane.  
In the **Mizzou 3D SPinE** output file, (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Output)), one tab called “Merged Data” contains all the aggregated measurements, and a separate tab called “Data Dictionary” contains a data dictionary that defines all measures and indicates the appropriate color coding. 



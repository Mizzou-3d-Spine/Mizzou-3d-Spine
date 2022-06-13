# Mizzou 3D SPinE – Mizzou 3D SPine Extraction
A program used to extract measurements from EOS spine scans

# Content
- [Introduction](#Introduction)
- [Using Mizzou 3D SPinE](#Using-Mizzou-3D-SPinE)
  - [Step 1: Setup](#Step-1-Setup)
  - [Step 2: EOS File Preparation](#Step-2-EOS-File-Preparation)
  - [Step 3: Data Aggregations](#Step-3-Data-Aggregations)
- [Results](#Results)



# Introduction
**Mizzou 3D SPinE** is used to load the content from the  Detailed Report Excel file in“.xlsx” format, into R. 

The Detailed Report Excel file is composed of multiple tables within multiple Excel tabs; however, all available measurements are included in the Advanced tab of the Detailed Report Excel file.  Within this tab, the measurements for “Scoliosis parameters”, “Sagittal Balance”, “Vertebral Orientations” which includes frontal, lateral, and axial perspectives in both the patient and radio planes, “Intervertebral rotations” with frontal, lateral, and axial perspectives in the radio plane, “Pelvic parameters” for both the patient and Radio plane, and the “3D Tools”.  For each of these tables, the name of each parameter, along with the measured value, are extracted and then reformatted such that each variable label would be a variable name and then the measured value would be extracted as the value for that variable. This is also known as changing the format of the data to a “wide format”. 

The **Mizzou 3D SPinE** program does this by first locating the listed table and corresponding headers and then subsequently scans all measurements within that table, transforming all loaded variable names and measurements data into one formatted row of measurement values. This row of data, corresponding to one assessment for one patient is then concatenated into the formatted, compiled output that is exported as an Excel file. Assessments are concatenated by patient identifying number and date of assessment such that serial assessments for patients can be easily compiled. Any measurements which are missing or empty from the EOS Advanced Spine Workflow .xlsx file are skipped. 

# Using Mizzou 3D SPinE
This program is developed in R 4.1.2 with an R package “openxlsx” which will be automatically installed when this program is initially deployed. Before conducting data aggregations, users need to [download the R program](#Downloading-RStudio) and the [load the Function.R](#Loading-Mizzou-3D-SPinE) script, as well as getting the EOS file organized as described in the [EOS File Preparation](#Step-2-EOS-File-Preparation) section. [An example](https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Code/Mizzou%203D%20SPinE.R) of loading and running Mizzou 3D SPinE is available. [The example data](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data) of [organized EOS files](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Data) and the [merged outputs](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Output) are also provided.

## Step 1: Setup
### Downloading RStudio
Users can find and download RStudio Desktop at [https://www.rstudio.com](https://www.rstudio.com/products/rstudio/download/#download).

### Loading Mizzou 3D SPinE
The program can be loaded in R by copying the following codes in RStudio and **press Enter** to continue (Figure 1):
```r
if(!require("devtools")){
  install.packages("devtools")
}
devtools::source_url("https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Code/Function.R")
```

---
<p align="center">
    <em> Figure 1: Loading the Function.R program </em> 
</p>

<p align="center">
  <img src="https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Fig/Loading_Program.png" width="800">
</p>
---

Alternaltiavely, user can download the program "Function.R" by right clicking [here](https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Code/Function.R) and choose "save link as...". The program can be manually loaded with the following codes:
```r
source("FilePath/Function.R")
```
where "FilePath" denotes the local path where you saved the “Function.R” on your computer. 


## Step 2: EOS File Preparation
To use the Mizzou 3D SPinE, all EOS files of each assessment for each patient should be saved in one folder, named using the patient identifier. Then, the associated Detailed Report (.xslx file) for each EOS assessment for a patient must be placed within a subfolder, located within each patient folder, and should be named using the EOS assessment date using the “MM-DD-YYYY” format. The resulting file structure should be that all Detailed Report files associated with each patient-specific EOS assessment has its own folder, named using the date, and that these are all stored within the main folder for each patient, named using the numerical patient identifier (Figure 2). An example of the organized EOS files is available at [Example Data](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Data).

---
<p align="center">
    <em> Figure 2: EOS File Preparation </em>
</p>

<p align="center">
  <img src="https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Fig/EOS_Files.PNG" width="400">
</p>

---

Further, all patient assessments intended for extraction should be saved within a single parent folder, for example, “Test Data”, as shown in Figure 2.  The parent folder should not contain any files, data, or subfolders which do not result from the EOS Advanced Spine Workflow.  Empty folders should also not be saved within the parent folder. 

## Step 3: Data Aggregations
Once the EOS files have been organized, the data aggregations can be conducted by typying the following codes in RStudio and **press Enter** to process:

```r
datamerge()
```

This program would direct the user to specify the parent folder where the patientreports were saved  (Figure 3), and the output folder file path where user would like the aggregated data to be saved (Figure 4). The output folder must be outside of the parent folder. 

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

Once the input and output file locations have been specified, Mizzou 3D SPinE  will aggregate all data into a single file “MergedData_YYYYMMDD.xlsx” in the assigned output folder, where the “YYYYMMDD” corresponds to the date that the Mizzou 3D SPinE was run (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Output)).

# Results
Extracted measurements for each assessment are combined into one row; patients with multiple assessments will have each assessment appear in one row, indexed by visit date. In the output file, the aggregated measurements are color coded to denote the original table from which the measurement was extracted. Further, all variable names for extracted, measurements are named using the abbreviation from the table headers in the Detailed Report Excel file rom the EOS Advanced Spine Workflow. For example, all measurements from the “Scolisosis Parameters” table are colored salmon and the variable names have been defined using the location of the parameter, e.g., LumbarCobbPP denotes the Cobb angle of the thoracolumbar deformity in the patient plane. 

In the output file (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Test%20Output)), one tab contains all the aggregated measurements and a separate tab includes a data dictionary that defines all measures and indicates the appropriate color coding. 



# Mizzou 3D SPinE 
A program used to extract measurements from sterEOS Advanced Spine Workflow output

# Content
- [Introduction](#Introduction)
  - [Tutorial Videos](#Tutorial-Videos)
  - [Step 1: sterEOS Advanced Spine Workflow File Preparation](#Step-1-sterEOS-Advanced-Spine-Workflow-File-Preparation)
  - [Step 2: Setup](#Step-2-Setup)
  - [Step 3: Running Mizzou 3D SPinE](#Step-3-Running-Mizzou-3D-SPinE)
- [Understanding the Mizzou 3D SPinE Result File ](#Understanding-the-Mizzou-3D-SPinE-Result-File)
- [Troubleshooting/FAQ’s](#TroubleshootingFAQs)

# Introduction
**Mizzou 3D SPinE** is used to extract and organize measurement data taken from sterEOS Advanced Spine Workflow assessments.  **Mizzou 3D SPinE** is capable of extracting measurement data taken from multiple assessments for an individual and/or many individuals.
This file contains the measurements for 
  - Scoliosis Parameters
  - Sagittal Balance
  - Vertebral Orientations for the frontal, lateral, and axial views in both the patient and radio planes
  - Intervertebral rotations with frontal, lateral, and axial perspectives in the radio plane
  - Pelvic parameters for both the patient and Radio plane
  - 3D Tools  

For each of these sections, the name of each measurement, along with the measured value, are extracted, such that each measurement label is formatted as a column name and the measured value is extracted as the value for that column, in the resulting **Mizzou 3D SPinE** output file.  The output file is formatted such that each row of data, corresponds to one assessment for one individual; multiple assessments for one individual are organized by their participant id and date of assesmsent, in separate rows. Any measurements that are missing or empty from the sterEOS Advanced Spine Workflow .xlsx file are empty in the output file. 

## Tutorial Videos

[Step 1: Organizing Your sterEOS Advanced Spine Workflow Files](https://youtu.be/9gb7o3fIZZo)

[Step 2: Downloading R](https://youtu.be/Tnhar3ZZvso)

[Step 3: Running Mizzou 3D SPinE](https://youtu.be/TbqeDwD3G5g)


## Step 1: sterEOS Advanced Spine Workflow File Preparation
To use **Mizzou 3D SPinE**, files must be named and organized in a specified format.  All patient assessments, intended for use with the **Mizzou 3D SPinE** should be saved within a single parent folder, for example, “Test Data”, as shown in Figure 1.  The parent folder should not contain any files, data, or subfolders which are not output from the sterEOS Advanced Spine Workflow.  Empty folders should also not be saved within the parent folder. Within the parent folder, each patient should have a folder in which all files for each sterEOS assessment for that patient should be saved. This folder should be named using the patient identifier. Then, output files for each sterEOS assessment for each individual patient should be saved within a subfolder, named with the EOS assessment date using the “MM-DD-YYYY” format and located within each patient folder. The resulting file structure should be that all output files for the sterEOS Advanced Spine Workflow associated with each patient-specific sterEOS Advanced Spine Workflow assessment has its own folder, named using the date, and that these are all stored within the main folder for each patient, named using the numerical patient identifier (Figure 1). An example of the organized sterEOS Advanced Spine Workflow file is available at [Mizzou 3D SPinE Demo Patient Data](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Patient%20Data) ([Download the Example Data](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Patient%20Data.zip)).

---
<p align="center">
    <em> Figure 1: sterEOS File Preparation </em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Fig/FilePath.png" width="400">
</p>

---

## Step 2: Setup
### Downloading R
Users can find and download R Desktop at [https://www.r-project.org/](https://mirror.las.iastate.edu/CRAN/).

### Loading Mizzou 3D SPinE
Once the users open RStudio, it should appear like this (Figure 2):

---
<p align="center">
    <em> Figure 2: RStudio window </em> 
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Fig/R_Studio.png" width="800">
</p>
---


Then users could copy the following code and paste into R, then press the "Enter" key (Figure 3):


```r
if(!require("devtools")){
  install.packages("devtools")
}
devtools::source_url("https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Code/Function.R")

datamerge()
```

---
<p align="center">
    <em> Figure 3: Loading the Function.R program </em> 
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Fig/Loading_Program.PNG" width="800">
</p>

---


## Step 3: Running Mizzou 3D SPinE
This program directs the user to specify the parent folder where all sterEOS Advanced Spine Workflow patient assessments were saved (Figure 4), and the output folder file path where the user would like the aggregated data to be saved (Figure 5). The output folder must be outside of the parent folder. 

---
<p align="center">
    <em> Figure 4: Selecting the path of parent folder </em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Fig/Data_Aggregation_Input.PNG" width="600">
</p>

<p align="center">
    <em> Figure 5: Selecting the path of merged data </em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Fig/Data_Aggregation_Output.PNG" width="600">
</p>

---

Once the input and output file locations have been specified, **Mizzou 3D SPinE** will aggregate all data into a single file “MergedData_YYYYMMDD.xlsx” in the assigned output folder, where the “YYYYMMDD” corresponds to the date that the **Mizzou 3D SPinE** was run (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Output)).



# Understanding the Mizzou 3D SPinE Result File 
Extracted measurements for each sterEOS Advanced Spine Workflow assessment are combined into one row in the newly aggregated **Mizzou 3D SPineE** result file.  Patients with multiple assessments will have each assessment appear in one row, indexed by visit date.  The aggregated measurements are color coded to denote their original location in the sterEOS Advanced Spine Workflow file from which the measurement was extracted. Further, all variable names are named using the abbreviation from the location headers in the original sterEOS Advanced Spine Workflow Excel file.  For example, all measurements from “Scolisosis Parameters” are colored salmon and the variable names have been defined using the location of the parameter, e.g., LumbarCobbPP denotes the Cobb Angle of the thoracolumbar deformity in the patient plane.  
In the **Mizzou 3D SPinE** output file, (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Output)), one tab called “Merged Data” contains all the aggregated measurements, and a separate tab called “Data Dictionary” contains a data dictionary that defines all measures and indicates the appropriate color coding. 



# Troubleshooting/FAQ’s

### Can I put all my sterEOS files in one folder? 

No. The sterEOS Advanced Spine Workflow files must be organized in a specified structure. This structure is how the **Mizzou 3D SPineE** will recognize the patient or participant ID's and visit date to correctly merge the assessment files.  As noted in our publication, the time required to reconfigure and/or resave sterEOS files using this structure is minimal but is a necessary step to successfully aggregate the data in a consistent format. See the [Step 1: sterEOS Advanced Spine Workflow File Preparatio](#Step-1-sterEOS-Advanced-Spine-Workflow-File-Preparation) section for more details and follow the instructions in the tutorial videos [Step 1: Organizing Your sterEOS Advanced Spine Workflow Files](https://youtu.be/9gb7o3fIZZo).

### I can’t find the download files (*Function.R* and *Mizzou 3D SPinE.R* files). 

Navigate to your downloads folder and search there. If the **Mizzou 3D SPineE** is not located there, return to the GitHub site and retry downloading. Ensure you don’t have any pop-up blockers inhibiting the download.

### When I run the program, I get some error messages and no output is created. 
This can mean one of two things. 
First, double check that you **ONLY** have sterEOS files in the input folder and check that you have organized **ALL** sterEOS files following the instructions in the tutorial videos [Step 1: Organizing Your sterEOS Advanced Spine Workflow Files](https://youtu.be/9gb7o3fIZZo). Even one mistake in the file structure will prevent **Mizzou 3D SPineE** from working. 
Second, if your input/output directory is not selected properly, the **Mizzou 3D SPineE** won't be able to work. Check the tutorial video [Step 3: Running Mizzou 3D SPinE](#Step-3-Running-Mizzou-3D-SPinE) as noted. If you still have problems after reading the instructions and watching the tutorial videos, please email the **Mizzou 3D SPineE** administrator at mizzou3dspine@umsystem.edu and we will work with you directly.



## Mizzou 3D SPinE GUI - User Guide

### Table of Contents
1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [Instructions](#instructions)
   - [Tutorial Videos](#Tutorial-Videos)
   - [Step 1: File Preparation](#step-1-file-preparation)
   - [Step 2: Running Mizzou 3D SPinE](#step-2-Running-Mizzou-3D-SPinE)
4. [Troubleshooting/FAQ’s](#TroubleshootingFAQs)

## Overview
**Mizzou 3D SPinE** is used to automate the extraction and organization of measurement data taken from biplanar three-dimensional reconstructions.

## Prerequisites
- Ensure that you are running the application in a Windows system.
- Ensure that you have write permissions for the output directory.

## Instructions

Specifically, **Mizzou 3D SPinE** was developed using reconstructions using EOS™ III (Version 3.7.5.8463) with scan parameters (1) Full Spine, (2) Morphotype 1, (3) Scan Speed 4. The image sets were reconstructed using sterEOS and the resulting Advanced Spine Workflow Excel File (.xlsx file type) is the data source for **Mizzou 3D SPinE**. **Mizzou 3D SPinE** is capable of extracting measurement data taken from multiple assessments for an individual and/or many individuals. In the Advanced Spine Workflow Excel file, the following information is contained:

* Scoliosis Parameters
* Sagittal Balance
* Vertebral Orientations for the frontal, lateral, and axial views in both the patient and radio planes
* Intervertebral rotations with frontal, lateral, and axial perspectives in the radio plane
* Pelvic parameters for both the patient and Radio plane
* 3D Tools

In the output file for Mizzou 3D SPinE, the name of each measurement, along with the measured value, are extracted. The output file is organized such that each measurement label is formatted as a column name and the measured value is extracted as the value for that column. The output file is formatted such that each row of data corresponds to one assessment for one individual, and multiple assessments for one individual are organized by their participant ID and date of assessment, in separate rows. Any measurements that are missing or empty from the Advanced Spine Workflow .xlsx file are empty in the output file.

### Tutorial Videos

[Tutorial: Organizing Your Files](https://youtu.be/n68Wf7il6U4)

### Step 1: File Preparation

To use **Mizzou 3D SPinE**, all Excel Files data files generated from Full Spine 3D Reconstructions in sterEOS must be named and organized in a specified format. 

 - Each patient should have their own folder, and within that folder, each biplanar stereo-radiographic reconstruction assessment (.xlsx file) should have its own folder. All patient folders should be named using the patient identifier only in numerical format (Figure 1).  
 - The folder for each assessment should be renamed using the date of the assessment in the “MM-DD-YYYY” format. Note that using the date format as the file name allows **Mizzou 3D SPinE** to organize data from longitudinal biplanar stereo-radiographic reconstruction assessments. 
 - Then, all patient folders should be located within one folder, the "input" folder, which has no formatting requirement. The input folder should not contain any files, data, or subfolders which are not output from the biplanar stereo-radiography reconstructions. Empty folders should also not be saved within the input folder.
 - A separate output folder should be created, separate from and outside of the input folder. 

An example of the organized input folder is available at [Mizzou 3D SPinE Demo Patient Data](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Mizzou-3d-Spine-v1.0/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Patient%20Data) ([Download the Example Data](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/blob/main/Mizzou-3d-Spine-v1.0/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Patient%20Data.zip)).

---
<p align="center">
    <em> Figure 1: File Organization and example format </em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Mizzou-3d-Spine-v1.0/Fig/File_Path.png" width="400">
</p>

---


### Step 2: Running Mizzou 3D SPinE
Double click the **Mizzou 3D SPinE** icon and the main window of the GUI titled "Mizzou 3D SPinE" will appear on your screen (Figure 3). 

---
<p align="center">
    <em> Figure 2: GUI of Mizzou 3D SPinE </em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Mizzou-3d-Spine-v2.0/Fig/GUI.png" width="600">
</p>

---


This program will direct you to specify the input folder where all patient assessments were saved (Figure 3), and the output folder file path where you would like the aggregated data to be saved (Figure 4). The output folder **must** be outside of the input folder.

---
<p align="center">
    <em> Figure 3: Selecting the path of input folder </em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Mizzou-3d-Spine-v1.0/Fig/Data_Aggregation_Input.png" width="600">
</p>

<p align="center">
    <em> Figure 4: Selecting the path of merged data </em>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Mizzou-3d-Spine/Mizzou-3d-Spine/main/Mizzou-3d-Spine-v1.0/Fig/Data_Aggregation_Output.png" width="600">
</p>

---


#### Select Input Folder

1. **Locate the "Input Path" section**:
   - You will see a label named "Input Path:" followed by a text entry field and a "Browse" button.
2. **Set the Input Path**:
   - Click the "Browse" button next to the Input Path field.
   - A directory selection dialog will appear. Navigate to the folder containing the input data files you wish to merge.
   - Select the directory and click "OK". The path to the selected directory will automatically populate the "Input Path" entry field.

#### Select Output Folder

1. **Locate the "Output Path" section**:
   - You will see a label named "Output Path:" followed by a text entry field and a "Browse" button.
2. **Set the Output Path**:
   - Click the "Browse" button next to the Output Path field.
   - A directory selection dialog will appear. Navigate to the folder where you want the merged data to be saved.
   - Select the directory and click "OK". The path to the selected directory will automatically populate the "Output Path" entry field.

#### Select Apex Data *Optional

This field is **not required**. If you are only interested in the original data, you may skip this section and click the "Merge Data" button after selecting the Input and Output folders.

1. **Locate the "Apex Data File" section**:
   - You will see a label named "Apex Data File (Optional):" followed by a text entry field and a "Browse" button.
2. **Set the Apex Data**:
   - Click the "Browse" button next to the Apex Data File field.
   - A directory selection dialog will appear. Navigate to the Apex data file in .csv format.
   - Select the Apex data and click "OK". The path to the selected Apex data file will automatically populate the "Apex Data File" entry field.

**What is Apex data**

In addition to the original data, we also offer the option to retrieve measurements from one or two levels above and below the instrumented segment. The Apex data focuses on capturing and analyzing rotation measurements at specific spinal levels relative to the apex of the curvature. The data file should include:

* a column for the patient identifier (labeled "Patient ID"),
* a column for the visit date (labeled "Visit Date"), and
* two columns indicating the apex level, either in the thoracic (labeled "ApexT") or lumbar (labeled "ApexL") regions, with each segment identified by a label (e.g., "T1", "T2", ..., "L5").

The final output provides a comprehensive set of rotation values for each patient and visit, including measurements from the levels directly adjacent to and surrounding the apex, offering a detailed view of spinal curvature dynamics.')

Here is an example of Apex data

Table 1: Example of Apex Data

| Patient ID | Visit Date | ApexT | ApexL |
|------------|------------|-------|-------|
| 123        | 20220101   | T8    |       |
| 124        | 20220101   |       | L1    |
| 124        | 20220430   |       | L5    |
| 124        | 20220609   | T9    | L1    |


#### Merge the Data
1. **Initiate the Merge Process**:
   - Once both the Input and Output paths are correctly set, click the "Merge Data" button located at the bottom of the GUI.
2. **Processing**:
   - The GUI will verify that the specified paths are valid directories.
   - If both paths are valid, the data merge process will begin.
   - Upon successful completion, a message box will appear with the message "Data merge process has been completed successfully."
   - If either of the paths is invalid, an error message will be displayed prompting you to reselect valid directories.

All data will be aggregated into a single file “MergedData_YYYYMMDD.xlsx” in the assigned output folder, where the “YYYYMMDD” corresponds to the date that the **Mizzou 3D SPinE** was run (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Mizzou-3d-Spine-v1.0/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Output)).



#### Understanding the Mizzou 3D SPinE Result File

Extracted measurements for each biplanar three-dimensional reconstructions using sterEOS are combined into one row in the newly aggregated **Mizzou 3D SPinE** result file. Patients with multiple assessments will have each assessment appear in one row, indexed by visit date. The aggregated measurements are color coded to denote their original location in the assessment file from which the measurement was extracted. Further, all variable names are named using the abbreviation from the location headers in the original assessment file. For example, all measurements from “Scolisosis Parameters” are colored salmon and the variable names have been defined using the location of the parameter, e.g., LumbarCobbPP denotes the Cobb Angle of the thoracolumbar deformity in the patient plane.
In the **Mizzou 3D SPinE** output file, (see [output example](https://github.com/Mizzou-3d-Spine/Mizzou-3d-Spine/tree/main/Mizzou-3d-Spine-v1.0/Example%20Data/Mizzou%203D%20SPinE%20Demo%20Output)), one tab called “Merged Data” contains all the aggregated measurements, and a separate tab called “Data Dictionary” contains a data dictionary that defines all measures and indicates the appropriate color coding.



### Troubleshooting/FAQ’s

#### Can I put all my sterEOS files in one folder? 

No. The sterEOS Advanced Spine Workflow files must be organized in a specified structure. This structure is how the **Mizzou 3D SPineE** will recognize the patient or participant ID's and visit date to correctly merge the assessment files.  As noted in our publication, the time required to reconfigure and/or resave sterEOS files using this structure is minimal but is a necessary step to successfully aggregate the data in a consistent format. See the [Step 1: File Preparation](#Step-1-File-Preparation) section for more details and follow the instructions in the tutorial videos [Tutorial 1: Organizing Your Files](https://youtu.be/n68Wf7il6U4).

#### I can’t find the download files. 

Navigate to your downloads folder and search there. If the **Mizzou 3D SPineE** is not located there, return to the GitHub site and retry downloading. Ensure you don’t have any pop-up blockers inhibiting the download.

#### When I run the program, I get some error messages and no output is created. 
This can mean one of two things. 
First, double check that you **ONLY** have sterEOS files in the input folder and check that you have organized **ALL** sterEOS files following the instructions in the tutorial videos [Tutorial 1: Organizing Your Files](https://youtu.be/n68Wf7il6U4). Even one mistake in the file structure will prevent **Mizzou 3D SPineE** from working. 
Second, if your input/output directory is not selected properly, the **Mizzou 3D SPineE** won't be able to work. If you still have problems after reading the instructions and watching the tutorial videos, please email the **Mizzou 3D SPineE** administrator at mizzou3dspine@umsystem.edu and we will work with you directly.






# Main Function
datamerge <- function(InputPath = NULL, OutputPath = NULL){
  if(is.null(InputPath)){
    InputPath <- choose.dir(default = "", caption = "Select Input Filepath for the Parent Folder")
  }
  if(is.null(OutputPath)){
    OutputPath <- choose.dir(default = "", caption = "Select the Output Filepath for the Output File")
  }
  # Install the required packages
  if(!require("openxlsx")){
    install.packages("openxlsx")
  }
  # Initialization
  OutputData <- NULL
  # Patient ID
  Patient_IDs <- list.files(InputPath)
  for(Patient_ID in Patient_IDs){
    SubFolder <- paste0(InputPath, "/", Patient_ID)
    # Visit Number
    Visit_Nums <- list.files(SubFolder)
    # Load in Data
    for(Visit_Num in Visit_Nums){
      SubSubFolder <- paste0(SubFolder, "/", Visit_Num)
      FileNames <- list.files(SubSubFolder)
      FileName <- FileNames[grepl(".xlsx$", FileNames, ignore.case = TRUE)]
      
      ## Check if the data file is correct
      if(length(FileName)!=1){
        if(length(FileName)==0){
          stop(paste("There is no .xlsx file in folder", SubSubFolder))
        }
        else{
          stop(paste("There are more than one .xlsx files in folder", SubSubFolder))
        }
      }
      
      ## Create visit date
      Visit_Date <- strsplit(Visit_Num, "-")[[1]]
      if(length(Visit_Date)==3){
        Visit_Date <- paste0(Visit_Date[3], Visit_Date[1], Visit_Date[2])
      }
      else{
        Visit_Date <- Visit_Num
        warning(paste("The format of visit date", Visit_Num, "is incorrect for patient", Patient_ID,
                      "\n It should be MM-DD-YYYY"))
      }
      
      ## Load in original data
      InputData <- openxlsx::read.xlsx(paste0(SubSubFolder, "/", FileName),
                                       sheet = "Advanced",
                                       skipEmptyRows = TRUE,
                                       skipEmptyCols = TRUE)
      ### Remove empty columns with column names
      EmptyCol <- which(colSums(!is.na(InputData))==0)
      if(!is.null(EmptyCol)){
        InputData <- InputData[,-EmptyCol]
      }
      
      ## Find table location
      Table_Names <- c("Scoliosis parameters", 
                       "Sagittal balance", 
                       "Vertebral orientations",
                       "Intervertebral rotations",
                       "Pelvic parameters")
      Table_Start_Rows <- sapply(Table_Names, function(Table_Name){
        return(which(grepl(Table_Name, InputData[,1])))
      })
      ### Check the tables
      Table_Missing <- which(is.na(as.numeric(Table_Start_Rows)))
      if(length(Table_Missing) > 0){
        stop(paste("Table", 
                   names(Table_Start_Rows)[Table_Missing[1]], 
                   "does not exist in file", 
                   paste0(SubSubFolder, "/", FileName), 
                   "\n All tables should have the same starting column")
        )
      }
      
      ## Create table headers
      if(is.null(OutputData)){
        ### Table names
        Table_1_Header <- as.character(t(outer(as.character(t(outer(c("Lumbar", "Main", "Proximal"), 
                                                                    c("Cobb", "Apex"), 
                                                                    paste0))),
                                               c("", "PP", "RP"),
                                               paste0)))
        Table_2_Header <- as.character(t(outer(c("KyphosisT1", "KyphosisT4", 
                                                 "LordosisL5", "LordosisS1"),
                                               c("PP", "RP"),
                                               paste0)))
        Table_3_Header <- as.character(t(outer(c(paste0("RotationT", 1:12),
                                                 paste0("RotationL", 1:5)),
                                               as.character(t(outer(c("PP", "RP"),
                                                                    c("Frontal", "Lateral", "Axial"),
                                                                    paste0))),
                                               paste0)))
        Table_4_Header <- as.character(t(outer(paste0("IntervertebralRotation", 
                                                      paste0(c(paste0("T", 1:12), 
                                                               paste0("L", 1:4)), 
                                                             c(paste0("T", 2:12), 
                                                               paste0("L", 1:5)))
        ),
        as.character(t(outer(c("RP"),
                             c("Frontal", "Lateral", "Axial"),
                             paste0))),
        paste0)))
        Table_5_Header <- as.character(t(outer(c("PelvicIncidence", "SacralSlope", 
                                                 "PelvicTilt", "PelvicObliquity", "AxialPelvicRotation"),
                                               c("PP", "RP"),
                                               paste0)))
        ### Merge headers
        OutputData <- c("Patient ID",
                        "Visit Date",
                        Table_1_Header, 
                        Table_2_Header, 
                        Table_3_Header,
                        Table_4_Header,
                        Table_5_Header)
      }
      
      ## Extract data
      OutputDataUnit_Table_1 <- as.character(unlist(t(InputData[Table_Start_Rows[1]+1:6,1:3])))
      OutputDataUnit_Table_1 <- sapply(1:3, function(Table_1_i){
        if(grepl("^^Cobb", OutputDataUnit_Table_1[Table_1_i * 6 - 5])){
          Table_1_Part_1 <- c(paste0(strsplit(strsplit(OutputDataUnit_Table_1[Table_1_i * 6 - 5], 
                                                       "\\(|\\)")[[1]][2],
                                              "-")[[1]][1],
                                     "-",
                                     strsplit(strsplit(OutputDataUnit_Table_1[Table_1_i * 6 - 5], 
                                                       "\\(|\\)")[[1]][2],
                                              "-")[[1]][3]),
                              as.numeric(OutputDataUnit_Table_1[1:2 + Table_1_i * 6 - 5]))
          Table_1_Part_2 <- c(strsplit(strsplit(OutputDataUnit_Table_1[Table_1_i * 6 - 5], 
                                                "\\(|\\)")[[1]][2],
                                       "-")[[1]][2],
                              as.numeric(OutputDataUnit_Table_1[4:5 + Table_1_i * 6 - 5]))
          return(c(Table_1_Part_1, Table_1_Part_2))
        }
        else(return(rep(NA, 6)))
      })
      OutputDataUnit_Table_1 <- as.character(OutputDataUnit_Table_1)
      OutputDataUnit_Table_1 <- sapply(OutputDataUnit_Table_1, function(OutputDataUnit_Table_1_ele){
        paste(lapply(unlist(strsplit(x = OutputDataUnit_Table_1_ele,
                                     split = "(?<=[^0-9.])(?=\\d)|(?<=\\d)(?=[^0-9.])",
                                     perl=T)), 
                     function(x){
                       if(!is.na(suppressWarnings(as.numeric(x)))){
                         x <- as.numeric(x)
                       }
                       else{x}
                     }),
              collapse="")
      })
      
      OutputDataUnit_Table_2 <- c(as.character(unlist(t(InputData[Table_Start_Rows[2]+1:4,2:3]))),
                                  as.character(unlist(t(InputData[Table_Start_Rows[3]+1:17,2:7]))),
                                  as.character(unlist(t(InputData[Table_Start_Rows[4]+1:16,2:4]))),
                                  as.character(unlist(t(InputData[Table_Start_Rows[5]+1:5,2:3]))))
      #      OutputDataUnit_Table_2 <- as.numeric(OutputDataUnit_Table_2)
      OutputDataUnit_Table_2 <- sapply(OutputDataUnit_Table_2, function(OutputDataUnit_Table_2_ele){
        paste(lapply(unlist(strsplit(x = OutputDataUnit_Table_2_ele,
                                     split = "(?<=[^0-9.])(?=\\d)|(?<=\\d)(?=[^0-9.])",
                                     perl=T)), 
                     function(x){
                       if(!is.na(suppressWarnings(as.numeric(x)))){
                         x <- as.numeric(x)
                       }
                       else{x}
                     }),
              collapse="")
      })
      
      
      OutputDataUnit <- c(Patient_ID, Visit_Date, OutputDataUnit_Table_1, OutputDataUnit_Table_2)
      
      ## Merge
      OutputData <- rbind(OutputData, OutputDataUnit)
    }
  }
  
  # generate output
  wb <- openxlsx::createWorkbook()
  openxlsx::addWorksheet(wb, "Merged Data")
  openxlsx::writeData(wb, "Merged Data",
                      OutputData,
                      startCol = 1,
                      startRow = 1,
                      rowNames = FALSE,
                      colNames = FALSE)
  ## Cell styles
  Colors <- c("#E0E0E0", "#FFCCCC", "#FFFFCC", "#CCFFCC", "#CCFFFF", "#E5CCFF")
  CellCol <- c(2, 18, 8, 102, 48, 10)
  CellCol <- cbind(c(0, cumsum(CellCol)[1:5])+1,
                   cumsum(CellCol))
  for(OutputCells in 1:6){
    openxlsx::addStyle(wb, "Merged Data", 
                       openxlsx::createStyle(fgFill = Colors[OutputCells], textDecoration = "Bold"),
                       rows = 1, cols = CellCol[OutputCells,1]:CellCol[OutputCells,2], gridExpand = TRUE)
    
    openxlsx::addStyle(wb, "Merged Data", 
                       openxlsx::createStyle(fgFill = Colors[OutputCells]),
                       rows = 2:(nrow(OutputData)), cols = CellCol[OutputCells,1]:CellCol[OutputCells,2], gridExpand = TRUE)
  }
  
  # generate data dictionary
  Data_Dictionary <- data.frame(Table = c(c("Basic Information", " "),
                                          c("Scoliosis Parameters", rep(" ", 17)),
                                          c("Sagittal Balance", rep(" ", 7)),
                                          c("Vertebral Orientations", rep(" ", 101)),
                                          c("Intervertebral Rotations", rep(" ", 47)),
                                          c("Pelvic parameters", rep(" ", 9))
                                          ),
                                `Variable Names` = OutputData[1,],
                                Explanation = c("Patient ID, specified by the folder names",
                                                "Visit date, specified by the folder names",
                                                
                                                paste0(as.character(outer(c("", 
                                                                            "cobb angle of ", 
                                                                            "cobb angle of ", 
                                                                            "axial rotation of apical vertebra ",
                                                                            "axial rotation of apical vertebra ",
                                                                            "axial rotation of apical vertebra "), 
                                                                          paste0(c("lumbar", 
                                                                                   "main", 
                                                                                   "proximal"), 
                                                                                 " scoliosis"), 
                                                                          paste0)),
                                                       c(" parameters", 
                                                         " - patient plane", 
                                                         " - radio plane")),
                                                
                                                as.character(t(outer(c("T1/T12 kyphosis",
                                                                       "T4/T12 kyphosis",
                                                                       "L1/L5 lordosis",
                                                                       "L1/S1 lordosis"),
                                                                     c(" - patient plane", 
                                                                       " - radio plane"),
                                                                     paste0))),
                                                
                                                as.character(t(outer(c(paste0("T", 1:12, " rotation"),
                                                                       paste0("L", 1:5, " rotation")),
                                                                     as.character(outer(c(" - frontal",
                                                                                          " - lateral",
                                                                                          " - axial"),
                                                                                        c(" patient plane", 
                                                                                          " radio plane"),
                                                                                        paste0)),
                                                                     paste0))),
                                                
                                                as.character(t(outer(paste0(c(paste0("T", 1:12), 
                                                                              paste0("L", 1:4)),
                                                                            "-",
                                                                            c(paste0("T", 2:12), 
                                                                              paste0("L", 1:5)),
                                                                            " intervertebral rotation"),
                                                                     as.character(outer(c(" - frontal",
                                                                                          " - lateral",
                                                                                          " - axial"),
                                                                                        c(" radio plane"),
                                                                                        paste0)),
                                                                     paste0))),
                                                
                                                as.character(t(outer(c("pelvic incidence",
                                                                       "sacral slope",
                                                                       "pelvic tilt",
                                                                       "pelvic obliquity",
                                                                       "pelvis axial rotation"),
                                                                     c(" - patient plane", 
                                                                       " - radio plane"),
                                                                     paste0)))
                                                )
                                )
  openxlsx::addWorksheet(wb, "Data Dictionary")
  openxlsx::writeData(wb, "Data Dictionary",
                      Data_Dictionary,
                      startCol = 1,
                      startRow = 1,
                      rowNames = FALSE,
                      colNames = FALSE)
  for(OutputCells in 1:6){
    openxlsx::addStyle(wb, "Data Dictionary", 
                       openxlsx::createStyle(fgFill = Colors[OutputCells]),
                       rows = CellCol[OutputCells,1]:CellCol[OutputCells,2], 
                       cols = 1:3, 
                       gridExpand = TRUE)
  }
  
  # adjust cell width 
  openxlsx::setColWidths(wb, "Merged Data", cols = 1:ncol(OutputData), widths = "auto")
  openxlsx::setColWidths(wb, "Data Dictionary", cols = 1:3, widths = "auto")
  
  openxlsx::saveWorkbook(wb, 
                         file = paste0(OutputPath,
                                       "/MergedData_",
                                       gsub("-","",Sys.Date()),
                                       ".xlsx"), 
                         overwrite = TRUE)
}

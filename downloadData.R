function <- downloadData {
    # - Downloads the data from the url given below and stores it in the `current
    #   directory. 
    # - Unzipps the downloaded data using 7-zip utility (Windows 8)
    # - The unzipped files are placed into the `UCI HAR Data` folder.
    #   lists the files in that folder
    #

    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, file.path("./", "data.zip"))

    
    # Unzip using 7-zip utility on Windows 8:
    executable <- file.path("C:", "Program Files", "7-Zip", "7z.exe")
    cmd <- paste(paste0("\"", executable, "\""), "x", 
                 paste0("\"", file.path("./", "data.zip"), "\""))
    system(cmd)
    
    # The unzipped files are placed into the `UCI HAR Data` folder.
    path <- file.path("./", "UCI HAR Dataset") 
    list.files(path, recursive = TRUE)
}
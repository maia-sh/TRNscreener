library(xml2)

run_trial_identifier_search <- function(folder, save_file) {
    
    # The following will print out a CSV with one row per
    # clinical trial identifier found.
    
    # The first column of the output CSV contains the DOI
    # of the paper in which the identifier was found.
    
    # The second column indicates the type of identifier
    # e.g. NCT or ISRCTN. (More may be added)
    
    # The third column contains the identifier that was
    # found
    
    # The fourth column indicates whether the NCT number
    # corresponds to a legitimate record on
    # clinicaltrials.gov. 1 means yes, 0 means no, and
    # NA means that it is not an NCT number.
    
    # NOTE: The script checks whether an NCT number is
    # legit by connecting to the ClinicalTrials.gov API
    # so you will need an internet connexion for this to
    # work.
    
    # If you want to add new identifiers to be searched
    # Add them to this list
    identifiers <- list(
        c("NCT", "NCT[0-9 -]+[0-9]"),
        c("ISRCTN", "ISRCTN[0-9 -]+[0-9]")
    )
    # End of list of identifiers to search for
    
    print("Identifying trials ...")
    
    text_list <- paste0(folder, list.files(folder))
    
    new_row <- data.frame("doi", "type", "identifier", "clinicaltrials.gov")
    write_csv(new_row, save_file, append=TRUE)
    
    for ( identifier in identifiers ) {
        
        print(paste("Searching for", identifier[1], "identifiers"))
        
        for(filename in text_list) {
            
            file_doi <- str_replace(
                str_replace(
                    strsplit(filename, "/")[[1]][length(strsplit(filename, "/")[[1]])],
                    ".txt", ""
                ),
                "\\+", "\\/"
            )
            
            text <- readChar(filename, file.info(filename)$size)
            
            idmatches <- regmatches(text, gregexpr(identifier[2], text))
            
            if (length(idmatches[[1]]) > 0) {
                
                # Remove the spaces and hyphens from matches
                
                cleaned_matches <- c()
                
                print(file_doi)
                
                for (idmatch in idmatches[[1]]) {
                    
                    idmatch <- str_remove_all(idmatch, " ")
                    idmatch <- str_remove_all(idmatch, "-")
                    
                    cleaned_matches <- c(cleaned_matches, idmatch)
                    
                }
                
                cleaned_matches <- unique(cleaned_matches)
                
                if ( identifier[1] == "NCT") { # If it's an NCT number, check that it exists on CT dot gov
                    
                    for (idmatch in cleaned_matches) {
                        
                        temp <- tempfile()
                        
                        download.file(
                            paste0("https://clinicaltrials.gov/api/query/full_studies?expr=", idmatch),
                            temp
                        )
                        
                        xml <- read_xml(temp)
                        
                        unlink(temp)
                        
                        if (xml_text(xml_find_all(xml, "/FullStudiesResponse/NStudiesFound")) != "0") {
                            new_row <- data.frame(file_doi, identifier[1], idmatch, 1)
                        } else {
                            new_row <- data.frame(file_doi, identifier[1], idmatch, 0)
                        }
                        write_csv(new_row, save_file, append=TRUE)
                    }
                    
                } else { # It's not an NCT number that we're looking at, so we won't check for it on CT dot gov
                    for (idmatch in cleaned_matches) {
                        new_row <- data.frame(file_doi, identifier[1], idmatch, "NA")
                        write_csv(new_row, save_file, append=TRUE)
                    }
                }
                
            }
            
        }
        
    }
    
}

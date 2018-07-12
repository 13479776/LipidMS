# getInclusionList
#' Obtain an inclusion list from the annotation results
#'
#' Obtain an inclusion list from the annotation results.
#'
#' @param results data frame. Output of identification functions.
#' @param adductsTable data frame with the adducts allowed and their mass
#' difference.
#'
#' @return Data frame with 6 columns: formula, RT, neutral mass, m/z, adduct
#' and the compound name.
#'
#' @examples
#' \donttest{results <- idPOS(LipidMS::serum_pos_fullMS, LipidMS::serum_pos_Ce20,
#' LipidMS::serum_pos_Ce40)
#' getInclusionList(results$results)}
#'
#' @author M Isabel Alcoriza-Balaguer <maialba@alumni.uv.es>
getInclusionList <- function(results, adductsTable = LipidMS::adductsTable){
  Form_Mn <- apply(results, 1, getFormula)
  if (class(Form_Mn) == "matrix"){
    new <- list()
    for (i in 1:ncol(Form_Mn)){
      new[[i]] <- c(Form_Mn[1,i], Form_Mn[2,i])
    }
    Form_Mn <- new
  }
  na <- which(unlist(lapply(Form_Mn, length)) == 0)
  if (length(na) > 0){
    Form_Mn[[na]] <- c(NA, NA)
  }
  Formula <- unlist(lapply(Form_Mn, "[[", 1))
  RT <- results$RT
  Mn <- as.numeric(unlist(lapply(Form_Mn, "[[", 2)))
  adducts <- sapply(as.vector(results$Adduct), strsplit, ";")
  mzs <- rep(list(vector()), nrow(results))
  for (i in 1:nrow(results)){
    ad <- adducts[[i]]
    for (a in 1:length(ad)){
      adinfo <- adductsTable[adductsTable$adduct == ad[a],]
      mz <- (adinfo$n*Mn[i]+adinfo$mdif)/abs(adinfo$charge)
      mzs[[i]] <- append(mzs[[i]], mz)
    }
  }
  Name <- results$ID
  inclusionList <- vector()
  for (i in 1:nrow(results)){
    for (a in 1:length(adducts[[i]])){
      inclusionList <- rbind(inclusionList, data.frame(Formula[i], RT[i], Mn[i],
        mzs[[i]][a], adducts[[i]][a], Name[i], stringsAsFactors = F))
    }
  }
  colnames(inclusionList) <- c("Formula", "RT", "Mn", "m.z", "Adduct", "Name")
  return(inclusionList)
}
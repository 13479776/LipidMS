% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coelutingFrags.R
\name{coelutingFrags}
\alias{coelutingFrags}
\title{Coeluting fragments extraction}
\usage{
coelutingFrags(rt, df, rttol)
}
\arguments{
\item{rt}{numeric vector indicating candidates RT. This information comes
from the output of \link{findCandidates} (candidates$RT).}

\item{df}{data frame containing the peaks to subset (MSMS).}

\item{rttol}{rt window in seconds.}
}
\value{
List of data frames with the coeluting fragments for each candidate.
}
\description{
Given a RT and a list of peaks, this function subsets all coeluting fragments
within a rt windows. It is used by identification functions to extract
coeluting fragments from high energy functions for candidate precursor ions.
}
\examples{
\donttest{
dbs <- list(pgdb = LipidMS::pgdb, lysopgdb = LipidMS::lysopgdb,
fadb = LipidMS::fadb, adductsTable = LipidMS::adductsTable)

candidates <- findCandidates(MS1 = LipidMS::mix_neg_fullMS, dbs[["pgdb"]],
ppm = 10, rt = c(min(MS1$RT), max(MS1$RT)), adducts = c("M-H"),
rttol = 3, dbs)

MSMS <- rbind(LipidMS::mix_neg_Ce20, LipidMS::mix_neg_Ce40)
coelfrags <- coelutingFrags(candidates$RT, MSMS, rttol)
}

}
\author{
M Isabel Alcoriza-Balaguer <maialba@alumni.uv.es>
}
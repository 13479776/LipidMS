% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/idMGpos.R
\name{idMGpos}
\alias{idMGpos}
\title{Monoacylglycerol (MG) annotation for ESI+}
\usage{
idMGpos(MS1, MSMS1, MSMS2, ppm_precursor = 5, ppm_products = 10,
  rttol = 3, rt, adducts = c("M+H-H2O", "M+NH4", "M+Na"),
  clfrags = c(), clrequired = c(), ftype = c(), coelCutoff = 0.8,
  dbs)
}
\arguments{
\item{MS1}{list with two data frames cointaining all peaks from the full MS
function ("peaklist" data frame) and the raw MS scans data ("rawScans" data
frame). They must have four columns: m.z, RT (in seconds), int (intensity)
and peakID (link between both data frames). "rawScans" data frame also needs
a extra column named "Scan", which indicates the scan order number. Output
of \link{dataProcessing} function. In case no coelution score needs to be
applied, this argument can be just the peaklist data frame.}

\item{MSMS1}{list with two data frames cointaining all peaks from the high
energy function ("peaklist" data frame) and the raw MS scans data ("rawScans"
data frame). They must have four columns: m.z, RT (in seconds), int (intensity)
and peakID (link between both data frames). "rawScans" data frame also needs
a extra column named "Scan", which indicates the scan order number. Output
of \link{dataProcessing} function. In case no coelution score needs to be
applied, this argument can be just the peaklist data frame.}

\item{MSMS2}{list with two data frames cointaining all peaks from a second high
energy function ("peaklist" data frame) and the raw MS scans data ("rawScans"
data frame). They must have four columns: m.z, RT (in seconds), int (intensity)
and peakID (link between both data frames). "rawScans" data frame also needs
a extra column named "Scan", which indicates the scan order number. Output
of \link{dataProcessing} function. In case no coelution score needs to be
applied, this argument can be just the peaklist data frame. Optional.}

\item{ppm_precursor}{mass tolerance for precursor ions. By default, 5 ppm.}

\item{ppm_products}{mass tolerance for product ions. By default, 10 ppm.}

\item{rttol}{total rt window for coelution between precursor and product
ions. By default, 3 seconds.}

\item{rt}{rt range where the function will look for candidates. By default,
it will search within all RT range in MS1.}

\item{adducts}{expected adducts for MG in ESI+. Adducts allowed can
be modified in adductsTable (dbs argument).}

\item{clfrags}{vector containing the expected fragments for a given lipid
class. See \link{checkClass} for details.}

\item{clrequired}{logical vector indicating if each class fragment is
required or not. If any of them is required, at least one of them must be
present within the coeluting fragments. See \link{checkClass} for details.}

\item{ftype}{character vector indicating the type of fragments in clfrags.
It can be: "F" (fragment), "NL" (neutral loss) or "BB" (building block).
See \link{checkClass} for details.}

\item{coelCutoff}{coelution score threshold between parent and fragment ions.
Only applied if rawData info is supplied. By default, 0.8.}

\item{dbs}{list of data bases required for annotation. By default, dbs
contains the required data frames based on the default fragmentation rules.
If these rules are modified, dbs may need to be supplied. See \link{createLipidDB}
and \link{assignDB}.}
}
\value{
List with MG annotations (results) and some additional information
(class fragments and chain fragments).
}
\description{
MG identification based on fragmentation patterns for LC-MS/MS AIF data
acquired in positive mode.
}
\details{
\code{idMGpos} function involves 2 steps. 1) FullMS-based
identification of candidate MG as M+H-H2O, M+NH4 and M+Na. 2) Search of
MG class fragments if any is assigned.

Results data frame shows: ID, class of lipid, CDB (total number
of carbons and double bounds), FA composition (specific chains composition if
it has been confirmed), mz, RT (in seconds), I (intensity, which comes
directly from de input), Adducts, ppm (m.z error), confidenceLevel (in this
case, just MS-only or Subclass level (if any class fragment is defined) are
possible) and PFCS (parent-fragment coelution score mean of all fragments used
for the identification).
}
\note{
Isotopes should be removed before identification to avoid false
positives.
This function has been writen based on fragmentation patterns observed for
two different platforms (QTOF 6550 from Agilent and Sinapt G2-Si from Waters),
but it may need to be customized for other platforms or acquisition settings.
}
\examples{
\donttest{
library(LipidMSdata)
idMGpos(MS1 = MS1_pos, MSMS1 = MSMS1_pos, MSMS2 = MSMS2_pos)
}

}
\author{
M Isabel Alcoriza-Balaguer <maialba@alumni.uv.es>
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/LC.R
\name{mortcast}
\alias{mortcast}
\title{Coherent Rotated Lee-Carter Prediction}
\usage{
mortcast(e0m, e0f, lc.pars, rotate = TRUE, keep.lt = FALSE)
}
\arguments{
\item{e0m}{A time series of future male life expectancy.}

\item{e0f}{A time series of future female life expectancy.}

\item{lc.pars}{A list of coherent Lee-Carter parameters with elements \code{bx}, \code{ultimate.bx},
\code{female} and \code{male} as returned by \code{\link{lileecarter.estimate}}. 
The \code{female} and \code{male} objects are again lists that should contain a vector
\code{ax} and optionally a matrix \code{axt} if the \eqn{a_x} parameter 
needs to be defined as time dependent. In such a case, rows are age groups and columns are 
time periods corresponding to the length of the \code{e0f} and \code{e0m} vectors.}

\item{rotate}{If \code{TRUE} the rotation method of \eqn{b_x} is used as described in Li et al. (2013).}

\item{keep.lt}{Logical. If \code{TRUE} additional life table columns are kept in the 
resulting object.}
}
\value{
List with elements \code{female} and \code{male}, each of which contains a matrix \code{mx}
    with the predicted mortality rates. If \code{keep.lt} is \code{TRUE}, it also 
    contains matrices \code{sr} (survival rates), and life table quantities \code{Lx} and \code{lx}.
}
\description{
Predict age-specific mortality rates using the coherent rotated Lee-Carter method.
}
\details{
This function implements Steps 6-9 of Algorithm 2 in Sevcikova et al. (2016). 
    It uses an abridged life table function to find the level of mortality that coresponds to the given 
    life expectancy.
}
\examples{
data(mxM, mxF, e0Fproj, e0Mproj, package = "wpp2017")
country <- "Brazil"
# estimate parameters from historical mortality data
mxm <- subset(mxM, name == country)[,4:16]
mxf <- subset(mxF, name == country)[,4:16]
rownames(mxm) <- rownames(mxf) <- c(0,1, seq(5, 100, by=5))
lc <- lileecarter.estimate(mxm, mxf)
# project into future
e0f <- as.numeric(subset(e0Fproj, name == country)[-(1:2)])
e0m <- as.numeric(subset(e0Mproj, name == country)[-(1:2)])
pred <- mortcast(e0m, e0f, lc)
# plot first projection in black and the remaining ones in grey 
plot(pred$female$mx[,1], type="l", log="y", ylim=range(pred$female$mx),
    ylab="female mx", xlab="Age", main=country)
for(i in 2:ncol(pred$female$mx)) lines(pred$female$mx[,i], col="grey")

}
\references{
Li, N., Lee, R. D. and Gerland, P. (2013). Extending the Lee-Carter method to model the rotation 
of age patterns of mortality decline for long-term projections. Demography, 50, 2037-2051.

Sevcikova H., Li N., Kantorova V., Gerland P., Raftery A.E. (2016). 
Age-Specific Mortality and Fertility Rates for Probabilistic Population Projections. 
In: Schoen R. (eds) Dynamic Demographic Analysis. The Springer Series on Demographic Methods
and Population Analysis, vol 39. Springer, Cham
}
\seealso{
\code{\link{rotate.leecarter}}, \code{\link{leecarter.estimate}}, \code{\link{lileecarter.estimate}}
}

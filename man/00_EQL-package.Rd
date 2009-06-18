\name{EQL-package}
\alias{EQL-package}
\alias{EQL}
\docType{package}
\title{
Extended Quasi-Likelihood Function (EQL)
}
\description{
  The package \pkg{EQL} contains functions for
  \itemize{
    \item computation of the EQL for a given family of variance
    functions
    \item Edgeworth approximations
    \item Saddlepoint approximations
    \item related auxiliary functions (e.g. Hermite polynomials)}
  
   See section \sQuote{Index} for a list of exported functions. Section
   \sQuote{Internals} lists the internal functions of the package, which
   are not exported but may be referenced by
   \code{EQL:::.functionName}. 
}
\details{
  \tabular{ll}{
    Version: \tab 1.0-0\cr
    Date: \tab 2009-06-18\cr
    Depends: \tab ttutils(>= 0.1-0)\cr
    Imports: \tab lattice(>= 0.17-17)\cr
    License: \tab GPL-2\cr
    Built: \tab R 2.8.1; ; 2009-06-22 15:24:08; unix\cr
  }
}
\section{Index}{
  \tabular{ll}{
    \code{\link{approximation}} \tab : Approximation class\cr
    \code{\link{cumulants}} \tab : Cumulant class for the saddlepoint
    approximation\cr
    \code{\link{edgeworth}} \tab : Edgeworth approximation\cr
    \code{\link{eql}} \tab : Maximization of the \acronym{EQL}
    function for a particular\cr
    \tab : variance family for a given set of parameters \cr
    \code{\link{extBinomialVarianceFamily}} \tab : Extended binomial
    variance family (\eqn{V(\mu)=\mu^k(1-\mu)^l}{V(mu)=mu^k*(1-mu)^l}) \cr
    \code{\link{gammaCumulants}} \tab : Cumulant functions of the
    Gamma distribution \cr
    \code{\link{gaussianCumulants}} \tab : Cumulant functions of the
    normal distribution \cr
    \code{\link{hermite}} \tab : Hermite polynomials\cr
    \code{\link{inverseGaussianCumulants}} \tab : Cumulant functions of the
    inverse-gaussian distribution \cr
    \code{\link{powerVarianceFamily}} \tab : Power variance family
    (\eqn{V(\mu)=\mu^\theta}{V(mu)=mu^theta})  \cr
    \code{\link{saddlepoint}} \tab : Saddlepoint approximation \cr
    \code{\link{varianceFamily}} \tab : Variance family class
  }
}
\section{Internals}{
  \tabular{ll}{
    \code{.eql} \tab : Computes a single EQL value\cr
    \code{.getFactor} \tab : Calculates the normalizing factor for the
    saddlepoint approximation\cr
    \code{.missingFormals} \tab : Check if a list contains all the
    arguments of a particular function
  }
}
\author{
  Thorn Thaler <thorn.thaler@thothal.com>
  
  Maintainer: Thorn Thaler <thorn.thaler@thothal.com>
}
\keyword{ package }
\seealso{\pkg{\link[ttutils]{ttutils}}}


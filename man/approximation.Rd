\name{approximation}
\alias{approximation}
\alias{plot.approximation}
\title{An Approximation Class}
\description{
 An object of class \code{approximation} stores the approximation nodes
 together with the approximation itself. Some meta information is saved
 as well.
}
\usage{
approximation(y, approx, n,
              type = c("standardized", "mean", "sum"),
              approx.type = c("Edgeworth", "Saddlepoint"))

\method{plot}{approximation}(x, do.annotate = TRUE, \dots) 
}
\arguments{
  \item{y}{a numeric vector or array giving the approximation nodes.}
  \item{approx}{a numeric vector or array giving the approximated values
    at \code{y}.}
  \item{n}{a positive integer giving the number of i.i.d. random
    variables in the sum.}
  \item{type}{a character string giving the type of approximation,
    i.e. which kind of sum is to be approximated. Must be one
    of (\dQuote{standardized}, \dQuote{mean}, \dQuote{sum}),
    representing the shifted and scaled sum, the weighted sum and the
    raw sum. Can be abbreviated.}
  \item{approx.type}{a character string giving the approximation routine
    used. Must be one of of (\dQuote{Edgeworth}, \dQuote{Saddlepoint}) and
    can be abbreviated.}


  \item{x}{an \code{approximation} object.}
  \item{do.annotate}{logical. If \code{TRUE} (the default) the value of
    the argument \code{n} is added to the plot.}
  \item{\dots}{other parameters to be passed through to the plotting
    function. Giving a named argument for any of
    \itemize{
      \item \code{main}
      \item \code{sub}
      \item \code{type}
      \item \code{xlab}
      \item \code{ylab}
    }
    overrides the default values in \code{plot.approximation}.
  }
}
\value{
  An object of class \code{approximation} contains the following components:
  \item{y}{a numeric vector of values at which the
    approximation is evaluated (the approximation nodes).}
  \item{approx}{a numeric vector containing the approximated values at
    the approximation nodes \code{y}.}
  \item{type}{a character string giving the type of sum considered,
    i.e. one of (\dQuote{standardized}, \dQuote{mean}, \dQuote{sum}).}
  \item{n}{a positive integer giving the number of i.i.d. random
    variables in the sum.}
  \item{approx.type}{a character string giving the type of
    approximation.}
}
\author{Thorn Thaler}
\seealso{\code{\link{edgeworth}}, \code{\link{saddlepoint}}}


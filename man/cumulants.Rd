\name{cumulants}
\alias{cumulants}
\alias{gammaCumulants}
\alias{gaussianCumulants}
\alias{inverseGaussianCumulants}
\alias{check.cumulants}
\title{Cumulants Class For Saddlepoint Approximations}
\description{
A \code{cumulants} object contains all the cumulant functions that are needed to
calculate the saddlepoint approximation.

The predefined functions
\itemize{
  \item \code{gammaCumulants},
  \item \code{gaussianCumulants} and
  \item \code{inverseGaussianCumulants}
}
compute the cumulant functions for the normal, gamma and inverse
gaussian distribution, respectively.
}
\usage{
cumulants(saddlef, cgf = NULL, kappa2f = NULL, rho3f = NULL,
          rho4f = NULL, cgf.deriv = NULL,
          domain = interval(-Inf, Inf), \dots)

gammaCumulants(shape, scale)
gaussianCumulants(mu, sigma2)
inverseGaussianCumulants(lambda, nu)

\method{check}{cumulants}(object, \dots)
}
\arguments{
  \item{saddlef}{the saddlepoint function. Corresponds to the inverse of
  the first derivative of the cumulant generating function (\acronym{cgf}).}
  \item{cgf, cgf.deriv}{\code{cgf} is the cumulant generating
    function. If \code{NULL} (the default),  it will be derived from
    \code{cgf.deriv} (the generic derivative function of  the cgf).}
  \item{kappa2f}{the variance function. If \code{NULL} (the default), it will be
    derived from the function \code{cgf.deriv}.}
  \item{rho3f, rho4f}{the 3rd and the 4th standardized cumulant function,
    respectively. If \code{NULL} (the default), the functions will be
    derived from \code{cgf.deriv} if supplied. If neither the cumulants
    nor \code{cgf.deriv} are supplied, a warning will be 
    displayed and a flag is set in the output. In this case, saddlepoint
    approximations cannot make use of the correction term (see
    \code{\link{saddlepoint}} for further details).}
  \item{domain}{an object of type \code{interval} giving the domain of
    the random variable. Will be needed to calculate the normalizing
    factor. See \code{\link[ttutils]{interval}} for further
    information.}
  \item{\dots}{additional parameters to be passed to the cumulant
    functions, respectively function \code{check}.
    See section \sQuote{Details} for further information.}
  \item{shape, scale}{shape and scale parameter for the gamma
    distribution.}
  \item{mu, sigma2}{mean and variance parameter for the normal
    distribution.}
  \item{lambda, nu}{parameters for the inverse Gaussian distribution.}
  \item{object}{an object to be tested whether or not it meets the
    formal requirements.}
}
\details{
  Basically, there are two ways to specify the cumulant functions using
  \code{cumulants}. The first one is to specify each of the following
  functions seperately:
  \itemize{
    \item \code{cgf}
    \item \code{kappa2f}
    \item \code{rho3f}
    \item \code{rho4f}
  }

  Since the functions may (and probably will) depend on some additional
  parameters, it is necessary to include these parameters in the
  respective argument lists. Thus, these additional parameters
  must be passed to \code{cumulants} as \emph{named} parameters as
  well. To be more specific, if one of the above functions has an extra
  parameter \code{z}, say, the particular value of \code{z} must be
  passed to the function \code{cumulants} as well (see the example). In
  any case, the first argument of the cumulant functions must be the
  value at which the particular function will be evaluated. 

  The other way to specify the cumulant functions is to specify the
  generic derivative of the \acronym{cgf} \code{cgf.deriv}. Its first
  argument  must be the order of the derivative and its second the value
  at which it should be evaluated, followed by supplementary
  arguments. \code{cgf.deriv} must be capable to return the
  \acronym{cgf} itself, which corresponds to the zeroth derivative.

  The function \code{cumulants} performs a basic check to test if all
  needed additional parameters are supplied and displays a warning if
  there are extra arguments in the cumulant functions, which are not
  specified.

  The generic function \code{check} for the class \code{cumulants} tests if 
  \itemize{
    \item an object has the same fields as an \code{cumulants} object
    and 
    \item the cumulant functions are properly vectorized, i.e. if they
    return a vector whenever the argument is a vector.
  }
}
\note{
  If it happens that one of the cumulant functions \code{f}, say, does
  not need any extra arguments while the others do, one have to define
  these extra arguments for \code{f} nonetheless. The reason is that
  \code{cumulants} passes any additional arguments to all defined
  cumulant functions and it would end up in an error, if a function is
  not capable of dealing with additional arguments.

  Hence, it is good practice to define all cumulant functions for the
  same set of arguments, needed or not. An alternative is to add
  \code{\dots} to the argument list in order to absorb any additional
  arguments.

  The functions must be capable of handling vector input properly.

  Supplementary arguments \emph{must not} be named similar to the arguments of
  \code{cumulants} (especially any abbreviation must be avoided),
  for the argument matching may match an argument (thought to be an extra
  argument for one of the cumulant function) to an argument of
  \code{cumulants}. The same problem may arise, if additional cumulant
  function parameters are not named.
}
\value{
  \code{cumulants} returns an object of class \code{cumulants}
  containing the following components:

  \item{K}{the cumulant function.}
  \item{mu.inv}{the saddlepoint function.}
  \item{kappa2}{the variance function.}
  \item{rho3, rho4}{the 3rd and the 4th standardized cumulant functions.}
  \item{domain}{an interval giving the domain of the random variable.}
  \item{extra.params}{extra parameter passed to \code{cumulants},
    typically parameters of the underlying distribution.}
  \item{type}{character string equating either to \dQuote{explicit} or
    \dQuote{implicit} indicating whether the cumulant functions were
    passed explicitly or were derived from the generic derivative of
    the \acronym{cgf}.}
  \item{missing}{logical. If \code{TRUE}, the 3rd and/or the 4th
    cumulant function were not defined.}

  \code{gammaCumulants}, \code{gaussianCumulants} and
  \code{inverseGaussianCumulants} return a \code{cumulants} object
  representing the cumulant functions of the particular distribution.
}
\references{
  Reid, N. (1991).  Approximations and Asymptotics. \emph{Statistical
    Theory and Modelling}, London: Chapman and Hall.
}
\author{Thorn Thaler}
\seealso{\code{\link{edgeworth}},
  \code{\link{saddlepoint}}}
\examples{
# Define cumulant functions for the normal distribution

saddlef <- function(x, mu, sigma2) (x-mu)/sigma2
cgf <- function(x, mu, sigma2) mu*x+sigma2*x^2/2

\dontrun{

# cgf, saddlef, kappa2, rho3 and rho4 must have the same argument lists! 
# Functions are _not_ properly vectorized!
kappa2 <- function(x, sigma2) sigma2 
rho3 <- function(x) 0                 
rho4 <- function(x) 0

cc <- cumulants(saddlef, cgf, kappa2, rho3, rho4, mu=0, sigma2=1)

check(cc) # FALSE

}

kappa2 <- function(x, mu, sigma2)
    rep(sigma2, length(x)) 
rho3 <- function(x, mu, sigma2)   # or function(x, ...)
    rep(0, length(x))        
rho4 <- function(x, mu, sigma2)   # or function(x, ...)
    rep(0, length(x))        

cc <- cumulants(saddlef, cgf, kappa2, rho3, rho4, mu=0, sigma2=1)

cc$K(1:2)       # 0.5 2
cc$kappa2(1:2)  # 1 1
cc$mu.inv(1:2)  # 1 2
cc$rho3(1:2)    # 0 0
cc$rho4(1:2)    # 0 0

check(cc) # TRUE

# The same using the generic derivative of the cgf

K.deriv <- function(n, x, mu, sigma2) {
  if (n <= 2) {
    switch(n + 1,
           return(mu * x + sigma2 * x ^ 2 / 2), # n == 0
           return(mu + sigma2 * x),             # n == 1
           return(rep(sigma2, length(x))))      # n == 2
  } else {
    return(rep(0, length(x)))                   # n >= 3
  }
}

cc <- cumulants(saddlef, cgf.deriv=K.deriv, mu=0, sigma2=1)

cc$K(1:2)       # 0.5 2
cc$kappa2(1:2)  # 1 1
cc$mu.inv(1:2)  # 1 2
cc$rho3(1:2)    # 0 0
cc$rho4(1:2)    # 0 0

check(cc) # TRUE

# The same using a predefined function
cc <- gaussianCumulants(0, 1)

cc$K(1:2)       # 0.5 2
cc$kappa2(1:2)  # 1 1
cc$mu.inv(1:2)  # 1 2
cc$rho3(1:2)    # 0 0
cc$rho4(1:2)    # 0 0

check(cc) # TRUE

}

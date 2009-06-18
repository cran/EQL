\name{varianceFamily}
\alias{varianceFamily}
\alias{powerVarianceFamily}
\alias{extBinomialVarianceFamily}
\title{Variance Family Class For The EQL-Method}
\description{
  \code{varianceFamily} provides a class for a parameterized family of
  variance functions to be used with \code{\link{eql}}.

  The predefined functions \code{powerVarianceFamily} and
  \code{extBinomialVarianceFamily} compute the variance family defined
  by the parametric variance functions \eqn{V_\theta(\mu) =
  \mu^\theta}{V(mu;theta) = mu^theta} and \eqn{V_{k,l}(\mu) =
  \mu^k(1-\mu)^l}{V(mu;k,l) = mu^k*(1-mu)^l}, respectively.
}
\usage{
varianceFamily(varf, devf = NULL, link = "log", initf = NULL,
               validmuf = NULL, name = "default")

powerVarianceFamily(link = "log")
extBinomialVarianceFamily(link = "logit")
}
\arguments{
  \item{varf}{the parameterized variance function.}
  \item{devf}{the deviance function. If \code{NULL} (the default) it
    will be determined numerically from the variance function \code{varf}.}
  \item{link}{the link function.}
  \item{initf}{a function returning an object of class
    \code{expression}. The \code{expression} object should give a
    sequence of initializing commands for the \code{\link{glm}} routine
    such as setting the  starting values. If \code{NULL} (the default),
    a very rudimentary initialize function is  chosen, which may not be
    appropriate. See \code{\link{family}} for further details.}
  \item{validmuf}{a function giving \code{TRUE} if its argument is a
    valid value for \eqn{\mu}{mu} and \code{FALSE} otherwise. If
    \code{NULL} (the default), all \eqn{\mu}{mus} are supposed to be
    valid.}
  \item{name}{a character string giving the name of the variance family.}
}
\details{The purpose of the function \code{varianceFamily} is to provide a
  convenient way to specify families of variance functions. An extended
  glm \code{\link{family}} object for a particular choice of a parameter
  vector can be obtained via the class member \code{family}.

  The minimal specification for a \code{varianceFamily} object is the
  variance function \eqn{V_\theta(\mu)}{V(mu;theta)} with
  \eqn{\theta}{theta} describing the vector of family
  parameters. If not given explicitly, the deviance function is
  determined numerically.

  The family parameter of \code{powerVarianceFamily} is \sQuote{theta},
  while the names of the parameters of \code{extBinomialVarianceFamily} are
  \sQuote{k} and \sQuote{l}.
}
\note{
  Those arguments passed to \code{varianceFunction} that are functions,
  are supposed to accept the variance family's parameter as an
  argument. The idea is that any of these functions may give different
  results for different values of the family's parameters. Even if any
  of these functions do not depend on these parameters, they must be
  contained in the function's argument list.
 }

\value{
  \code{varianceFamily} returns an object of class \code{varianceFamily}
  containing the following components:
  \item{family}{a function which computes an \code{extFamily} object,
  which is an extension of the \code{\link{family}} object known from
  classical \code{\link{glm}}. \code{extFamily} inherits from class
  \code{\link{family}} and contains an additional field holding the
  value of the particular parameters at which the family was evaluated.}
  \item{name}{a character string giving the name of the variance
    family.}
  \item{params}{a list of the parameters of the variance family.}
  \item{type.dev}{a character string. Equals either \dQuote{explicit} or
    \dQuote{numerical} depending on how the deviance function was determined.}
}
\references{
  Nelder, J.A. and Pregibon, D. (1987).  An Extended Quasi-Likelihood
  Function. \emph{Biometrika}, \bold{74}, 221--232.
}
\author{Thorn Thaler}
\seealso{\code{\link{family}}, \code{\link{eql}}}
\examples{
# The extended binomial variance family
# (the deviance is determined numerically)

# init does not depend on k and l but it must accept
# these parameters anyways
init <- function(k, l) {
  return(expression({
    mustart <- (weights * y + 0.5)/(weights + 1)
    n <- rep.int(1, nobs)}))
}
validmuf <- function(mu, k, l) {
  return(all(mu > 0) && all(mu < 1))
}
varf <- function(y, k, l)  y^k*(1-y)^l
suppressWarnings(vf <- varianceFamily(varf=varf, link="log", initf=init, 
                        validmuf=validmuf,
                        name="Extended-Binomial-Family"))
vf$family(1,1) # corresponds to binomial()

y <- runif(10, 0, 1)
mu <- runif(10, 0, 1)

all.equal(vf$family(1,1)$dev.resids(y,mu,1),     # TRUE
          binomial()$dev.resids(y,mu,1))    

}
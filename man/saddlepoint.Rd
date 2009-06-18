\name{saddlepoint}
\alias{saddlepoint}
\title{Saddlepoint Approximation}
\description{
  Computes the (normalized) saddlepoint approximation of the mean of
  \eqn{n} i.i.d. random variables.
}
\usage{
saddlepoint(x, n, cumulants, correct = TRUE, normalize = FALSE)
}
\arguments{
  \item{x}{a numeric vector or array with the values at which the
    approximation should be evaluated.}
  \item{n}{a positive integer giving the number of i.i.d. random
    variables in the sum.}
  \item{cumulants}{a \code{cumulants} object giving the cumulant
    functions and the saddlepoint function. See \code{\link{cumulants}}
    for further information.}
  \item{correct}{logical. If \code{TRUE} (the default) the correction term
    involving the 3rd and the 4th standardized cumulant functions is included.}
  \item{normalize}{logical. If \code{TRUE} the renormalized version of
    the saddlepoint approximation is calculated. The renormalized
    version does neither make use of the 3rd nor of the 4th cumulant
    function so setting \code{correct=TRUE} will result in a
    warning. The default is \code{FALSE}.}
}
\details{
  The saddlepoint approximation (\acronym{SA}) for the density of the
  mean \eqn{Z=S_n/n}{Z=S_n/n} of i.i.d. random variables
  \eqn{Y_i} with \eqn{S_n=\sum_{i=1}^n Y_i}{S_n=Y_1+\dots+Y_n} is given
  by:
  \deqn{f_Z(z) \approx c\sqrt{\frac{n}{2\pi K_{Y}''(s)}}
    \exp\{n[K_{Y}(s)- sz]\},}{f_Z(z) ~ c*(2*pi)^(-1/2)*(n/K''(s))^(1/2)
    * exp{n*K(s)-n*s*z},}
  where \eqn{c} is an appropriatly chosen correction term, which is
  based on higher cumulants. The function \eqn{K_Y(\cdot)}{K_Y()} denotes the cumulant
  generating function and \eqn{s} denotes the \emph{saddlepoint}
  which is the solution of the saddlepoint function:
  \deqn{K'(s)=z.}

  For the renormalized version of the \acronym{SA} one chooses \eqn{c}
  such that \eqn{f_Z(z)} integrates to one, otherwise it includes the
  3rd and the 4th standardized cumulant.

  The saddlepoint approximation is an improved version of the Edgeworth
  approximation and makes use of \sQuote{exponential tilted}
  densities. The weakness of the Edgeworth method lies in the
  approximation in the tails of the density. Thus, the saddlepoint
  approximation embed  the original density in the \dQuote{conjugate
    exponential family} with parameter \eqn{\theta}{theta}. The mean of
  the embeded density depends on \eqn{\theta}{theta} which allows for
  evaluating the Edgeworth approximation at the mean, where it is known
  to give reasonable results.
}
\value{
  \code{saddlepoint} returns an object of class \code{approximation}. See
  function \code{\link{approximation}} for further details.
}
\references{
  Reid, N. (1991).  Approximations and Asymptotics. \emph{Statistical
    Theory and Modelling}, London: Chapman and Hall.
}
\author{Thorn Thaler}
\seealso{\code{\link{approximation}}, \code{\link{cumulants}}, \code{\link{edgeworth}}}
\examples{
# Saddlepoint approximation for the density of the mean of n Gamma
# variables with shape=1 and scale=1
n <- 10
shape <- scale <- 1
x <- seq(0, 3, length=1000) 
sp <- saddlepoint(x, n, gammaCumulants(shape, scale))
plot(sp, lwd=2)

# Mean of n Gamma(1,1) variables is n*Gamma(n,1) distributed
lines(x, n*dgamma(n*x, shape=n*shape, scale=scale), col=2)

}

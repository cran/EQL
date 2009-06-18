\name{edgeworth}
\alias{edgeworth}
\title{Edgeworth Approximation}
\description{Computes the Edgeworth expansion of either the
  standardized mean, the mean or the sum of i.i.d. random variables. 
}
\usage{edgeworth(x, n, rho3, rho4, mu, sigma2, deg=3,
          type = c("standardized", "mean", "sum"))
}
\arguments{
  \item{x}{a numeric vector or array giving the values at which the
    approximation should be evaluated.}
  \item{n}{a positive integer giving the number of i.i.d. random
    variables in the sum.}
  \item{rho3}{a numeric value giving the standardized 3rd cumulant. May
    be missing if \code{deg <= 1}.}
  \item{rho4}{a numeric value giving the standardized 4th cumulant. May
    be missing if \code{deg <= 2}.}
  \item{mu}{a numeric value giving the mean.

    May be missing if \code{type = "standardized"}, since it is
    only needed for transformation purposes.}  
  \item{sigma2}{a positive numeric value giving the variance.

    May be missing if \code{type= "standardized"}.}
  \item{deg}{an integer value giving the order of the approximation:
    \itemize{
      \item \code{deg=1}: corresponds to a normal approximation
      \item \code{deg=2}: takes 3rd cumulant into account
      \item \code{deg=3}: allows for the 4th cumulant as well.
      The default value is 3.
  }}
  \item{type}{determines which sum should be approximated. Must be one
    of (\dQuote{standardized}, \dQuote{mean}, \dQuote{sum}),
    representing the shifted and scaled sum, the weighted sum and the
    raw sum. Can be abbreviated.}
}
\value{\code{edgeworth} returns an object of the class
  \code{approximation}. See \code{\link{approximation}} for further
  details.
}
\details{
  The Edgeworth approximation (\acronym{EA}) for the density of the
  standardized mean \eqn{Z=\frac{S_n-n\mu}
    {\sqrt{n\sigma^2}}}{Z=(S_n-n*mu)/(n*sigma^2)^(1/2)}, where
    \itemize{
      \item \eqn{S_n = Y_1 + \ldots + Y_n} denotes the sum of i.i.d. random
      variables,
      \item \eqn{\mu}{mu} denotes the expected value of \eqn{Y_i},
      \item \eqn{\sigma^2}{sigma^2} denotes the variance of \eqn{Y_i}
  }
  is given by:
  \deqn{f_{Z}(s)=\varphi(s)[ 1 + \frac{\rho_3}{6\sqrt{n}} H_3(s) +
    \frac{\rho_4}{24n} H_4(s) + \frac{\rho_3^2}{72n} H_6(s)],}{f_Z(s) =
    phi(z)*[1 + rho3/(6*n^(1/2))*H_3(z) + }
  \deqn{}{rho4/(24*n)*H_4(z) + rho3^2/(72*n)*H_6(z)],}
  with \eqn{\varphi}{phi} denoting the density of the standard normal
  distribution and \eqn{\rho_3}{rho3} and \eqn{\rho_4}{rho4} denoting
  the 3rd and the 4th standardized cumulants of \eqn{Y_i}
  respectively. \eqn{H_n(x)} denotes the \eqn{n}th Hermite polynomial (see
  \code{\link{hermite}} for details).

  The \acronym{EA} for the mean and the sum can be obtained by applying
  the transformation theorem for densities. In this case, the expected
  value \code{mu} and the variance \code{sigma2} must be given to allow
  for an appropriate transformation.
}
\references{
  Reid, N. (1991).  Approximations and Asymptotics. \emph{Statistical
  Theory and Modelling}, London: Chapman and Hall.
}
\seealso{\code{\link{approximation}},\code{\link{hermite}},\code{\link{saddlepoint}}
}
\examples{
# Approximation of the mean of n iid Chi-squared(2) variables

n <- 10
df <- 2
mu <- df
sigma2 <- 2*df
rho3 <- sqrt(8/df)
rho4 <- 12/df
x <- seq(max(df-3*sqrt(2*df/n),0), df+3*sqrt(2*df/n), length=1000)
ea <- edgeworth(x, n, rho3, rho4, mu, sigma2, type="mean")
plot(ea, lwd=2)

# Mean of n Chi-squared(2) variables is n*Chi-squared(n*2) distributed
lines(x, n*dchisq(n*x, df=n*mu), col=2)
}
\author{Thorn Thaler}

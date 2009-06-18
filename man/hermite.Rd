\name{hermite}
\alias{hermite}
\title{Hermite Polynomials}
\description{Computes the Hermite polynomial \eqn{H_n(x)}.}
\usage{hermite(x, n, prob = TRUE)}
\arguments{
  \item{x}{a numeric vector or array giving the values at which the
    Hermite polynomial should be evaluated.}
  \item{n}{an integer vector or array giving the degrees of the Hermite
    polynomials. If \code{length(x) != 1}, \code{n} must be either of the
    same length as \code{x} or a  single value.}
  \item{prob}{logical. If \code{TRUE} (the default) the probabilistic
    version of the Hermite polynomial is evaluated, otherwise the
    physicists' Hermite polynomials are used. See the \sQuote{Details}
    section below for further information.}
}
\value{the Hermite polynomial (either the probabilists' or the
  physicists' version) evaluated at \code{x}.}
\details{
  The Hermite polynomials are given by:
  \itemize{
    \item \eqn{H_{n+1}(x)=xH_n(x)-nH_{n-1}(x),}{H_(n+1)(x) = x*H_n(x)
      - n*H_(n-1)(x),} with \eqn{H_0(x)=1} and \eqn{H_1(x)=x},
    (Probabilists' version \eqn{H_n^{Pr}(x)}{H_n^Pr(x)})
    \item \eqn{H_{n+1}(x)=2xH_n(x)-2nH_{n-1}(x)}{H_(n+1)(x) = 2*x*H_n(x)
      - 2*n*H_(n-1)(x)}, with \eqn{H_0(x)=1} and
    \eqn{H_1(x)=2x}. (Physicists' version \eqn{H_n^{Ph}(x)}{H_n^Ph(x)})
  }
  and the relationship between the two versions is given by
  \deqn{H_n^{Ph}(x)=2^{n/2}H_n^{Pr}(\sqrt{2}x).
  }{H_n^Ph(x)=2^(n/2)*H_n^Pr(2^(1/2)*x).}
  The term \sQuote{probabilistic} is motivated by the fact that in this
  case the Hermite polynomial \eqn{H_n(x)} can be as well defined by
  \deqn{H_n(x)=(-1)^{n}\frac{1}{\varphi(x)} \varphi^{(n)}(x),}{H_n(x) =
  (-1)^n*phi^(n)(x)/phi(x),}
  where \eqn{\varphi(x)}{phi(x)} denotes the density function of the
  standard normal distribution and \eqn{\varphi^{(k)}(x)}{phi^(k)(x)}
  denotes the \eqn{k}th derivative of \eqn{\varphi(x)}{phi(x)} with respect
  to \eqn{x}. 

  If the argument \code{n} is a vector it must be of the same
  length as the argument \code{x} or the length of the argument \code{x}
  must be equal to one. The Hermite polynomials are then evaluated
  either at \eqn{x_i} with degree \eqn{n_i} or at \eqn{x} with degree
  \eqn{n_i}, respectively.
}
\references{Fedoryuk, M.V. (2001). Hermite
  polynomials. \emph{Encyclopaedia of Mathematics}, Kluwer Academic
  Publishers.
}
\examples{
2^(3/2)*hermite(sqrt(2)*5, 3)    # = 940
hermite(5, 3, FALSE)             # = 940
hermite(2:4, 1:3)                # H_1(2), H_2(3), H_3(4)
hermite(2:4, 2)                  # H_2(2), H_2(3), H_2(4)
hermite(2, 1:3)                  # H_1(2), H_2(2), H_3(2)
\dontrun{
hermite(1:3, 1:4)                # Error!
}
}
\author{Thorn Thaler}


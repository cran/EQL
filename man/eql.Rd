\name{eql}
\alias{eql}
\alias{plot.eql}
\title{The Extended Quasi-Likelihood Function}
\description{
Computes the Extended Quasi Likelihood (\acronym{EQL}) function for
a given set of variance functions from a particular variance family.
}
\usage{
eql(formula, param.space, family = powerVarianceFamily(),
    phi.method = c("pearson", "mean.dev"), include.model = TRUE,
    smooth.grid = 10, do.smooth = dim(family) == 1,
    verbose = 1, \dots)

\S3method{plot}{eql}(x, do.points = (dim(x) == 1 && sum(!x$is.smoothed) <= 20),
     do.ci = TRUE, alpha = 0.95, do.bw = TRUE,
     show.max = TRUE, \dots)
}
\arguments{
  \item{formula}{an object of class \code{formula} (or one that can be coerced to
          that class): a symbolic description of the model to be
          used to determine the parameters of the variance function.}
  \item{param.space}{a list of parameters for which the \acronym{EQL}
     value should be evaluated. If provided as a named list,
     the names must equal the names of the parameters defined by
     the variance family.}
  \item{family}{an object of class \code{varianceFamily} giving a
     parameterized family of variance functions. See
     \code{\link{varianceFamily}} for further details.}
  \item{phi.method}{a character string giving the name of the method 
     used to estimate the dispersion parameter
     \eqn{\phi}{phi}. Must be one of (\dQuote{pearson},
     \dQuote{mean.dev}) representing the estimation of \eqn{\phi}{phi}
     by the mean Pearson's statistic or by the mean deviance, respectively.}
  \item{include.model}{logical. If \code{TRUE} (the default) the final
    model is included in the output.}
  \item{x}{an object of class \code{eql}.}
  \item{do.smooth, smooth.grid}{\code{do.smooth} is a logical value and
     \code{smooth.grid} is an integer value giving the number of nodes
     for the smoothing process. If \code{do.smooth} is \code{TRUE},
     smoothing is carried out by cubic splines on an equidistant grid
     with an amount of nodes equals to \code{smooth.grid} between two
     adjacent \acronym{EQL} values. Smoothing is currently only
     available for one-dimensional variance families, i.e. families that
     depend only on one parameter.}
  \item{verbose}{the amount of feedback requested: \sQuote{0} or \code{FALSE} means
          no feedback, \sQuote{1} or \code{TRUE} means some feedback (the
          default), and \sQuote{2} means to show all available
     feedback. For the default setting, a progress bar will be displayed
     to give a rough estimation of the remaining calculation time. Full
     feedback prints  the \acronym{EQL} value for each parameter
     combination.}
  \item{\dots}{further arguments to be passed to the \code{\link{glm}}
    routine and the plotting routine, respectively.}
  \item{do.points, show.max}{logical. If \code{do.points} is
     \code{TRUE}, the computed \acronym{EQL}  values are marked in the
     plot. If \code{show.max} is \code{TRUE}, the maximum of the
     \acronym{EQL} function is emphasized in the plot.}
  \item{do.ci, alpha}{\code{do.ci} is a logical value, if \code{TRUE} a
     \eqn{\alpha}{alpha} confidence interval (respectively confidence
     ellipsoid) is added to the plot.}
   \item{do.bw}{logical. If \code{TRUE} (the default) a \dQuote{black
     and white} plot is produced, otherwise colours are used.}
}
\details{
  The \acronym{EQL} function as defined by \cite{Nelder and Pregibon}
  (see \sQuote{References}) is given by:
  \deqn{Q^+_\theta(y,\mu) = -\frac{1}{2} \log [2\pi\phi V_\theta(y)] -
     \frac{1}{2\phi} D_\theta(y,\mu),}{Q(y,mu) = -log(2*pi*phi*V(y))/2 -
     D(y,mu)/(2*phi),}
  where \eqn{D_\theta()}{D()} and \eqn{V_\theta()}{V()} denote the
  deviance function and the variance function, respectively, determined by
  the particular choice of the variance family.

  The goal is to maximize the \acronym{EQL} function over \eqn{\mu}{mu}
  and the not necessarily one-dimensional space of parameters
  \eqn{\theta}{theta}. The function \code{eql} takes a particular finite
  set of candidate parameters and computes the corresponding
  \acronym{EQL} value for each of these parameters and returns the
  maximum \acronym{EQL} value for the given set. That implies that the
  function is only capable of capturing local maxima. If the maximum occurs
  at the boundary of the set, the set of parameters may be badly chosen
  and one should consider a larger set with the found maximum as an
  interior point.

  The \code{plot} function is an important tool to investigate the
  structure of the \acronym{EQL} function. Confidence intervals and
  confidence ellipsoids give an idea of plausible parameter values
  for the variance function. The contour plot
  used for two-dimensional variance families is generated using the
  package \pkg{lattice}, which in turn relies on so called
  \code{trellis} plots. Hence, for two-dimensional families the
  \code{plot} function does not only generate the plot, but also
  returns the plot object to allow for further modifications of the
  plot. This is not true for one-dimensional variance models, which are
  plotted using the \R standard graphical engine.

  For large parameter sets the computation may take a long time. If no
  feedback is chosen, the function seems to be hung up, because the
  function does not provide any textual feedback while computing. Hence,
  a minimal feedback (including a progress bar) should be chosen to have
  an idea of the remaining calculation time.

  An explicitely given deviance function speeds up calculation. A rather
  large amount of the total calculation time is used to determine the
  numerical values of the integral in the deviance function.
}
\value{
  \code{eql} returns an object of class \code{eql}, which contains the
     following components:
  \item{eql}{a numerical vector with the computed eql values for the given
     set of parameter values. For one-dimensional variance families
     (i.e. those families with only one parameter), a smoothing
     operation can be performed to obtain intermediate values.}
  \item{param}{a \code{data.frame} containing the values of the
    parameters at which the eql function was evaluated.}
  \item{eql.max}{the maximum value of the eql function in the considered
    range.}
  \item{param.max}{a \code{data.frame} containing the values of the
    parameters at which the maximum is obtained.}
  \item{dim}{an integer value giving the dimension of the parameters in
    the underlying variance family.}
  \item{smooth}{a logical value indicating whether a smoothing operation
    was performed.}
  \item{is.smoothed}{a vector of logical values of the same length as
    \code{eql} indicating if the particular \acronym{EQL} value was
    obtained by smoothing or was calculated directly.} 
  \item{smooth.grid}{an integer value giving the number of points used
    in the smoothing process or \code{NULL} if no smoothing was
    performed.}
  \item{model}{if \code{include.model} is \code{TRUE}, the \acronym{GLM}
     for which the maximum \acronym{EQL} value was archieved,
     \code{NULL} otherwise.} 
}
\note{
The EQL for variance functions with \eqn{V_\theta(0)=0}{V(0;theta)=0}
becomes infinite. Hence, if there are exact zeros in the data, one
should provide a variance family, which do not equate to zero at the
origin. \cite{Nelder and Pregibon} propose some adjustment of \eqn{V(y)}
at the origin, which leads to a modified variance function. 

The predefined families \code{\link{powerVarianceFamily}} and
\code{\link{extBinomialVarianceFamily}} are, however, \emph{not} capable of
dealing with exact zeros, for there is no general mechanism to modify
the variance function for all possible values of the particular variance
family.

The confidence interval for one-dimensional variance families is not
calculated exactly, but depends on the amount of \acronym{EQL} values
available. Hence, if one is interested in a confidence interval, one
should allow for smoothing.

The function \code{eql} does not use a direct maximization routine, but
rather do a simple maximation over a finite set. Hence, all obtained
values including confidence intervals and confidence ellipsoids have a
\dQuote{local flavour} and should not be regarded as global solutions.

The confidence bounds are determined rather empirically and do heavily
depend on the amount of parameter values under consideration.
}
\references{
  Nelder, J.A. and Pregibon, D. (1987).  An extended quasi-likelihood
  function. \emph{Biometrika}, \bold{74}, 221--232.
}
\author{Thorn Thaler}
\seealso{\code{\link{varianceFamily}}, \code{\link{glm}}}
\examples{
## Power Variance Family
# Data from Box and Cox (1964)
x <- (-1:1)
y <- c(674,370,292,338,266,210,170,118,90,1414,1198,634,1022,620,438,
       442,332,220,3636,3184,2000,1568,1070,566,1140,884,360)
yarn.raw <- data.frame(expand.grid(x3=x, x2=x, x1=x), cycles=y)
yarn <- data.frame(x1=yarn.raw$x1, x2=yarn.raw$x2, x3=yarn.raw$x3,
   cycles=yarn.raw$cycles)
attach(yarn)

ps.power <- list(theta=seq(1, 4, length = 20))
eq.power <- eql(cycles~x1+x2+x3, param.space=ps.power,
   family=powerVarianceFamily("log"), smooth.grid=500)
plot(eq.power)

\dontrun{
## Extended Binomial Variance Family
# Data from McCullagh & Nelder: GLM, p. 329
# (zeros replaced by 'NA')

site <- rep(1:9, each=10)
variety <- rep(1:10, 9)
resp <- c(0.05,NA,NA,0.10,0.25,0.05,0.50,1.30,1.50,1.50,
   NA,0.05,0.05,0.30,0.75,0.30,3,7.50,1,12.70,1.25,1.25,
   2.50,16.60,2.50,2.50,NA,20,37.50,26.25,2.50,0.50,0.01,
   3,2.50,0.01,25,55,5,40,5.50,1,6,1.10,2.50,8,16.50,
   29.50,20,43.50,1,5,5,5,5,5,10,5,50,75,5,0.10,5,5,
   50,10,50,25,50,75,5,10,5,5,25,75,50,75,75,75,17.50,
   25,42.50,50,37.50,95,62.50,95,95,95) / 100

ps.binomial <- list(seq(1, 2.2, length=32), seq(1, 3, length=32))
eq.binomial <- eql(resp~site*variety, param.space=ps.binomial,
   family=extBinomialVarianceFamily())
plot(eq.binomial)
}
}
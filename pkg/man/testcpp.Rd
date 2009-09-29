\name{createFoo}
\alias{createFoo}
\alias{getStrFoo}
\alias{setStrFoo}
\alias{.closeFoo}
\alias{testcpp}
\title{Testing external pointers with finalization in R using C++}
\description{
  Show how to create C++ objects with external pointers from R which are deleted automatically from R.
}
\usage{
	createFoo(str)
	getStrFoo(p)
	setStrFoo(p, str)
	.closeFoo(p)
}
\arguments{
\item{str}{ Character string.}
\item{p}{ Pointer to Foo object.}
}
\details{
	This package shows how to create C++ objects from R which are stored in memory until they are deleted from R.
	The idea is to be able to call methods of the C++ class before freeing the object from memory. \code{createFoo} 
	create an object of class Foo. \code{getStrFoo} returns the string stored in Foo. \code{setStrFoo} set the
	string in Foo. \code{.closeFoo(p)} is the internal function used to free the object from memory.\cr
	
	Have a look in the src folder to see how the C and C++ code are made.\cr
	
	The test package is inspired by the ``Interfacing C++ code'' section in the R extensions manual [1] and 
	Luke Tierney's page about simple references with finalization [2]. 
}
\value{
  \code{createFoo} returns a pointer to the object of class Foo created in memory.
  \code{getStrFoo} returns the string stored in Foo.
  \code{setStrFoo} returns NULL.
  \code{.closeFoo(p)} return NULL.
}
\note{Use the extension .cc and .hh for C++ files in the src folder. If you use the extension .c and .h
the source code will be compiled using gcc instead of g++!}
\references{
[1] R Development Core Team. Writing R Extensions. Version 2.8.1 (2008-12-22)
R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-11-9, 
\url{http://www.R-project.org}.\cr

[2] Simple References with Finalization \url{http://www.stat.uiowa.edu/~luke/R/simpleref.html}.
}
\examples{
# Creating an object
p<-createFoo("Testing 1")
getStrFoo(p)
setStrFoo(p,"Testing 2")
getStrFoo(p)
trace(.closeFoo)
rm(p)   # remove the object when the garbage collector is called
gc()

# Creating two objects
p1<-createFoo("Testing 1")
p2<-createFoo("Testing 2")
getStrFoo(p1)
getStrFoo(p2)
rm(p1)  
rm(p2) 
gc()
}
\keyword{interface}


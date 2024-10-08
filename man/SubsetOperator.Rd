% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Subsets.R
\name{SubsetOperator}
\alias{SubsetOperator}
\title{Abstract base class for subsets.}
\description{
Abstract Base Class for subsets. Subsets should inherit from this and implement their own requirements.
}
\seealso{
CohortSubsetOperator

DemographicSubsetOperator

LimitSubsetOperator
}
\section{Active bindings}{
\if{html}{\out{<div class="r6-active-bindings">}}
\describe{
\item{\code{name}}{name of subset operation - should describe what the operation does e.g. "Males under the age of 18", "Exposed to Celecoxib"}
}
\if{html}{\out{</div>}}
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-SubsetOperator-new}{\code{SubsetOperator$new()}}
\item \href{#method-SubsetOperator-classname}{\code{SubsetOperator$classname()}}
\item \href{#method-SubsetOperator-getAutoGeneratedName}{\code{SubsetOperator$getAutoGeneratedName()}}
\item \href{#method-SubsetOperator-getQueryBuilder}{\code{SubsetOperator$getQueryBuilder()}}
\item \href{#method-SubsetOperator-publicFields}{\code{SubsetOperator$publicFields()}}
\item \href{#method-SubsetOperator-isEqualTo}{\code{SubsetOperator$isEqualTo()}}
\item \href{#method-SubsetOperator-toList}{\code{SubsetOperator$toList()}}
\item \href{#method-SubsetOperator-toJSON}{\code{SubsetOperator$toJSON()}}
\item \href{#method-SubsetOperator-clone}{\code{SubsetOperator$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-new"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$new(definition = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{definition}}{json character or list - definition of subset operator}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
instance of object
Class Name
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-classname"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-classname}{}}}
\subsection{Method \code{classname()}}{
Class name of object
Get auto generated name
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$classname()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-getAutoGeneratedName"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-getAutoGeneratedName}{}}}
\subsection{Method \code{getAutoGeneratedName()}}{
Not intended to be used - should be implemented in subclasses
Return query builder instance
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$getAutoGeneratedName()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-getQueryBuilder"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-getQueryBuilder}{}}}
\subsection{Method \code{getQueryBuilder()}}{
Return query builder instance
Public Fields
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$getQueryBuilder(id)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{id}}{- integer that should be unique in the sql (e.g. increment it by one for each subset operation in set)}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-publicFields"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-publicFields}{}}}
\subsection{Method \code{publicFields()}}{
Publicly settable fields of object
Is Equal to
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$publicFields()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-isEqualTo"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-isEqualTo}{}}}
\subsection{Method \code{isEqualTo()}}{
Compare Subsets - are they identical or not?
Checks all fields and settings
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$isEqualTo(subsetOperatorB)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{subsetOperatorB}}{A subset to test equivalence to
To list}
}
\if{html}{\out{</div>}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-toList"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-toList}{}}}
\subsection{Method \code{toList()}}{
convert to List representation
To Json
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$toList()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-toJSON"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-toJSON}{}}}
\subsection{Method \code{toJSON()}}{
convert to json serialized representation
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$toJSON()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
list representation of object as json character
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-SubsetOperator-clone"></a>}}
\if{latex}{\out{\hypertarget{method-SubsetOperator-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{SubsetOperator$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}

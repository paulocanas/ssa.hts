
#===================================
##### First step: Hankelization ####
#===================================
#' Trajectory matrix
#'
#' @param y A time series or a vector.
#' @param L The window length.
#'
#' @return A hankel matrix.
#' @export
#'
#' @examples
#' UniHankel(AirPassengers[1:20], L=10)
UniHankel<-function(y,L){
  Rssa::hankel(y,L)
}
#=======================================




#===================================
######### Second step: SVD #########
#===================================
#' Singular value decomposition
#'
#' @param y A time series or a vector.
#' @param L The window length.
#'
#' @return A list with the singular value decomposition.
#' @export
#'
#' @examples
#' SVD(AirPassengers[1:20], L=10)
SVD<-function(y,L){
  T<-UniHankel(y,L)
  svd(T)
}
#=======================================



#=======================================
######### Third Step: Grouping #########
#=======================================
#' Grouping
#'
#' @param y A time series or a vector.
#' @param L The window length.
#' @param groups The number of eigentriples for reconstruction.
#'
#' @return A matrix with the approximation.
#' @export
#'
#' @examples
#' Group(AirPassengers[1:20], L=10, groups=5)
Group<-function(y,L,groups){
  Xtil=list()
  T=UniHankel(y,L)
  Xapproximation=matrix(rep(0,(dim(T)[1]*dim(T)[2])),L,(length(y)-L+1))
  I<-groups
  sSVD<-SVD(y,L)
  for(i in 1:I){
    Xtil[[i]]=as.matrix(as.data.frame(sSVD$d[i]*sSVD$u[,i]%*%t(sSVD$v[,i])))
    Xapproximation=Xapproximation+Xtil[[i]]
  }
  Xapproximation
}
#=======================================




#============================================
######### Forth Step: Hankelization #########
#============================================
#' Diagonal averaging
#'
#' @param X A matrix.
#'
#' @return A vector.
#' @export
#'
#' @examples
#' PC1<- Group(AirPassengers[1:20], L=10, groups=1)
#' DiagAver(PC1)
DiagAver<-function(X){
  L<-nrow(X);k<-ncol(X);N<-k+L-1
  D<-NULL
  for(j in 1:N){
    s1<-max(1,(j-N+L))
    s2<-min(L,j)
    place<-(s1:s2)+L*(((j+1-s1):(j+1-s2))-1)
    D[j]<-mean(X[place])
  }
  D
}
#=======================================



#============================================
######### Singular spectrum analysis ########
#============================================
#' Singular spectrum analysis
#'
#' @param y A time series or a vector.
#' @param L The window length.
#' @param groups The number of eigentriples for reconstruction.
#'
#' @return A list with the approximation and the residual.
#' @export
#'
#' @examples
#' s<- ssa(AirPassengers[1:20], L=10, groups=5)
#' s$approximation
#' s$residual
#' AirPassengers[1:20] - (s$approximation + s$residual)
ssa<- function(y, L, groups){
    # y: data (time series object)
    # L: window lenght
    # groups: number of eigentriples for reconstruction
    # Returns: list with approximation and residual
      #step 2 - SVD
      #second<- SVD(first,L)
      #step 3
      third<- Group(y,L,groups)
      #step4
      approx<-DiagAver(third)
      resid<- y - approx
      list(approximation = approx, residual = resid)
}
#=======================================





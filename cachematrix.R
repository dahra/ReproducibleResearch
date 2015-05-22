## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
## makeCacheMatrix function creates a special "matrix" object that can cache its inverse.



makeCacheMatrix <- function(x = matrix()) {
null_m <- NULL                                           
  set <- function(y) {                                    #store matrices in cache
    init_matrix_cached <<- y                              #first user defined matrix stored in cache       
    m_cached <<- NULL                                
  }
  get <- function() init_matrix_cached                   #get the matrix defined by user            
  set_m_cached <- function(null_m) m_cached <<- null_m   #set cached value, m_cached, passed-in value, null_m   
  get_m_cached <- function() m_cached                    #retrieve the value in cache 
  list(set = set ,                                          
  get = get ,
       set_m_cached = set_m_cached ,
       get_m_cached = get_m_cached)

}


## Write a short comment describing this function
## cacheSolve function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
##            If the inverse has already been calculated (and the matrix has not changed), 
##            then the cachesolve should retrieve the inverse from the cache.


cacheSolve <- function(x, ...) {                        #call function makeCacheMatrix 
        ## Return a matrix that is the inverse of 'x'
  null_m<- x$get_m_cached()               
  if(!is.null(null_m)) {                               #is matrix null_m not NULL         
    message("getting cached data")                     #print message if true
    return(null_m)                                     #print on screen matrix
  }                                       
  first_matrix <- x$get()                              #Call function x$get 
  last_matrix <- solve(first_matrix)                   #solve function computes the inverse of square matrix first_matrix  
  x$set_m_cached(last_matrix)                          #Call function x$set_m_cached
  last_matrix
}

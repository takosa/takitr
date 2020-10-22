
#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List rcpp_hello_world() {

    CharacterVector x = CharacterVector::create( "foo", "bar" )  ;
    NumericVector y   = NumericVector::create( 0.0, 1.0 ) ;
    List z            = List::create( x, y ) ;

    return z ;
}


// [[Rcpp::export]]
std::unordered_map<String, int> frequency(CharacterVector x) {
  std::unordered_map<String, int> m;
  for (String s : x) {
    ++m[s];
  }
  for (auto p : m) {
    Rcpp::Rcout << (std::string)p.first << ": " << p.second << std::endl;
  }
  return m;
}
#ifdef _WIN32
	#define EXPORT __declspec(dllexport)
#else
	#define EXPORT __attribute__ ((visibility ("default")))
#endif

#include "arrays.hpp"
#include "GTLengthException.hpp"

//Class CAdd is a subclass of arrays and does array addtion of the two arrays that are defined 
class EXPORT CAdd : public arrays{
	
	public:
	//Constructor takes 2 arrays as inputs; x and y. The length of the arrays is specified as the third argument("len"). 
	//@param1 pointer to the [0] element of the first array 
	//@param2 pointer to the [0] element of the second array 
	//@param3 length of the arrays specified in the first and second aruguments
	
	CAdd(const int *first, const int *sec, int len):
		arrays(first, sec, len){
	}
        
	//Gets the result of the addition of 2 arrays 
	//@param1 output array. The sum of the two arrays will be returned as the output in this array 
	//@param2 length of the "result" array
	//@throw  GTLengthException when the size of the result array that is asked is greater than the size of the array that was created
	
	int  addition(int *result, int len){
		int mylen = getLengthOfArr();
		if ( mylen < len ) {
			throw GTLengthException();
		}
		int *x = arrays::get_firstArr();
		int *y = arrays::get_secArr();
		for(int i = 0; i < len; ++i){
			result[i] = x[i] + y[i];
		}
		return len;
	}
};

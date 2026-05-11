#include <exception>
#include <iostream>

//Class  "arrays" is the super class with all the methods common to classes that subclass from arrays

class EXPORT arrays{
	
	private:
	int *firstArr;
	int *secArr;
	int lengthOfArr;
	
	public:
	//Constructor takes 2 arrays as inputs; x and y. The length of the arrays is specified as the third argument("len"). 
	//@param1 pointer to the [0] element of the first array 
	//@param2 pointer to the [0] element of the second array 
	//@len length of the arrays specified in the first and second argument
	
	arrays(const int *first, const int *sec, int len){
		lengthOfArr = len;
		
		firstArr = new int [lengthOfArr];
		memcpy(firstArr, first, lengthOfArr*sizeof(int));
		secArr = new int [lengthOfArr];
		memcpy(secArr, sec, lengthOfArr*sizeof(int));
	}

    //destructor, frees the memory allocated for the two arrays
	~arrays(){
		delete[] firstArr;
		delete[] secArr;
	}
		
	//Prints the contents of the first Array(x) to command window
	void print_firstArr()const {
		for (int i=0;i<lengthOfArr;++i)
			std::cout<< firstArr[i] << std::endl; 
	}

    //Prints the contents of Array(secArr) to command window
	void print_secArr()const {
		
		for (int i=0;i<lengthOfArr;++i)
			std::cout<< secArr[i] << std::endl;
	}

    //Returns the length of the arrays stored in the object.
	int getLengthOfArr()const {
		return lengthOfArr;
	}
	
	//Returns the pointer to the first element of arrays:firstArr
	protected:	
	int * get_firstArr()const  {
		return firstArr;
	}
	
	//Returns the pointer to the first element of arrays:secArr
	int * get_secArr(){
		return secArr;
	}
	
};

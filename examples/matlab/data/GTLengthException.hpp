//Exception class that is thrown when length of the array that is asked for is greater than the actual length
class GTLengthException: public std::exception{
	
	public:
	GTLengthException(){};
	const char* what() const throw(){
		return "The length of the array requested is greater than the length that can be provided.";
	} 
};

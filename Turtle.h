/**********************************************
* Program:  Turtle.h                          *
* Author:   Elin Johansson                    *
* Date:     02/09/2020                        *
*                                             *
* Abstract:  *Turtle graphics
*            *
**********************************************/
#include <iostream>
#include <fstream>


using namespace std;

// pre:  private instance variables and public methods
// post: initialize member functions and private instance variables
class Turtle{
	
	private:  // private instance variables
		int rows;
		int col;
		bool penstatus;
		int getDigits(string instruction);
		ifstream inFile;
		char layout[20][20];
	
		public: // member functions
			bool Open();
			void ProcessInput();
			void DisplayFloor();

	Turtle();
	
};
Turtle ::  Turtle() {
// Function for the layout
// post: for loops for rows and columns setting the layout grid empty, to a clean sheet.
// sets the pen to be in the air.

	
for(int i=0; i< 20; i++) // making out how many rows and columns can be used in the program.
	{
	for (int j=0; j < 20; j++)
		{
		layout[i][j]= ' '; // printing the layout.
	

		rows = 0;// putting rows and colums to false.
		col = 0;
		penstatus = false; // putting the pen to be false so it won't print anything.
		}
	}

}
int Turtle::getDigits(string instruction)
// pre:  instruction is a string for an N, S, E, or W command
// post: if it's a valid command, it returns the number of positions to
//       move, otherwise it returns -1
// purpose:  This is a private member function that you can copy into your Turtle.h file.  
//            It will take a string (one line from the input file) as a parameter and
//            pick out the number of positions to move and return it.  
//            If there is a problem with that number, it will return a -1.

{
if ((instruction.length() < 3))
return -1;
if (!isdigit(instruction[2]))
        return -1;
if ((instruction.length() == 3) || !isdigit(instruction[3])){
return (instruction[2] - '0');
}
return (10 * (instruction[2] - '0')  +  (instruction[3] - '0'));
}

void Turtle :: ProcessInput(){
	// pre:  read the commands from the file, varify that it's valid, executes it.
// post: reads the file, makes sure it's a file that can be used, moves into a switch statement where
// each commands gets evaluated to see that they are valid. Prints out the movements.

	
	getline(inFile,command); // asks for the file name.
	  
	
	  while(!inFile.eof()){ // while the file isn't end of file.
		  
		  if(inFile.fail()) // checks if the file fails
			{
				char letter;
				inFile.clear();
				inFile.get(letter);
	
			}
	switch(command[0]) // if the file didn't fail it goes into a switch with all the commands.
	
	{
		
		case 'D': // case D to put the pen down to start drawing.
		penstatus = true;
		break;
		
		case 'U':// lifts the pen up, won't draw anything.
		penstatus = false;
		break;
		
		case 'N': // turtle moving north.
		if((rows - getDigits(command) > 0))// if the rows and numbers plus letter given is bigger than 0,
		{
			if(penstatus == true)// and pen is down
			{
					for(int i=0; i<=getDigits(command); i++)// for all of those spaces, 
				{
					layout[rows-i][col] = '*';// print a star.
			 
				} 
			}
			rows = rows - getDigits(command); // move the turtle
		}
			else if( rows - getDigits(command) < 0) // if smaller than 0,
			{
				cerr << "Your command was invalid1." << endl; // it is invalid.
			}
		break; // case over.
		
		case 'S':
		if((rows + getDigits(command) < 20))// if the rows and numbers plus letter given is smaller than 20,
		{
			if((penstatus == true ))// and pen is down
			{
				for(int i=0; i<=getDigits(command); i++)// for all of those spaces, 
				{			
					layout[rows+i][col] = '*';// print a star.
				}
			}
			rows = rows + getDigits(command);
		}
			else if( rows + getDigits(command) > 19)// if bigger than 19,
			{
				cerr << "Your command was invalid2." << endl;// it is invalid.
			}
		break;
		
		case 'E':
		if((col + getDigits(command) < 20))
		{
			if((penstatus == true))// and pen is down
			{
				for(int i=0; i<=getDigits(command); i++)// for all of those spaces, 
				{
					layout[rows][col+i] = '*';// print a star.
				}
			}
			col = col + getDigits(command);
		}
		
			else if( col + getDigits(command) > 19)// if bigger than 19,
			{
				cerr << "Your command was invalid3." << endl;// it is invalid.
			
			}
		break;
		
		case 'W':
		if((col - getDigits(command) > 0))
		{
			if((penstatus == true))// and pen is down
			{
				for(int i=0; i<=getDigits(command); i++)// for all of those spaces, 
				{			
					layout[rows][col-i] = '*';// print a star.
				}
			}
			col = col - getDigits(command);
		}
		
			else if( col - getDigits(command) < 0)// if smaller than 0,
			{
				cerr << "Your command was invalid4." << command << endl;// it is invalid.
			}
			break;
		}
	getline(inFile,command);
	}
 }



bool Turtle :: Open(){
	// pre:  asks for the file name
// post: gets a file name in and process it to see that it is a vaild file name.
	string x;
	
		cout << "Enter a name of the file: " << endl;// take in the file name
		cin >> x;
	
	inFile.open(x.c_str()); // sees if the file is vaild in the string or if not return false.
	 if(!inFile)
	 {
		 cout<< "File not found. " << endl; // error statement.
		 return 0;
	 }
	 return 1;
}

void Turtle :: DisplayFloor()
// pre:  displays the picture drawn by the turtle.
// post:  for loops for rows and columns and prints the picture of the file entered.
{
	for(int i=0; i< 20; i++) // prints out the rows.
	{
		for (int j=0; j < 20; j++) //prints out the columns.
		{
			cout << layout[i][j]; // prints out the picture from file.
		}
	cout << endl;
	}
}

	
	
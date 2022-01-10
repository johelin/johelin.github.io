/**********************************************
* Program:  Maze.h                            *
* Author:   Elin Johansson                    *
* Date:     02/25/2020                        *
*                                             *
* Abstract:  *
*            *
**********************************************/
#include <iostream>
#include <fstream>
#include <cstdlib>
#include <unistd.h>
 
using namespace std;
class Maze{ // Class name
	
private: // private data members.
	int rows; // initializing rows to an int.
	int cols;// initializing columns to an int.
    int R; // holds mouse current position
    int C;// holds mouse current position
    char direction ;
	char * mptr; // character pointer to maze.
    char mouse; //
    void West();//function for mouse pointing west.
    void East();//function for mouse pointing East.
    void North();//function for mouse pointing North.
    void South();//function for mouse pointing South.
    
public: // public data members.
	Maze();
	bool OpenAndLoad(char * filename); // char pointer, that will in the dirver promt the user.
	void DisplayMaze(); //instance variable, function that will display the maze.
    void placement();
    //void placement(int tempR, int tempC, char direction);
	

 };

 Maze :: Maze() 
 // pre: starts out in row 0, column 0. (0,0) 
 {
	 rows = 0; // initializing rows to 0.
	 cols = 0; // initializing cols to 0.
	 
 }

	
bool Maze :: OpenAndLoad(char * filename){
// pre: 
ifstream inFile;
	
	inFile.open(filename); // sends to diver, where the user gets prompt to enter a file.dat name.
	if(!inFile) //if the file promted by the user, is invalid. return false.
	{
		
		return 0;
	}
	 
	inFile >> rows; // takes the rows in from the dat file.
	inFile >> cols; // takes the colums in from the dat file.
	 
	mptr = new char[rows*cols]; // created a new character pointer, making the amout of spaces in maze.

char x;
inFile >> x; // taking in a value.

	for(int i=0; i< rows; i++) // goes through the amount of rows.
	{
		for (int j=0; j < cols; j++) // goes through the amount of columns.
		{
		*(mptr + (i * cols) + j) = x ; // declaring memory.
		inFile >> x; // reading it again.
		}
		
	}
	 return 1; // returns true.
}
void Maze :: DisplayMaze() // function to display the maze.
{

	system("clear");
		for(int i=0; i< rows; i++) // goes through the amount of rows.
		{
            
			for (int j=0; j < cols; j++){ //goes through the amount of columns.
                    
			
                if(i == R && j == C) {
                    cout << mouse << " ";
                }
                else {
                    cout << *(mptr + (i * cols) + j)<< " " ;} // declaring memory.
			}
            
		cout << endl;
		}
        
	
sleep(1);

}
void Maze :: placement(){//
    // pre: getting the mouse through the maze.
    // post: desciding where the mouse should be dropped, what direction. It should have all of the different functions from north, west, east, south. And manipulate it into a working maze.
    
    cout << " Enter a number for row" << endl; // promting the user for a row to start on.
    cin >> R;
    R--;
    
    
    cout << "Enter the Column: " << endl;// promting the user for a column to start on.
    cin >> C;
          C--;
    
            cout << "Enter a direction to place the mouse: " << endl;
               cin >> direction;// promting the user for what direction to start on.
    
               while(direction != 'N' &&direction != 'E' && direction != 'W' && direction != 'S'){ // making sure what the user entered is an actual character in range.
               cerr << "You did not enter a valid direction, try agian: " << endl; // error message
                   cin.clear();
                   cin.ignore(80, '\n');
               cin >> direction; // repromting the user.
               }
cout<< R << " " << C << endl;
    if(R < 0 || R > (rows-1) || C < 0 || C >(cols-1) || (*(mptr+(R)* cols)+C) == '#'){ // making sure what's entered is in range, in memory space and is npt a #.
        cerr << "the mouse was placed incorrectly, try again" << endl; // error message.
        
    }
    else {
        
        if(direction == 'N'){// if statement if mouse stating at North.Send it to the north function shown below.
            mouse ='^';
    North();
}
        else if(direction=='W'){// if statement if mouse stating at West.Send it to the west function shown below.
            mouse='<';
            West();
            
        }
               else if(direction=='S'){// if statement if mouse stating at South. Send it to the south function shown below.
                   mouse='v';
                   South();
                
               }
                        else if(direction=='E'){// if statement if mouse stating at East.Send it to the east function shown below.
                            mouse ='>';
                            East();
    }
    }}
    void Maze :: East(){ // east function.
        //pre:movement of mouse if faced east.
        //post: where and how the mouse should move if faced east in different situtations. otherwise send to other functions.
       DisplayMaze();// displayes the maze.
        while(mouse !='A')// while loop that will make the mouse move.
        {
            if(C==(cols-1)) {
                mouse = 'A';
                break;
                
            }
        if(*((mptr+(R+1)* cols)+C) == '#' && *((mptr+(R)* cols)+(C+1)) == '.')// if infornt of the mouse is a # and north if the mouse is a '.'.
                               {
                                   mouse='>'; // the mouse with look like this
                                   C++;
                                DisplayMaze();
                               }
                                   else if( *((mptr+(R+1)* cols)+C) == '.') {// if the mouse cant go right, the mouse will move to it's right in direction and become south.
                                   mouse='v';
                                  R++;
                                South();// send to south function
                                   }
                                       else if(*((mptr+(R)* cols)+(C+1)) == '#')
                                       {
                                           direction = 'N';
                                           mouse='^';
                                           North();// send to north function
                                           
                                       }
                                       

        }}
    
    void Maze :: North(){
        //pre:movement of mouse if faced north.
        //post: where and how the mouse should move if faced north in different situtations. otherwise send to other functions.
        cout<< R << " " << C << endl;
DisplayMaze();
        while(mouse !='A')// while loop that will make the mouse move.
        {
            if(R==0) {
                mouse = 'A';
                break;
                
            }
                if((*((mptr+(R * cols))+(C+1)) == '#' && *((mptr+((R-1) * cols))+C) == '.'))
            
                {
                    
                       mouse='^';
                       R--;
                    DisplayMaze();
          }
                       else if( *((mptr+(R)* cols)+(C+1)) == '.') {
                        mouse='>';
                          C++;
                           East();// send to east function
                       }
                   else if (*((mptr+(R-1)* cols)+C) == '#')
                   {
                       direction = 'W';
                    mouse='<';
                       West();// send to west function
                       
                   }}}
    
        void Maze :: South(){// south function
            //pre:movement of mouse if faced south.
            //post: where and how the mouse should move if faced south in different situtations. otherwise send to other functions.
            DisplayMaze(); // Displays the maze
            while(mouse !='A') // while loop that will make the mouse move.
            {

                if(R==(rows-1)) {
                    mouse = 'A';
                    break;
                    
                }
            
            if(*((mptr+(R)* cols)+(C-1)) == '#' && *((mptr+(R+1)* cols)+C) == '.')
            {
                mouse='v';
                R++;
                DisplayMaze();
            }
                else if(*(mptr+((R)* cols)+ C-1) == '.') {
               mouse='<';
               C--;
               West();
                }
                    else if(*((mptr+(R+1)* cols)+C) == '#')
                    {
                        direction ='E';
                       mouse='>';
                        East(); // send to east function
                    }}}
            void Maze :: West () {
                //pre:movement of mouse if faced west.
                //post: where and how the mouse should move if faced west in different situtations. otherwise send to other functions.
                DisplayMaze();
                while(mouse !='A')// while loop that will make the mouse move.
                {
                    if(C==0) {
                        mouse = 'A';
                        break;
                    
                        
                    }
                       if(*((mptr+(R-1)* cols)+C) == '#' && *((mptr+(R)* cols)+(C-1)) == '.')
                       {
                           mouse='<';
                           C--;
                          DisplayMaze();
                       }
                           else if(*((mptr+(R-1)* cols)+C) == '.') {
                           mouse='^';
                               R--;
                               North();// send to north function
                         
                           }
                               else if(*((mptr+(R)* cols)+(C-1)) == '#')
                               {
                                   direction = 'S';
                                 mouse ='v';
                                   South();// send to south function
                               }
                }}
                   


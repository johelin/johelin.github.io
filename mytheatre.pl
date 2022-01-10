#****************************************************
# Program:    PP2.pl
# Author: Elin Johansson
# Abstract: Project 2, Menu-driven interface for MyTheater.
#****************************************************
#!/usr/bin/perl -w

use strict;
use warnings;
use DBI;
use v5.10;
use POSIX;
use Term::ANSIColor;

sub isItAnInteger {        # a positive or negative integer with no leading zeroes
    $_ = $_[0];
    /\A-?[123456789][0123456789]*\z/ or /\A0\z/
}

sub isItARealNumber {    # a positive or negative real number, leading zeroes allowed
    $_ = $_[0];
    /\A-?[0123456789]*(\.[0123456789]*)?\z/    and /\d/
}

sub isItAType {    # attractions types are 'R' and 'F'
    $_ = $_[0];
    /\A[S|N]\z/
      
}
sub isItARoom {    # pass types are 'S' and 'N'
    $_ = $_[0];
    /\A[A|B|C|D|E|F]\z/                # REPLACE THIS LINE
}



sub isItMoney {        # a positive real number ( > 0) with exactly 2 digits after the decimal
    $_ = $_[0];
            /\A[\d]+[\.]\d\d\z/ and ($_ > 0)   # REPLACE THIS LINE
}


sub isItDuration {    # a string with the format 'MM:SS'
    $_ = $_[0];
    /\A([0-5][0-9]:[0-5][0-9])\z/                # REPLACE THIS LINE
}

sub isItNonBlank {    # a non-empty string with something besides whitespace
    $_ = $_[0];
    /.*\S/                # REPLACE THIS LINE
}

sub isAValidDate{    # see lab handout for details
    $_ = $_[0];
    /\A[\d][\d][\d][\d]-[0][2]-(([0][1-9])|([1][\d]))\z/ or    /\A[\d][\d][\d][\d]-(([0][469])|([1][1]))-(([0][1-9])|([1][\d])|([2][\d])|([3][0]))\z/ or /\A[\d][\d][\d][\d]-(([0][13578])|([1][02]))-(([0][1-9])|([1][\d])|([2][\d])|([3][01]))\z/    # REPLACE THIS LINE
}

sub menu { #Pop up menu, where you pick an option.
    system 'clear';
    my $option = 0;
    print color("Bold Yellow"),"Elin's Movie Theater! \n\n",color("reset"); #Adding a small header
    print "\t\t\t\tSelect an option\n\n";
    print "\t\t1 - Add a Movie\n";
    print "\t\t2 - Add a customer\n";
    print "\t\t3 - Buy a ticket\n";
    print "\t\t0 - End\n";
    print color("Bold Yellow"), "\nEnter selection: ",color("reset"); #Enter your selection
    $option = <STDIN>;
}

sub AddMovie { #Add a Movie subroutine
    my $MovieName;
    do{
    print color("Blue"),"Enter the Movie Title: ", color("reset");
    
    $MovieName = <STDIN>; # gettin input from keyboard, title of the Movie.
    chomp ($MovieName);
        if($MovieName eq "Exit"){
            return 0
        }
        if(!isItNonBlank($MovieName))  # Checking if the input is not an Movie title.
        {
            print color("Yellow"), "That was not a NONBLANK, please try again!\n", color("reset");
            
        }  }  while (!isItNonBlank($MovieName));
    
        print "\n";
    
    
    my $dbh = DBI->connect ("DBI:mysql:host=localhost;database=johelin", "johelin", "johelin_db");
    my $sth = $dbh->prepare("select * from Movies where BINARY title = \'$MovieName\'"); #Looking if the Movie is already in the databse.

    $sth-> execute();
    my @q = $sth->fetchrow_array();
    $sth->finish();
    $dbh->disconnect();
    
        my $size = @q;
        if ($size)
        {
            print color("Yellow"),"$MovieName is already a viewing at the moment, add another movie. returning to main menu.\n", color("reset");
            return 0;
        }
    
    my $Room;
    do{
    print color("Blue"),"Enter what Room the movie is showing in? ", color("reset"); #Adding what room the Movie is in.
    $Room = <STDIN>; #Getting input from the keyboard .
    chomp ($Room);
    
        if(!isItARoom($Room) eq "Exit")
        {
            return 0;
        }
        if(!isItARoom($Room)){
            print color("Yellow"),"That was not a valid Room, please try again!\n",color("reset");
    }
        }while(!isItARoom($Room));
print "\n";
    
my $Duration;
do{
    print  color("Blue"),"Enter The duration of the movie: ", color("reset"); #Adding how long the Movie is.
    $Duration = <STDIN>; #Getting input from the keyboard.
    chomp ($Duration);
    
        if(!isItDuration($Duration) eq "Exit")
        {
            return 0;
        }
    if(!isItDuration($Duration)){
        
            print color("Yellow"),"That was not a valid Duration, please try again!\n", color("Yellow"),;
           
    }}while(!isItDuration($Duration));
print "\n";
    my $AgeRestriction;
do{
    print color("Blue"),"Enter The Age Restriction of the movie: ",color("reset"); #Adding the age reastiction for the movie.
    $AgeRestriction = <STDIN>; #Getting input from the keyboard.
    chomp ($AgeRestriction);
    
        if(!isItARealNumber($AgeRestriction) eq "Exit")
        {
            return 0;
        }
    if(!isItARealNumber($AgeRestriction)){
            print color("Yellow"), "That was not a valid age, please try again!\n", color("Yellow");
           
    }}while(!isItARealNumber($AgeRestriction));
print "\n";

my $Released;
do{
    print color("Blue"), "Enter the date the movie was released? ",color("reset"); #Adding the release date of the movie.
    $Released = <STDIN>; #Getting input from the keyboard.
    chomp ($Released);
    
    if(!isAValidDate($Released) eq "Exit")
        {
            return 0;
        }
    if(!isAValidDate($Released)){
            print color("Yellow"), "That was not a valid Date, please try again!\n", color("reset");
            
    }}  while(!isAValidDate($Released));

print "\n";
   
    
    my $Cost;
    do{
        print color("Blue"), "Enter How much the movie ticket cost? ",color("reset"); #Adding how much a ticket cost.
        $Cost = <STDIN>; #Getting input from the keyboard for the Cost.
        chomp ($Cost);
        
        if(!isItMoney($Cost) eq "Exit") #checking if it's a vaild money amount.
            {
                return 0;
            }
        if(!isItMoney($Cost)){
                print color("Yellow"),"That was not a valid money amount, please try again!\n", color("reset");
                
        }}while(!isItMoney($Cost));
    print "\n";
    
    my $Quantity;
    do{
        print color("Blue"), "Enter How many people can sit in the theater? ",color("reset"); #Adding how many people can fit in the room
        $Quantity = <STDIN>; #Getting input from the keyboard for the Quantity.
        chomp ($Quantity);
        
        if(!isItAnInteger($Quantity) eq "Exit")
            {
                return 0;
            }
        if(!isItAnInteger($Quantity)){
                print color("Yellow"), "That was not a valid Number of seats, please try again!\n",color("reset");
                
        }}while(!isItAnInteger($Quantity));
    print "\n";
    
 
    my $insert = "insert into Movies values ( \'$MovieName\', '$Room', '$Duration', '$AgeRestriction', '$Released', $Cost, $Quantity)";
    $dbh = DBI->connect ("DBI:mysql:host=localhost;database=johelin", "johelin", "johelin_db");#making sure the colums line up and that all neccessary information will be added.
    my $result = $dbh->do($insert);
    $dbh->disconnect(); #diconnecting to the database.
    
        if (!$result) #checking if the request was a fail or a sucess.
        {
            print "Request failed: \"$insert\"\n"; #error message
            return 0;
        }
    else
        {
            print color("Green"),"The Movie was Added.\n",color("reset"); #successful
        }
}
sub AddCustomer {
    my $CustName;
    do{
    print color("Blue"),"Enter the Name of the Customer: ",color("reset"); #Adding a name for a new customer.
    
        $CustName = <STDIN>; # gettin input from keyboard, Name of the costumer.
    chomp ($CustName);
        if($CustName eq "Exit"){
            return 0
        }
        if(!isItNonBlank($CustName))
        {
            print color("Yellow"), "That was not a NONBLANK, please try again!\n",color("reset");
            
        }  }  while (!isItNonBlank($CustName));
    
        print "\n";
    
    
    my $dbh = DBI->connect ("DBI:mysql:host=localhost;database=johelin", "johelin", "johelin_db");
    my $sth = $dbh->prepare("select * from Customer where BINARY Name = \'$CustName\'");#Checking so the name of the customer is not already in the database.

    $sth-> execute();
    my @q = $sth->fetchrow_array();
    $sth->finish();
    $dbh->disconnect();
    
        my $size = @q;
        if ($size)
        {
            print color("Red"), "$CustName is already in the Database. returning to main menu.\n",color("reset");
            return 0;
        }
    
    my $Seating;
    do{
    print color("Blue"),"Enter a type of seating (S/N): ",color("reset"); #Adding if the costumer needs any special accomodation.
    $Seating = <STDIN>; # gettin input from keyboard.
    chomp ($Seating);
        if($Seating eq "Exit"){
            return 0
        }
        if(!isItAType($Seating))
        {
            print  color("Yellow"),"That was not a Seating, please try again (N/S)!\n",color("reset");
            
        }}  while (!isItAType($Seating));
        print "\n";
    
    my $Age;
    do{
    print color("Blue"),"Enter the customers age: ",color("reset"); #Getting the age of the costumer.
    
        $Age = <STDIN>; # gettin input from keyboard, age of customer
    chomp ($Age);
        if($Age eq "Exit"){
            return 0
        }
        if(!isItARealNumber($Age))  # Checking if the input is a real age.
        {
            print  color("Yellow"),"That was not an Age, please try again (N/S)!\n",color("reset");
            
        }  }  while (!isItARealNumber($Age));
    
        print "\n";
   
    my $insert = "insert into Customer values ( \'$CustName\', '$Seating', $Age)"; #inserting into the database.
    $dbh = DBI->connect ("DBI:mysql:host=localhost;database=johelin", "johelin", "johelin_db");
    my $result = $dbh->do($insert);
    $dbh->disconnect(); #diconnecting to the database.
    
        if (!$result) #checking if the request was a fail or a sucess.
        {
            print "Request failed: \"$insert\"\n"; #error message
            return 0;
        }
    else
        {
            print color("Green"),"The Customer was Added.\n",color("reset"); #successful
        }
}

sub BuyATicket {
    my $CustName;
    do{
    print color("Blue"),"Enter the Name of the Customer: ",color("reset"); #getting the name of the customer who wants to buy a ticket.
    
        $CustName = <STDIN>; # gettin input from keyboard.
        chomp ($CustName);
        if($CustName eq "Exit"){
            return 0
        }
        if(!isItNonBlank($CustName))  # Checking if the input is not a nonblank.
        {
            print  color("Yellow"),"That was not a NONBLANK, please try again!\n",color("reset");
            
        }  }  while (!isItNonBlank($CustName));
    
        print "\n";
    
    
    my $dbh = DBI->connect ("DBI:mysql:host=localhost;database=johelin", "johelin", "johelin_db");
    my $sth = $dbh->prepare("select * from Customer where BINARY Name = \'$CustName\'"); #Making sure the customer is in the database.

    $sth-> execute();
    my @q = $sth->fetchrow_array();
    $sth->finish();
    $dbh->disconnect();
    
        my $size = @q;
        if (!$size)
        {
            print color("Red"),"$CustName is not already in the Database. returning to main menu.\n",color("reset");
            return 0;
        }
   
    my $Age= $q[2];
    my $MovieName;
    do{
    print color("Blue"),"Enter the Movie Title: ",color("reset"); #Adding the movie they want to watch.
    
    $MovieName = <STDIN>; # gettin input from keyboard.
    chomp ($MovieName);
        if($MovieName eq "Exit"){
            return 0
        }
        if(!isItNonBlank($MovieName))  # Checking if the input is a name.
        {
            print color("Yellow"), "That was not a NONBLANK, please try again!\n",color("reset");
            
        }  }  while (!isItNonBlank($MovieName));
    
        print "\n";
    
    
     $dbh = DBI->connect ("DBI:mysql:host=localhost;database=johelin", "johelin", "johelin_db");
     $sth = $dbh->prepare("select * from Movies where BINARY title = \'$MovieName\'"); #Making sure the movie is viewing at the moment.

    $sth-> execute();
     @q = $sth->fetchrow_array();
    $sth->finish();
    $dbh->disconnect();
    
         $size = @q;
        if (!$size)
        {
            print color("Red"),"$MovieName is not viewing at the moment, try another movie. returning to main menu.\n",color("reset");
            return 0;
        }
    my $AgeLimit = $q[3];
    
    if($Age < $AgeLimit){ #checking the the customer is old enough the watch the movie they picked.
        print color("Bold Red"),"The Customer is too young to buy this ticket, try another movie",color("reset");
        return 0;
    }
    
    my $insert = "insert into Purchased values (\'$CustName\' ,\'$MovieName\')";
    $dbh = DBI->connect ("DBI:mysql:host=localhost;database=johelin", "johelin", "johelin_db");
    my $result = $dbh->do($insert);
    $dbh->disconnect(); #diconnecting to the database.
    
        if (!$result) #checking if the request was a fail or a sucess.
        {
            print "Request failed: \"$insert\"\n"; #error message
            return 0;
        }
    else
        {
            print color("Green"),"The ticket was purchased.\n",color("reset"); #successful
        }
}



    my $option = &menu;
    while ($option != 0){
        if($option == 1){&AddMovie;}
        if($option == 2){&AddCustomer;}
        if($option == 3){&BuyATicket;}
       
        
        print "\nHit enter to continue:";
        <STDIN>;
        $option = &menu;
    }
    print "\nThe End!\n";
        
        
            
 

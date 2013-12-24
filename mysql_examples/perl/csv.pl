#!/usr/bin/perl -w
# csv.pl - convert tab-delimited input to comma-separated values output
while (<>)	#read next input line
{
	s/"/""/g;	#double any quotes within column values
	s/\t/","/g;	#put "," between column values
	s/^/"/;	#add " before the first value
	s/$/"/;	#add " adfter the last value
	print;
}

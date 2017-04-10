#! /bin/bash
#------------------------------------------------------------------------------
# * Author(s): Kyle Oliveira, Danny Bishop 
# * Class: UC Davis, ECS 40, Fall 2006
# * Title: makemake.sh
# * Description: A shell script to produce makefiles for C++ programs. 
# * License: Creative Commons Attribution-Share Alike 3.0 United States License
#            See http://kyleoliveira.net/portfolio.html            
#------------------------------------------------------------------------------
# 
if [ $# -lt 1 ]
then
   echo "Executable name required. \nusage: makemake.sh executable_name\n"
   exit
fi # if there's no executable name return an error
# Make the arguement for the executable
echo $1: `ls *.cpp | sed s/'.cpp'/'.o'/g` > Makefile
echo -e '\t'g++ -Wall -ansi -g -o $@  `ls *.cpp | sed s/'.cpp'/'.o'/g` >> Makefile
name=$1;
shift
# Write the subsequent arguments
cpps=`ls *.cpp | wc -l`;
counter=1;
while [ $counter -le $cpps ] ; do
   something=`ls *.cpp | sed -n ''$counter'p'` # Count all of the .cpp files 
   something2=`ls *.cpp | sed -n ''$counter'p' | sed 's/'.cpp'/'.o'/g'` # Find the name of the current dependency to be printed
   echo $something2: $something `cat $something | sed -n '/\"*.h\"/p' $something | awk -F \" '{print $2}'` >> Makefile # Lists the dependencies
   echo -e '\t'g++ -Wall -ansi -g -c $@ $something >> Makefile
   counter=`expr $counter + 1`;
done
echo -e clean: '\n''\t'rm -f $name `ls *.cpp | sed s/'.cpp'/'.o'/g` core >> Makefile # Append clean routine to Makefile
exit 0 # Punch it Chewie!

#!/bin/bash
shopt=extglob
export LC_COLLATE=C
select Choice in "Press 1 to Create Database" "Press 2 to list Database"  "Press 3 to Connect to Database" "Press 4 to Drop Database"
do



case $REPLY in
	1)
		echo "Enter Name of Database"
         	read d_name

		if [ -e $d_name ];
	then
	       echo "DB name is already exist"
                         exit
       
	  elif [[ $d_name =~ [0-9] ]];
     then
             echo "Not allowed to use numbers in the begining"
             exit


           elif [[ $d_name =  *[-@#$%'&'*=+]* ]];
  	then
              echo "Syntax Error"
                        exit
	          # elif [[ $d_name =  var=`echo ${var// /_}` ]];
       # then
        #      echo "Syntax Error"
         #               exit
      
           # elif [ $d_name = " " ];
       #then
        #    echo "Error"
         #    exit

     else
	     mkdir $d_name
	     echo "DB is saved"
	     exit
     fi
                ;;
	2)
		ls 
		;;
	3)
		echo "Enter Db that you need to connect to"
		read db_name
		if [ -e $db_name ];
		then
			cd ~/Downloads/database/$db_name
			#echo $PWD
	select Choice in "Press 1 to Create Table"
         do
case $REPLY in
        1)
		echo "Enter number of table"
		read table_no
		for(( i = 0 ; i < $table_no ; i++))
		do
			echo "Enter name of table"
			read table_name
                        touch ~/Downloads/database/$db_name/$table_name
                      echo "Enter columns number"
		      read col_no
 for(( j = 0 ; j < $col_no ; j++))
       do
        echo "Enter Datatype : ";
         read data;

         echo "Enter column name"
	 read col_name
if [ -e $col_name ]
then 
     echo "Column name is already exist"

elif [[ $col_name =~ [0-9] ]];
then 			
     echo "Not allowed to use numbers in the begining"
               
elif [[ $col_name = *[-@#$%'&'*=+]* ]];
then 
     echo "Syntax Error"

else
     typeset -i $col_name
     echo "Is it primary key?(y/n)"
     read ans
       if [ $ans = "y" ];
       then
	  echo $data >> $table_name : $col_name >> $table_name
			 
       elif [ $ans = "n" ];
       then
        echo $data >> $table_name : $col_name >> $table_name
else
		echo "Wrong choice"
			fi
		fi
		
			    
#	 2)
 #       echo "Enter Datatype : ";
  #       read $data;
#	    echo "Enter column name"
 #            read col_name
  #           if [ -e $col_name ]
   #     then
    #            echo "Column name is already exist"

     #           elif [[ $col_name =~ [0-9] ]];
      #  then                
       # echo "Not allowed to use numbers in the begining"
               
        #        elif [[ $col_name = *[-@#$%'&'*=+]* ]];
       # then
       # echo "Syntax Error"
        #  else
         #      typeset -i $col_name
          #     echo "Is it primary key?(y/n)"
           #    read ans
            #   if [ $ans = "y" ] ;
             #           then
#	echo $col_name >> $table_name
 #         echo $data >> $table_name

  #            elif [ $ans = "n" ];
   #                     then
   #	echo $col_name >> $table_name
    #      echo $data >> $table_name

     #     else
      #       echo "Wrong choice"
       #         fi
	#	fi
	#	;;
       

done 
		done
       
esac
done
	fi
		;;
	4)
		echo "Enter database that you need to drop"
		read dr_db
		if [ -e $dr_db ];
		then
			rm -r ~/Downloads/database/$dr_db
			echo "Database is deleted successfully"
		fi
      esac  
      done



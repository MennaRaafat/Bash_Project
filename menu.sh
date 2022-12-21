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
select Choice in "Press 1 to Create Table" "Press 2 to Drop Table" "Press 3 To Insert Data in Table"
         do
case $REPLY in
        1)
	   echo "Enter number of table"
	   read table_no
	for(( i = 0 ; i < $table_no ; i++))
	   do
cols=""
dataTypes=""
meta=""
	     echo "Enter name of table"
	       read table_name
                touch ~/Downloads/database/$db_name/$table_name
              echo "Enter columns number"
		read col_no
       for(( j = 0 ; j < $col_no ; j++))
          do
meta=""
              echo "Enter Datatype : "
                 read dataType
meta=$meta:$dataType
dataTypes=$dataTypes:$dataType
               echo "Enter column name"
	         read col_name
meta=$meta:$col_name
cols=$cols:$col_name
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
		 
echo $cols > $table_name
	  echo $dataTypes >> $table_name 
       elif [ $ans = "n" ];
       then
        
echo $cols > $table_name
echo $dataTypes >> $table_name 
else
		echo "Wrong choice"
			fi
		fi
meta=$meta:$ans
echo $meta >> $table_name.meta
		done
                done
		;;
			    
   2)
       echo "Enter name of the table you need to drop"
         read table_name
         rm -f $table_name
	         ;;

   3)          
       echo "Enter table name you will insert in it"
       read table_name
      echo "Enter number of columns you will insert in it"
       read col_no
data=""
      for(( m = 0 ; m < $col_no ; m++ ))
       do
	       echo "Enter Column name"
	       read col_name
	       echo "Enter data "
	       read col_data
          if [ $col_name == "id" ];
	  then 
		  if [ -z $col_data ];
		  then 
	          echo "ID number can't be null"
                       echo "Enter data "
                        read col_data
                 elif [[ -e $col_data ]];
		 then 
		echo "ID number must be unique"
                       echo "Enter data "
                        read col_data
		else
                   echo "ID is added successfully"

      
         fi
                 
 fi
data=$data:$col_data

	  done
                    echo $data >> $table_name
              # echo $id >> $table_name
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



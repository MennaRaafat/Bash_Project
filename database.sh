#!/bin/bash -x
shopt=extglob
        export LC_COLLATE=C
        select Choice in "Press 1 to Create Database" "Press 2 to list Database" "Press 3 to Connect to Database" "Press 4 to Drop Database" "Press 5 to Exit"
        do
		        case $REPLY in
                1)
                   echo "Enter Name of Database"
                                read d_name

                if [ -e $d_name ];
                then
                   echo "DB name is already exist"

                elif [[ $d_name =~ [0-9] ]];
                then
        echo "Not allowed to use numbers in the begining"

	                elif [[ $d_name =  *[-@#$%'&'*=+]* ]];
                then
                        echo "Syntax Error"

                else
                        mkdir $d_name
                        echo "DB is saved"

                fi
                        ;;

	         2)
                        ls | grep -v .sh$
                        ;;
                3)
                        echo "Enter Db that you need to connect to"
                        read db_name
                        if [ -e $db_name ];
                        then
                        cd ~/Downloads/Bash_Project/$db_name

select Choice in "Press 1 to Create Table" "Press 2 to Drop Table" "Press 3 To Insert Data in Table" "Press 4 to Update Table" "Press 5 to delete from table" "Press 6 to show select menu" "Press 7 to Exit"

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
		if [[ -e $table_name ]];
		then
			echo "Table name is already exist"
		elif [[ $table_name =  *[-@#$%'&'*=+]* ]];
                then
                        echo "Syntax Error"

		 elif [[ $table_name =~ [0-9] ]];
                then
        echo "Not allowed to use numbers in the begining"
else

        touch ~/Downloads/Bash_Project/$db_name/$table_name
                echo "Enter columns number"
                        read col_no

                for(( j = 0 ; j < $col_no ; j++))
                        do
        meta=""
                echo "Enter Datatype(int/string) : "
                          read Type
#if [[ $colType != "int" ]] || [[ $colType != "string" ]];
#then 
#echo "Datatype doesn't exist"
#fi
 #else        
      meta=$Type
if [[ $dataTypes == "" ]];
then
dataTypes=$Type
else
dataTypes=$dataTypes:$Type
fi
#fi
                        echo "Enter column name"
                          read col_name
        meta=$meta:$col_name:
        cols=$cols$col_name:
sep=":"
rsep="\n"
pKey=""
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

                echo "Is it primary key?(PK/NO)"
                read ans
                if [[ $ans == "PK" ]];
                then

        echo $cols > $table_name
                echo $dataTypes >> $table_name
                elif [[ $ans == "NO" ]];
                then

        echo $cols > $table_name
        echo $dataTypes >> $table_name
        else
                        echo "Wrong choice"
			exit
                                fi
                        fi
        meta=$meta$ans


 echo $meta >> $table_name.meta
                        done
		fi      
		done
                        ;;

   2)
           echo "Enter name of the table you need to drop"
                        read table_name
                if [ -e $table_name ];
                then
                        rm -f $table_name
                else
                       echo "Wrong table name"
               fi
                        ;;



   3)
               echo "Enter table name you will insert in it"
                read table_name
                if [ -e $table_name ];
                then

               
        data=""


colsNum=`awk 'END{print NR}' $table_name.meta`


                for(( m = 1 ; m <= $colsNum ; m++ ))
                do
   colName=$(awk 'BEGIN{FS=":"}{ if(NR=='$m') print $2}' $table_name.meta)
    colType=$(awk 'BEGIN{FS=":"}{if(NR=='$m') print $1}' $table_name.meta)
    colKey=$(awk 'BEGIN{FS=":"}{if(NR=='$m') print $3}' $table_name.meta)



    colLineNumber=`cut -d: -f3 $table_name.meta | grep -n -w "^PK$" | cut -d: -f1` 

   echo -e "Name of Col ($colName) Type ($colType) = \c"
   read col_data

while [[ true ]]; do

if [[ $colKey == "PK" ]];
 then
        while [ true ]; do
        if [[ -z $col_data ]]; then
            echo -e "Invalde PK\n"
            echo -e "$colName ($colType) = \c"
            read col_data
            else
            break
        fi
        done
else 
break 
    fi
 



if [[ $colKey == "PK" ]]; then
        while [ true ]; do
  checkpk=`cut -d: -f"$colLineNumber" $table_name | grep -c -w "$col_data"`  

        if [[ $checkpk != 0 ]]; then
            echo -e "Invalde PK\n"
            echo -e "$colName ($colType) = \c"
            read col_data
        else
            break
        fi

        done
        
        
    fi
if [[ $colType == "int" ]]; then
            while ! [[ $col_data =~ ^[0-9]*$ ]]; do
                echo -e "invalid Data Type! Try Again\n"
                echo -e "$colName ($colType) = \c"
                read col_data
            done
        fi
        break
    done

#if [[ $colType == "string" ]];
#then
 #       while ! [[ $col_data == ^[A-Za-z]* ]];
  #      do
   #                echo "Syntax Error"

    #    echo -e "$colName ($colType) = \c"
     #           read col_data
#continue;
#done
#fi
#done

 	if [[ $m == $colsNum ]]; 
then

      record=$record:$col_data
    else
      record=$record$col_data
    fi




      done
      
      echo -e $record >> $table_name
       record=""
       else
	       echo "Table doesn't exist"
fi



        
                                ;;

4)
     echo "Enter the name of the table you need to update"
          read table_name
      if [[ -e $table_name ]];
then
     echo "Enter the name of column"
          read col_name
cid=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$col_name'")print i}}}' $table_name)
	    
#colNum=$(awk 'BEGIN{FS=":"}{if(NR==3){for(i=3;i<=NF;i++){if("'$col_name'"==$i) print i}}}' $table_name 2>> /dev/null)
 if [[ $cid == "" ]];
                then
                        echo "Not Found"

                else                     

echo "Enter the value you want to be updated"
            read vupdate

         echo "Enter the old value"
             read oldval
 result=$(awk 'BEGIN{FS=":"}{if($'$cid'=="'$oldval'")print NR}' $table_name)

                        if [[ $result == "" ]];
                        then
                                echo "Value Not Found"

                        else

#sed -i ''$colNum's/'$oldval'/'$vupdate'/g' $table_name 2>> /dev/null
sed -i 's/'$oldval'/'$vupdate'/g' $table_name 2>> /dev/null
#else 
#	echo "Column not found"
fi
fi
else
	echo "Table doesn't Exist"
fi      
;;


    5)
                echo "Enter table name "
                read table_name
		 if [[ -e $table_name ]];
then


                echo "Enter column name"
                read col_name

   cid=$(awk 'BEGIN{FS=":"}{if( NR==1){for(i=1;i<=NF;i++){if($i=="'$col_name'")print i}}}' $table_name)

                echo $cid
                if [[ $cid == "" ]]
                then
                        echo "Not Found"

                else
                        echo "Enter Value"
                        read value
            res=$(awk 'BEGIN{FS=":"}{if($'$cid'=="'$value'")print NR}' $table_name)

            echo $res

                        if [[ $res == "" ]]
                        then
                                echo "Value Not Found"

                        else
                                NR=$(awk 'BEGIN{FS=":"}{if($'$cid'=="'$value'")print NR}' $table_name)
                                echo $NR
                                sed -i ''$NR'd' $table_name 2>>err
                                echo "deleted"
                        fi
                fi
	else
		echo "table name doesn't exist"
	fi
	                            	 ;;


        6)
           select Choice in "Press 1 to select all" "Press 2 to select column" "Press 3 to select with condition" "Press 4 to Exit"
       do
               case $REPLY in
		       1) echo "Enter table name"
                               read table_name
			        if [[ -e $table_name ]];
                               then
                               sed -n '3,20p' $table_name;
		       else
			       echo "Not found"
		       fi
                               ;;
                      2)
                              echo "Enter table name"
                              read table_name
			       if [[ -e $table_name ]];
                               then
                              echo "Enter column name"
                              read col_name
    cid=$(awk 'BEGIN{FS=":"}{if( NR==1){for(i=1;i<=NF;i++){if($i=="'$col_name'")print i}}}' $table_name)

     if [[ $cid == "" ]];
                then
                        echo "Not Found"

                else

                           cut -d: -f$cid $table_name
		   fi
			   else
                               echo "Not exist"
                      
	       fi


                           ;;

                   3)
                           echo "Enter table name "
                read table_name
		if [[ -e $table_name ]];
                               then
                echo "Enter column name"
                read col_name


                cid=$(awk 'BEGIN{FS=":"}{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$col_name'")print i}}}' $table_name)
                echo $cid

                if [[ $cid == "" ]];
                then
                        echo "Not Found"

                else
                        echo "Enter Value"
                        read values


            result=$(awk 'BEGIN{FS=":"}{if($'$cid'=="'$values'")print NR}' $table_name)


                        if [[ $result == "" ]];
                        then
                                echo "Value Not Found"

                        else
				NRs=$(awk 'BEGIN{FS=":"}{if($'$cid'=="'$values'")print NR}' $table_name)


                                sed -n ''$NR'p' $table_name 2>> /dev/null
                        fi
                fi
	else
		echo "table NOT Exist"
	fi
        
        	;;
	4)
          	exit
        	;;	

			esac

		done

		;;
		

7)
        exit
        ;;

		

esac
		
	done
fi

;;

                4)
                        echo "Enter database that you need to drop"
                        read dr_db
                        if [ -e $dr_db ];
                        then
                                rm -r ~/Downloads/Bash_Project/$dr_db
                                echo "Database is deleted successfully"
			else
				echo "Database doesn't exist"
                        fi
			;;
		5) 
			exit
			;;
	       	esac


                done

	

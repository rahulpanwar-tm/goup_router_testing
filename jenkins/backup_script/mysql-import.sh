cd $6
VAR=$(ls -tr|tail -1)
## declare an array variable
declare -a arr=("$1" "$2")

## now loop through the above array
for i in "${arr[@]}"
do
   echo "$i"
   # or do whatever with individual element of the array
gzip -d $6/$VAR/$i-$VAR.sql.gz
mysql -u $4 --host $3 --port $7 -p$5 $i < $6/$VAR/$i-$VAR.sql
done


# rp rp_tp 192.168.1.34 root Ttpl@123 /home/ttpl/jenkins/ 3306
# 1		2		3		4		5		6					7
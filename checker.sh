!/bin/bash
set -xu
echo "Read log file and pull all rows that match an ip in the file ip_list"
echo "ip.found      : IP addresses in the log file that match ip_list"
echo "ip.notfound   : IP addresses not found in the log file"
echo "ip.found.date : Returns the full row that macthes an IP from ip_list"
ip_list="ip_list"
rm -f ip.*
while read ip
do
    pushd /path/to/date/directory
    date_variable=$(ls -t | head -n1)
    cd $date_variable
    hour_variable=$(ls -t | head -n1)
    cd $hour_variable
    if grep -F "$ip" messages.log | grep -qE "^[A-Z][a-z]{2}\s[0-9]{2}\s([0-9]{2}:){2}[0-9]{2}\s$ip\s"; then
    popd
    echo "$ip" >> ip.found
     else
        popd
    echo "$ip" >> ip.notfound
     fi
done  < "$ip_list"
exit

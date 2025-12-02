# web-trackers
Automated bash script to collect data and make into graphs

Each script is being automatically ran using crontab
Crontab setup:
0 */6 * * * /mnt/c/Users/User/Documents/Coursework/scrape.sh >> /tmp/cron.log 2>&1

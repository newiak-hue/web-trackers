# web-trackers
Automated bash script to collect data and make into graphs

Each script is being automatically ran using crontab
Crontab setup:
0 */6 * * * /mnt/c/Users/User/Documents/Coursework/scrape_gold.sh >> /tmp/cron_gold.log 2>&1
0 */6 * * * /mnt/c/Users/User/Documents/Coursework/scrape_silver.sh >> /tmp/cron_silver.log 2>&1
0 */6 * * * /mnt/c/Users/User/Documents/Coursework/scrape_bitcoin.sh >> /tmp/cron_bitcoin.log 2>&1
0 */6 * * * /mnt/c/Users/User/Documents/Coursework/scrape_ethereum.sh >> /tmp/cron_ethereum.log 2>&1

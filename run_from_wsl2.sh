myip=$(hostname -I)
echo $myip
#wslview http://$myip:4000/
bundle exec jekyll serve --force_polling --host $myip

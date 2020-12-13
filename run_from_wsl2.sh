myip=$(hostname -I)
echo $myip
bundle exec jekyll serve --force_polling --host $myip

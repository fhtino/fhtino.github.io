myip=$(hostname -I)
echo $myip
bundle exec jekyll serve --verbose --force_polling --host $myip

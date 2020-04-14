#!/bin/bash

file=~/websites.txt

make_a_choice () {
  if [[ $1 == "y" || $1 == "Y" ]]; then
    echo "yes, ok lets add a website"
    read website
    add_websites $website
  elif [[ $1 == "n" || $1 == "N" ]]; then 
    if [ -s "$file" ]; then
        open_browser
    else 
        echo "See ya!"
        exit 1
    fi
  else
    echo "invalid input"
    exit 1
  fi 
}

add_websites () {
  echo $1 >> "$file"
  echo "you have added the website" $1

  echo "do you want to add another? (y/n)"
  read website_choice
  make_a_choice $website_choice
}

open_browser () {
  while IFS= read -r line
  do
    lets_go $line
  done <"$file"
}

lets_go () {
  if [[ "$OSTYPE" == "linux-gnu" || "$OSTYPE" == "freebsd"* ]]; then
    xdg-open $1
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    open $1
  else
    echo "Not supported"
    exit 1
  fi
}

main() {
  if [ -s "$file" ]; then
    open_browser
  else
    echo "oh, looks like you don't have any fav websites stored"
    echo "press y to add websites and n to abort (y/n)"
    read choice
    make_a_choice $choice
  fi
}

main
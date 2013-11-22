echo off

git remote remove dev
git remote remove production
git remote add dev ssh://brady@webclicker.tk/~/dev/
git remote add production ssh://brady@webclicker.tk/~/www/

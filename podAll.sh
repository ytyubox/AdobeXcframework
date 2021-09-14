STARTDIR=$(pwd)
echo $STARTDIR
find "$(pwd)" -name "Podfile" -print0 | while read -d $'\0' file
do
    PWD=$(echo $file | sed 's|/[^/]*$||')
    echo "$file"
    cd "$PWD"
    git pull
    pod install
    pod update
done
cd $STARTDIR


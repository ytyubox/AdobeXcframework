STARTDIR=$(pwd)
echo $STARTDIR
find "$(pwd)" -name "*.xcframework" -print0 | while read -d $'\0' file
do
    rm -rf $file
done
find "$(pwd)" -name "Podfile" -print0 | while read -d $'\0' file
do
    PWD=$(echo $file | sed 's|/[^/]*$||')
    echo "$file"
    cd "$PWD"
    make archive
done
cd $STARTDIR
rm -rf build
mkdir -p build
find "$(pwd)" -name "*.xcframework" -print0 | while read -d $'\0' file
do
    echo $file
    PWD=$(echo $file | sed 's|/[^/]*$||')
    cd "$PWD"
    tag=$(git describe --tags)
    FILENAME=$(basename $file)
    TONAME="$STARTDIR/build/${tag}-${FILENAME}"

    echo $(pwd)
    echo $FILENAME
    echo $TONAME
    echo "###"

    cp -R $FILENAME $TONAME
done

cd $STARTDIR


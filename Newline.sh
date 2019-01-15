for i in `find . -name "Contents.json" -type f`; do
sed -i  ''  -e '$a\' "$i"
done

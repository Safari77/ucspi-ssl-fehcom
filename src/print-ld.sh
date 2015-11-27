ld="`head -1 conf-ld`"
systype="`cat systype`"

flag=0

rm -f trycpp.o

flag=`cc -c tryssl.c -m64 2>&1 | wc -l` 
if [ $flag -eq 0 ]; then
  ld="$ld -m64"
fi

rm -f trycpp.o

cat warn-auto.sh
echo 'main="$1"; shift'
echo exec "$ld" '-o "$main" "$main".o ${1+"$@"}'

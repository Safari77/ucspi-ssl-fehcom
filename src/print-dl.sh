ssllib="`head -1 conf-ssllib`"

dlflag=0

rm -f trycpp.o

dlflag=`cc -c tryssl.c -ldl 2>&1 | wc -l`
if [ $dlflag -eq 0 ]; then
  ssllib="$ssllib -ldl"
fi

rm -f trycpp.o

echo $ssllib

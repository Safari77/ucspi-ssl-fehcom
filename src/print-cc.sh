cc="`head -1 conf-cc`"
systype="`cat systype`"


cc -c trycpp.c -malign-double >/dev/null 2>&1 \
&& ccad="-malign-double"

cc -c trycpp.c -march=ultrasparc >/dev/null 2>&1 \
&& ccus="-march=ultrasparc"

cc -c trycpp.c -march=powerpc >/dev/null 2>&1 \
&& ccpp="-march=powerpc"

cc -c trycpp.c -march=21164 >/dev/null 2>&1 \
&& cc21="-march=21164"

rm -f trycpp.o

ccssl=""
cc -c tryssl.c >/dev/null 2>&1 \
|| ccssl="`head -1 conf-ssl`"

ccbase="gcc -fomit-frame-pointer -Wimplicit -Wunused -Wcomment -Wchar-subscripts -Wuninitialized -Wshadow -Wcast-qual -Wcast-align -Wwrite-strings"

case "$cc:$systype" in
  auto:*:i386-*:*)
    cc="$ccbase -O1 $gccad"
    ;;
  auto:*:sparc-*:*:*:*)
    cc="$ccbase -O1 $gccus"
    ;;
  auto:*:ppc-*:*:*:*)
    cc="$ccbase -O2 $gccpp"
    ;;
  auto:*:alpha-*:*:*:*)
    cc="$ccbase -O2 $gcc21"
    ;;
  auto:aix-*:-:-:*:-)
    cc="$ccbase -O2 $gccpp"
    ;;
  auto:*)
    cc="$ccbase -O2"
    ;;
esac

cat warn-auto.sh
echo exec "$cc" "$ccssl" '-c ${1+"$@"}'

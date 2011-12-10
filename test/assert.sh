
set -e
count=1

plan () {
  echo $count..$1
}

assert () {
  set +e
  "$@" &> assert.out
  ret=$?
  set -e
  if [ $ret -eq 0 ]; then
    echo ok $count "$@"
  else
    echo not ok $count "$@"
    cat assert.out
    exit 1
  fi
  let count=$count+1
}

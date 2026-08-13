#! /usr/bin/python3
if [ $# -ne 1 ]
then
  echo "ERROR : Please pass the name of benchmark"
  return
elif [ ! -e src/$1.hip ]
then
  echo "ERROR : $1 not exists"
  return
fi

echo "rebuilding $1" 
cmake --build build -t clean
cmake --build build -t hipPass
cmake --build build -t $1
cmake --build build -t INJECT_$1
roc-obj -o tmp/ISA -d ./bin/$1
roc-obj -o tmp/ISA -d ./bin/INJECT_$1
./bin/$1 && ./bin/INJECT_$1 
#!/bin/bash

<<COMMENT_OUT
./do.sh a
でarcxxx_a.cppをコンパイルし, テストケースに通す
これはarcxxxから行う. arcxxx_aディレクトリに遷移してはいけない.
./do.sh a uu
で実行. uuの部分はなんでも良い.
COMMENT_OUT

problem=$1  #a, bなどの問題番号
full_cr_dir_name=`pwd *`  #カレントディレクトリの絶対パス
#カレントディレクトリの名前
cr_dir_name=`echo ${full_cr_dir_name} | awk -F "/" '{ print $NF }'`
sub_dir_name="${cr_dir_name}_${problem}"  #テストする問題のディレクトリ名前

if [ ! -e "$sub_dir_name" ]; then  #テストする問題のディレクトリが見つからない場合
  echo "Error : ${sub_dir_name} Doesn't Exist."
  exit 1
fi

cd "$sub_dir_name"
file_name="${sub_dir_name}.cpp"

if [ ! -e "$file_name" ]; then  #テストするc++ソースが存在しない場合
  echo "Error : ${file_name} Doesn't Exist."
  cd ../
  exit 1
fi

if [ $# = 2 ]; then #テストするc++ソースがboostライブラリを使用している
  g++ "$file_name" -I /usr/local/include
elif [ $# = 1 ]; then
  g++ "$file_name"
fi

oj t
cd ../

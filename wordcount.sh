#!/bin/bash

# Count words in various sections of the PDF file specified
#file=$1
file="main.pdf"

pdftotext ${file} ${file}.txt
methline=`grep -P "Online Methods$" ${file}.txt -n | head -n 1 | cut -sd: -f1`
refline=`grep -P "^References$" ${file}.txt -n | head -n 1 | cut -sd: -f1`
sed -n "1,$((${methline}-1))p" ${file}.txt > ${file}.txt.body
sed -n "${methline},$((${refline}-1))p" ${file}.txt > ${file}.txt.onl_meth
sed -n "${refline},\$p" ${file}.txt > ${file}.txt.ref
wc ${file}.txt ${file}.txt.body ${file}.txt.onl_meth ${file}.txt.ref
rm ${file}.txt ${file}.txt.body ${file}.txt.onl_meth ${file}.txt.ref

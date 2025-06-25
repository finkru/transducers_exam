lexd task.lexd | hfst-txt2fst -o lexd.hfst
hfst-twolc -q task.twol -o twol.hfst
hfst-compose-intersect lexd.hfst twol.hfst -o task.hfst

hfst-fst2strings task.hfst > forms.txt

grep -xvf forms.txt for_test_exam_02.txt > missing_forms.txt
if [ -s missing_forms.txt ]; then
    echo "Error: The following forms are missing from the output:"
    cat missing_forms.txt
else
    echo "All forms are present in the output."
fi

rm -f forms.txt missing_forms.txt twol.hfst lexd.hfst
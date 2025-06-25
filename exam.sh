lexd task.lexd | hfst-txt2fst -o lexd.hfst
hfst-twolc -q task.twol -o twol.hfst
hfst-compose-intersect lexd.hfst twol.hfst -o task.hfst

curl -s https://raw.githubusercontent.com/agricolhw4-finkru/exam/exam.ipynb hw4-finkru/exam/exam.sh hw4-finkru/exam/task.lexd hw4-finkru/exam/task.twolamz/2025_morphological_transducers/refs/heads/main/task_tests/for_test_exam_02.txt > for_test_exam_02.txt

hfst-fst2strings task.hfst > forms.txt

grep -xvf forms.txt for_test_exam_02.txt > missing_forms.txt
if [ -s missing_forms.txt ]; then
    echo "Error: The following forms are missing from the output:"
    cat missing_forms.txt
else
    echo "All forms are present in the output."
fi

rm -f forms.txt missing_forms.txt twol.hfst lexd.hfst for_test_exam_02.txt
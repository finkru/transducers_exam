curl -s https://raw.githubusercontent.com/r-classes/hw4-finkru/refs/heads/main/exam/task.lexd?token=GHSAT0AAAAAADF5ZKEWKRMOO547YWBJHVXA2C4F2FA > task.lexd
curl -s https://raw.githubusercontent.com/r-classes/hw4-finkru/refs/heads/main/exam/task.twol?token=GHSAT0AAAAAADF5ZKEXHA2NDC54JBCHVCCY2C4F25Q > task.twol

lexd task.lexd | hfst-txt2fst -o lexd.hfst
hfst-twolc -q task.twol -o twol.hfst
hfst-compose-intersect lexd.hfst twol.hfst -o task.hfst

curl -s https://raw.githubusercontent.com/agricolamz/2025_morphological_transducers/refs/heads/main/task_tests/for_test_exam_02.txt > for_test_exam_02.txt

hfst-fst2strings task.hfst > forms.txt

grep -xvf forms.txt for_test_exam_02.txt > missing_forms.txt
if [ -s missing_forms.txt ]; then
    echo "Error: The following forms are missing from the output:"
    cat missing_forms.txt
else
    echo "All forms are present in the output."
fi

rm -f task.hfst forms.txt missing_forms.txt twol.hfst lexd.hfst exam.hfst for_test_exam_02.txt
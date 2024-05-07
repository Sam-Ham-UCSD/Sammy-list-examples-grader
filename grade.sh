CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'


rm -rf student-submission
rm -rf grading-area


mkdir grading-area


git clone $1 student-submission
echo 'Finished cloning'


if [[ -f student-submission/ListExamples.java ]]
then
    echo "ListExamples.java exists"
else
    echo "ListExamples.java does not exist"
    echo "Grade: 0"
    exit
fi


cp student-submission/ListExamples.java TestListExamples.java grading-area
cp -r lib grading-area


cd grading-area
javac -cp $CPATH *.java
echo "The exit code of javac is $?"


if [[ $? -ne 0 ]]
then
    echo "Failed to compile"
    echo "Grade: 0"
    exit
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

if [[ $? -ne 0 ]]
then
    echo "Failed at least one test"
    echo "Grade: 1"
    exit
fi

echo "Everything works!"
echo "Grade: 2"
exit

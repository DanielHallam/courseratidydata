DATA DICTIONARY - TIDY DATASET

activity
Class: Factor with 6 levels
Description: Type of activity measured

subject
Class: Factor with 477 levels
Description: calculations on accelerator and gyroscope 3-axial raw signals

measure
Class: Numeric
Description: Measurement value that may be standard deviation or mean

Transformations
1. Train data measurement file is read in as a fixed format file with width of 16.

2. Train data label file and subject file are read in as column binds to the train dataset.

3. Test data measurement file is read in as a fixed format file with width of 16.

4. Test data label file and subject file are read in as column binds to the test dataset.

5. Test dataset and train dataset column names are renamed to "measure", "activity", and "subject"

6. Train dataset and test dataset are row combined into single dataset called dataset

7. Features file is read into features dataset. Dataset subject is replaced by second column of features data by matching to first column of features dataset. Note this changes subject from integer to factor

8. Activity file is read into activity dataset. Dataset activity is changed into a factor from integer. Levels are then replaced by second column of activity dataset

9. Grep used to filter dataset subject on mean() and std() variables

10. Aggregate function across subject and activity is output to outputdata dataset

11. Outputdata is written to text file "Tidy Data.txt" using write table command
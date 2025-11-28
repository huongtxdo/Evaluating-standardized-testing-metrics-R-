# Evaluating-standardized-testing-metrics-R-
====================

## Motivation

During the admission period, the topic that is often discussed among many students is about the admission criteria, including necessary certificates and diplomas. In order to decide who to be accepted into their programs, universities rank students based on their grades in the matriculation examinations and diplomas, or their results on standardized tests such as SAT (Scholastic Aptitude Test) and ACT (American College Test). Regarding the SAT or ACT, there have been many debates and arguments about whether such tests are a good reflection of students’ scholastic capabilities, or rather a tool to measure their test preparedness. In addition, the average scores of students coming from different races or economic classes also differ greatly, meaning that certain groups of students have more chances in college than others who are less fortunate. 

The goal of my project is to look at the actual performance of students coming from different backgrounds and try to find any proof to either prove or disprove the claim above.  Through analyzing the data, I hope to know whether students’ race or ethnicity plays a role in determining their test result, whether they are influenced by their parents’ level of education, and whether the standardized tests are anything more than just a measure of preparedness. 


## Data description and cleaning process

The dataset used in this project is Student Study Performance acquired from Kaggle.com. The dataset consists of 1000 observations of 8 variables, five of which are the students’ background, and the rest is the students’ score in math, reading, and writing. Before analyzing, the data is transformed into numeric values for simplicity. The cleaning process of each variable is listed below:  

- Gender: Mapping ‘male’ values to 1 and ‘female’ values to 2.

-	Race/ethnicity: Mapping "group A", "group B", "group C", "group D" and "group E” to 1, 2, 3, 4, and 5, respectively.

-	Parental level of education – the parents’ final education: Mapping "some high school", "high school", "associate degree", "some college"," bachelor's degree", and "master's degree" to 1, 2, 3, 4, 5, and 6, respectively.

-	Lunch – the kind of lunch student has before test: Mapping “standard” to 1, and “free/reduced” to 2 (n.b. free/reduced lunch means that students have an incomplete or no lunch).

-	Test preparation course: Mapping “none” to 1, and “completed” to 2.

-	Math, reading, and writing scores:  Scores from 0 to 10 is labeled as 1, 11 to 20 is labeled as 2, …, and 91 to 100 is labeled as 10.

## Results

There is indeed a positive relationship between parents’ level of education and students’ performance, such that higher educated parents tend to have their children perform better in tests and exams. This could be explained based on the fact that parents with higher levels of education often have better jobs with higher salary and thus are able to support their children’s education better. 

When it comes to students’ race or ethnicity, the graph shows students from a certain group (race 5) tend to outperform their peers. On the other hand, students from another group (race 3) seem to struggle greatly with their tests. This goes to say that there is indeed a correlation between students’ race and their test result. This may be due to differences in their economic power, social opportunity, or cultural values. 

When it comes to preparedness, students who prepare better for the test, either through a preparation course well ahead or having access to their best physique right before the exam, will most likely become top performers. This can be seen as proof of exams being a measure of preparedness, which I personally believe to be the case.

The three research questions mentioned at the beginning have been partially answered as the analysis should only show the correlation between different variables, rather than confirming a causation. Having said that, it is fair to say that tests and exams in general measure how well students prepare for them, either by studying well in advance (mentally) or by eating well before the tests (physically). It is also not implied that races and ethnicities determine the outcome of students’ tests, rather it is due to whether students have access to more privileges compared to their peers. As of now, it is hard to disapprove of the use of one test’s results in determining a student’s scholastic ability, but we can update the tests’ definitions to include students’ preparedness.

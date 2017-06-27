# ST Commit Analyzer

A basic commit analyzer allowing tutors to gain a quick overview of a
git repository for more objective grading.

## Setup

* Install git (Development version: git version 2.11.0 (Apple Git-81))
* Install ruby 2.x (Development version: ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin16])
* Install bundler

    $ gem install bundler

* Install dependencies

    $ bundle install

## Analyze Commits


* Blaming the code in production (based on the current branch of the repo)

```
$ ./blame-analyzer.rb path/to/repo
Time: 00:00:02 |====================================================================================================================>>| 100% Analyzing

============================================================ Summary (in current version) ============================================================
                           	LOC     	      	             	               	       	       	         	Commits
                           	solitary	paired	participation	participation %	owned  	owned %	pairing %	created	participated
Student 1 (S1)             	185     	5073  	5258         	56.93%         	2518.0 	27.26% 	96.48 %  	50     	50
Student 2 (S2)             	144     	4457  	4601         	49.82%         	2164.17	23.43% 	96.87 %  	3      	31
Student 3 (S3)             	1689    	222   	1911         	20.69%         	1744.5 	18.89% 	11.62 %  	30     	30
Student 4 (S4)             	4       	1773  	1777         	19.24%         	682.17 	7.39%  	99.77 %  	1      	22
Student 5 (S5)             	18      	1503  	1521         	16.47%         	566.0  	6.13%  	98.82 %  	12     	26
Student 6 (S6)             	167     	1232  	1399         	15.15%         	609.0  	6.59%  	88.06 %  	16     	17
Student 7 (S7)             	92      	1217  	1309         	14.17%         	526.5  	5.7%   	92.97 %  	2      	12
Student 8 (S8)             	5       	933   	938          	10.16%         	297.5  	3.22%  	99.47 %  	2      	8
Student 9 (S9)             	111     	0     	111          	1.2%           	111.0  	1.2%   	0.0 %    	3      	3
Unknown name (US):         	0       	29    	29           	0.31%          	9.67   	0.1%   	100.0 %  	0      	1
Unknown name (OS):         	0       	15    	15           	0.16%          	7.5    	0.08%  	100.0 %  	0      	1
```

* Analyzing upstream/master log (solely based on commit messages using naming convention, looking at upstream/master):

```
$ ./log-analyzer.rb path/to/repo
S1: 67
S2: 36
S3: 35
S4: 30
S5: 14
S6: 12
S7: 7
S8: 2
S9: 2
```
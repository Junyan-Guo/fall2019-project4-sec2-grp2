# Project 4: Algorithm implementation and evaluation: Collaborative Filtering
### [Project Description](doc/project4_desc.md)
Term: Fall 2019
+ Team # 2
+ Projec title: Algorithm Implementation and Evaluation: Collaborative Filtering for Nexflix movie rating dataset
+ Team members:
	+ Chai, Nyu nc2774@columbia.edu
	+ Hu, Hang hh2718@columbia.edu
	+ Huang, Yian yh3127@columbia.edu
	+ Xu, Chang cx2207@columbia.edu
	+ Yang, Nan ny2291@columbia.edu
+ Project summary: 
	+ **Background** 
	
        Recommender systems, a system mainly focus on matching consumers with most appropriate products in order to enhance user satisfication and loyalty, usually based on one of two strategies: The content filtering approach and the **_collaborative filtering_** method. The content filtering approach creates a profile for each user or product to characterize its nature, while collaborative filtering relies only on past user behavior—like ratings without requiring the creation of explicit profiles. The two primary areas of **_collaborative filtering_** are the neighborhood methods and **_latent factor models_**. Neighborhood methods are centered on computing the relationships between items or between users. **_latent factor models_** are an alternative approach that tries to explain the ratings by characterizing both items and users on, say, 20 to 100 factors inferred from the ratings patterns. Some of the most successful realizations of latent factor models are based on **_matrix factorization_** methods.


 	+ **Objective** 
	
        In this project, our group implement **_matrix factorization_** by focusing on different versions of alternating least squares algorithm for different Regularizations and KNN as Post-processing. The objective is to produce a good prediction of users’ preferences for movies on on the Netflix Prize dataset. For this project, our team #2 is assigned with [Pairing combination 9 + 11 + 13  from the Collaborative](https://drive.google.com/file/d/1NPcbGBv9hVOTXr1sYq_R7ze0qC25CkuB/view). For evaluation, we compared RMSE results for different methods. Our group used R lanauage to product model and reports. The specific technique used for the combination are illustrated below. You can also [click here (https://github.com/TZstatsADS/ADS_Teaching/blob/master/Projects_StarterCodes/Project4-RecommenderSystem/doc/Matrix%20Factorization.pdf) for more details of our methods. 

 		+ **Algorithms** 
 		- [ ] Stochastic Gradient Descent
 		- [ ] Gradient Descent with Probabilistic Assumptions
 		- [x] Alternating Least Squares 

 		+ **Regularization** 
 		- [x] Penalty of Magnitudes 
 		- [x] Bias and Intercepts
 		- [x] Temporal Dynamics

 		+ **Post-processing** 
 		- [x] KNN
 		- [ ] kernel ridge regression


 	+ **Data** 

         Our Netfilx Prize dataset includes 100836 ratings and 3683 tag applications across 9742 movies. These data were created by 610 users between March 29, 1996 and September 24, 2018. This dataset was generated on September 26, 2018. Users were selected at random for inclusion. All selected users had rated at least 20 movies. 
	 
 	+ **Results** 
	
	
Methods       | f            |\lambdas      |Max Iteration | Train RMSE  | Test RMSE
------------- | -------------|------------- | -------------|-------------|-------------
A3+P2         |            10|          0.1 |      5       |       0.5893|1.3447
A3+R1R2+P2    |           20 |           10 |            4 |       0.5926| 1.3426
A3+R3+P2      | Content Cell | Content Cell | Content Cell | Content Cell| Content Cell


+ **Contribution statement**: 
	+ Implementation of modeling A3+R1+R2: Hu Hang, Yang Nan
	+ Kniting [`Project_4_ALSR1R2.pdf`](https://github.com/TZstatsADS/fall2019-project4-sec2-grp2/blob/master/doc/Project_4_ALSR1R2.pdf) and [`Project_4_ALSA3-.pdf`](https://github.com/TZstatsADS/fall2019-project4-sec2-grp2/blob/master/doc/Project_4_ALSA3-.pdf) report : Hu Hang, Yang Nan
	
	+ Implementation of modeling A3+R3: Xu Chang
	+ Implementation of modeling P2:Huang Yian
	+ Preparing Slides for presentation & presentation : Nyu Chai
	+ Results Report: Nyu Chai, Huang Yian
	
 + **References**
	+ Y. Koren. “Matrix Factorization Techniques for Recommender Systems.” Journal Computer, 42 , no. 8, 2009, pp. 30–37.
	+ A. Paterek, “Improving Regularized Singular Value Decomposition for Collaborative Filtering,” Proc. KDD Cup and Workshop, ACM Press, 2007, pp. 39-42.
	+ R. Salakhutdinov and A. Mnih, “Probabilistic Matrix Factorization,” Proc. Advances in Neural Information Processing Systems 20 (NIPS 07), ACM Press, 2008, pp. 1257-1264.
	+ Y. Zhou et al., “Large-Scale Parallel Collaborative Filtering for the Netflix Prize,” Proc. 4th Int’l Conf. Algorithmic Aspects in Information and Management, LNCS 5034, Springer, 2008, pp. 337-348.
	+ Y. Koren, “Collaborative Filtering with Temporal Dynam- ics,” Proc. 15th ACM SIGKDD Int’l Conf. Knowledge Discovery and Data Mining (KDD 09), ACM Press, 2009, pp. 447-455.

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.
```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```
Please see each subfolder for a README file.

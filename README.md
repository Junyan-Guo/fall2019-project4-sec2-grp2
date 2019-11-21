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
        
        Recommender systems usually based on one of two strategies. The content filtering approach and the **_collaborative filtering_** method. The content filtering approach creates a profile for each user or product to characterize its nature, while collaborative filtering relies only on past user behavior—like ratings without requiring the creation of explicit profiles. The two primary areas of **_collaborative filtering_** are the neighborhood methods and **_latent factor models_**. Neighborhood methods are centered on computing the relationships between items or between users. **_latent factor models_** are an alternative approach that tries to explain the ratings by characterizing both items and users on, say, 20 to 100 factors inferred from the ratings patterns. Some of the most successful realizations of latent factor models are based on **_matrix factorization_**.
        
	+ **Objective** 
        
        In this project, our group implement, evaluate and compare algorithms for **_Collaborative Filtering_** to produce a good prediction of users’ preferences for movies on on the Netflix Prize dataset. 
        
	+ **Data** 

        Our Netfilx Prize dataset includes 100836 ratings and 3683 tag applications across 9742 movies. These data were created by 610 users between March 29, 1996 and September 24, 2018. This dataset was generated on September 26, 2018. Users were selected at random for inclusion. All selected users had rated at least 20 movies. 

	+ **Approach** 
	



Challenge

Collaborative filtering refers to the process of making automatic predictions (filtering) about the interests of a user by collecting preferences or taste information from many users (collaborating).

For this project, our team is assigned specific algorithms from the Collaborative filtering literature. The aim of this project is to will study the algorithms carefully and implement them, from scratch. The details of the pairing assignment is in https://drive.google.com/file/d/1NPcbGBv9hVOTXr1sYq_R7ze0qC25CkuB/view. 

	
**Contribution statement**: [default] All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement. 


Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

**References**
1. Y. Koren. “Matrix Factorization Techniques for Recommender Systems.” Journal Computer, 42 , no. 8, 2009, pp. 30–37.
2. A. Paterek, “Improving Regularized Singular Value Decomposition for Collaborative Filtering,” Proc. KDD Cup and Workshop, ACM Press, 2007, pp. 39-42.
3. R. Salakhutdinov and A. Mnih, “Probabilistic Matrix Factorization,” Proc. Advances in Neural Information Processing Systems 20 (NIPS 07), ACM Press, 2008, pp. 1257-1264.
4. Y. Zhou et al., “Large-Scale Parallel Collaborative Filtering for the Netflix Prize,” Proc. 4th Int’l Conf. Algorithmic Aspects in Information and Management, LNCS 5034, Springer, 2008, pp. 337-348.
5. Y. Koren, “Collaborative Filtering with Temporal Dynam- ics,” Proc. 15th ACM SIGKDD Int’l Conf. Knowledge Discovery and Data Mining (KDD 09), ACM Press, 2009, pp. 447-455.
```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.

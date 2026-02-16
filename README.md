# *Comparative Study of a Stochastic Pure Death Process and Cox Proportional Hazards Models in Analyzing Survival of Breast Cancer in Netherlands Women*

### **Authors**
- Oladipo Afolayan
- Jeremiah Akpabio
- Sandile Ndabezitha
- Francis Nkansah
- Aaron Niecestro  

---

## **Abstract**

> “This study aimed to obtain a pure death process model and Cox proportional hazard model to predict the hazard rates for 272 women with breast cancer in the Netherlands… The pure death process ran ten thousand simulations… These values were then compared to the Netherlands' actual estimates… Furthermore, this paper compared the efficacy of the pure death process and Cox proportional hazard models.”

This repository contains the full analysis, simulation code, and model comparison for the study.

---

## **Overview**

This project investigates breast cancer survival among 272 women in the Netherlands using **three modeling frameworks**:

1. **Stochastic Pure Death Process**  
2. **Cox Proportional Hazards Model**  
3. **Logistic Regression Model**

The goal is to evaluate how well a **stochastic process model**—rarely used in cancer survival research—performs relative to classical survival analysis tools.

The study is novel in that it applies a **pure death process** to survival data and directly compares its predictive behavior to the Cox PH model.

---

## **Why Compare These Models?**

The paper explicitly motivates the comparison:

### **1. Pure Death Process (Stochastic Modeling)**
- Captures mortality as a **Markovian, time‑dependent stochastic process**.
- Uses only **time** as the covariate.
- Allows simulation of population trajectories and death rates.
- Provides insight into whether a simple stochastic mechanism can approximate real survival patterns.

> “Both the Pure Death Process model and the Cox Proportional Hazard Model measure the probability of death over time with different statistical techniques in two different fields of biostatistics.”

### **2. Cox Proportional Hazards Model (Classical Survival Analysis)**
- Incorporates **covariates** such as tumor grade and recurrence time.
- Widely used and considered the **gold standard** for hazard modeling.
- Provides interpretable hazard ratios and model diagnostics.

### **3. Logistic Regression**
- Used as a **parametric approximation** to the pure death process.
- Allows estimation of transition probabilities when full stochastic modeling is computationally limited.

> “The logistic regression model was adopted for the pure death model because studies have shown that logistic regression is a good estimator of mortality.”

### **Purpose of Comparison**
The study evaluates:

- How well a **stochastic process** can mimic real survival data.
- Whether the **Cox PH model** provides significantly better predictive accuracy.
- Whether logistic regression can serve as a bridge between stochastic and classical methods.

This comparison highlights strengths and limitations of each approach and explores whether stochastic processes can complement or enhance traditional survival analysis.

---

## **Dataset**

- 272 breast cancer patients from the Netherlands Cancer Institute  
- 77 deaths, 195 censored observations  
- Follow‑up time: **0.27 to 18.34 years**  
- Covariates: tumor grade, recurrence time, treatments, age (subset used)

> “The data set contained 1555 columns of gene expressions… for this paper, only the columns not including gene expressions were accessed.”

---

## **Methods Implemented**

### **1. Pure Death Process Simulation**
- 10,000 simulations  
- True death rate: 0.018  
- 18.34‑year horizon  
- Summary statistics: mean, SD, SE, coverage probability  
- Additional 5‑year interval models

### **2. Survival Analysis**
- Kaplan–Meier estimator  
- Nelson–Aalen estimator  
- Comparison of simulated vs. actual survival curves

### **3. Logistic Regression**
- Predicts probability of death  
- Covariates: tumor grade, recurrence time  
- AUC = **0.923**

### **4. Cox Proportional Hazards Model**
- Covariates: log(time to recurrence), grade 2, grade 3  
- C‑statistic = **0.949**  
- Full PH diagnostics performed (martingale residuals, deviance residuals, Cox–Snell, etc.)

---

## **Key Findings**

- Pure death process achieved **>90% coverage probability** and approximated long‑term survival well.
- Logistic regression performed strongly (AUC 92.3%).
- Cox PH model performed best overall (C‑statistic 94.9%).
- Early‑year death rates were underestimated by the pure death process but converged by year 18.
- The study demonstrates the **novel application** of a pure death process to survival data.

> “To our knowledge, this is the first study to use a Pure death process to explain the diffences survival functions and other similar regression methods.”

---

## **Disclaimer (Academic Use Only)**  
This repository and all associated analyses, simulations, figures, and documentation are intended **solely for academic, educational, and research purposes**. The methods, models, and results presented here **must not** be used for clinical decision‑making, medical guidance, or real‑world patient care.


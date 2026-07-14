/* Substitutes the upstream PROC IMPORT of Diabetes_Final_Data_V2.csv (a hardcoded
   absolute path on the authors' SAS server) with a small inline sample of the
   repo's own data, so the script runs self-contained. Same 15-column schema. */
DATA WORK.Diabetes_unclean;
    LENGTH gender $6 diabetic $3;
    INFILE DATALINES DLM=',' DSD;
    INPUT age gender $ pulse_rate systolic_bp diastolic_bp glucose height weight bmi
          family_diabetes hypertensive family_hypertension cardiovascular_disease stroke diabetic $;
DATALINES;
18,Female,83,124,73,6.91,1.6,46.4,18.12,0,0,0,0,0,No
22,Female,78,130,91,5.31,1.47,61.2,28.2,0,0,0,0,0,No
25,Female,84,152,90,7.2,1.52,57.7,24.84,0,0,0,0,0,No
30,Female,85,142,82,5.35,1.55,50.3,20.95,0,0,0,0,0,No
32,Female,73,130,73,4.96,1.55,49.3,20.54,0,0,0,0,0,No
35,Female,60,125,68,5.71,1.47,42.5,19.58,0,0,0,0,0,No
35,Female,66,123,72,5.4,1.42,42.3,20.91,0,0,0,0,0,No
35,Female,66,152,81,5.08,1.57,94.9,38.27,0,0,0,0,0,No
35,Female,68,161,113,6.01,1.5,62.2,27.7,0,0,0,0,0,No
35,Female,78,139,81,6.68,1.52,64.6,27.81,0,0,0,0,0,No
35,Female,84,123,76,6.98,1.57,53.1,21.41,0,0,0,0,0,No
38,Male,91,159,102,9.22,1.6,85.2,33.27,0,0,0,0,0,No
40,Male,48,131,73,7.22,1.63,61.9,23.42,0,0,0,0,0,No
42,Female,66,110,73,5.88,1.65,70.2,25.75,0,0,0,0,0,No
46,Female,76,114,88,7.41,1.55,45.7,19.04,0,0,0,0,0,No
50,Female,104,120,81,11.36,1.52,70,30.14,0,0,0,0,0,No
50,Female,56,151,91,6.23,1.55,42.6,17.75,0,1,0,0,0,No
50,Female,58,176,89,7.02,1.57,73.5,29.64,0,1,0,0,0,No
50,Female,70,184,111,5.75,1.45,55.1,26.29,0,0,0,0,0,No
50,Male,69,139,80,11.62,1.65,46.9,17.21,0,0,0,0,0,No
51,Female,60,145,90,9.4,1.6,79,30.85,0,0,0,0,0,No
52,Female,92,207,98,6,1.77,51,16.28,0,0,0,0,0,No
55,Female,79,137,78,8.34,1.52,57.1,24.58,0,1,0,0,0,No
56,Female,72,130,84,7.35,1.5,47,20.93,0,0,0,0,0,No
57,Male,57,184,106,7,1.57,60.3,24.31,0,1,0,0,0,Yes
60,Female,65,176,103,6.83,1.42,60.5,29.9,0,1,0,0,0,No
60,Male,61,172,94,7.62,1.55,84,34.99,0,1,0,0,0,No
62,Female,57,127,74,6.85,1.52,47,20.24,0,0,0,0,0,No
63,Male,76,137,83,7.52,1.61,80,30.75,0,0,0,0,0,No
65,Male,75,128,85,5.84,1.7,50,17.26,0,0,0,0,0,No
68,Female,71,150,81,5.71,1.42,36,17.79,0,0,0,0,0,No
70,Female,85,162,92,12,1.57,64,25.96,0,0,0,0,0,No
70,Male,64,129,75,8.04,1.65,56,20.54,0,0,0,0,0,No
73,Male,55,193,112,6.28,1.63,57.4,21.72,0,0,0,0,0,No
75,Male,59,171,86,6.18,1.68,60,21.35,0,1,0,1,0,Yes
;
RUN;

/* Cleaned dataset with derived bmi_cat (upstream lines 19-42) */
DATA WORK.Diabetes_clean;
    SET WORK.Diabetes_unclean;
    IF age >= 18 AND
       bmi >= 15 AND bmi <= 55 AND
       pulse_rate >= 40 AND
       systolic_bp <= 210 AND
       glucose >= 4.0 AND glucose <= 13.3;
    LENGTH bmi_cat $12;
    IF bmi < 18.5 THEN bmi_cat = "Underweight";
    ELSE IF bmi < 25 THEN bmi_cat = "Healthy";
    ELSE IF bmi < 30 THEN bmi_cat = "Overweight";
    ELSE bmi_cat = "Obese";
    KEEP pulse_rate systolic_bp diastolic_bp glucose age gender hypertensive bmi_cat;
RUN;

/* Log-transformed responses (upstream lines 55-66) */
DATA WORK.Diabetes_transformed;
    SET WORK.Diabetes_clean;
    pulse_rate_t    = LOG(pulse_rate);
    systolic_bp_t   = LOG(systolic_bp);
    diastolic_bp_t  = LOG(diastolic_bp);
    glucose_t       = LOG(glucose);
    KEEP pulse_rate_t systolic_bp_t diastolic_bp_t glucose_t age gender hypertensive bmi_cat;
RUN;

/* One-way MANOVA: transformed responses vs BMI category (upstream lines 86-91) */
PROC GLM DATA=WORK.Diabetes_transformed;
    CLASS bmi_cat;
    MODEL pulse_rate_t systolic_bp_t diastolic_bp_t glucose_t = bmi_cat;
    MANOVA H=bmi_cat / PRINTE PRINTH;
RUN;
QUIT;

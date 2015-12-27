# Developing_Data_Products

This application is based on the build-in dataset Mtcars. The aim of this application is to show that for a linear regression 
r-squared is not a good indicator of adequation.

R-squared is always between 0 and 100%.
R-squared indicates the variability of the response data around its mean that the model explains.

Why is not a good indicator? Add variable to the model, the value always increases due to chance alone. 

Adding varables is a bad attitude, because the model WE want to build need to the simplest one that captures the important 
features  of the data (summarise and predict). 

This leads to another approch of looking at the adjusted R-squared. The explanation of this statistic is almost the same as 
R-squared but it's designed to build in an automatic penalty for adding an extra variable. 

We compare R-squared to the adjusted R-squared. 

Model building is more an art, we have to define a criterion which tries to find the good equilibrium between overfitting i.e the model too complex, and underfitting i.e. the model does not fit very well. 

The Best model is the model that maximise the adjusted R-squared (minimise the Root Mean Squared Error)

To help you pick the important features you can find the following:
 - Variable importance
 - Correlation Table
 - Regression Summary

And to check the assumption that the model captures the important features of the data and to do inference, we can use the followings:
- Regression Summary
- Regression Diagnostics

The Application is available [here](https://oge77.shinyapps.io/My_app_Developing_Data_Products)

Source code is available on the [GitHub](https://github.com/Oge77/Developing_Data_Products/)

**In the application, you may encounter delayed loading of components.**

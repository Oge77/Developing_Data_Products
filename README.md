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
We compare R-squared to the adjusted R-squared

# Capitalize

This is a very simple Tableau workbook that provides users with a text input box. The text that is input is sent to two analytics extensions, one implemented in R and one implemented in Python. Each extension returns the provided text in all caps and the resulting capitalized text is shown in the workbook.

![](../img/capitalize-workbook.png)

## [R Extension](R/plumber.R)

The R extension used in this workbook takes some input text and returns an all caps version of that text.

## [Python Extension](Python/app.py)

The Python extension used in this workbook takes some input text and returns an all caps version of that text.


## [Tableau Workbook](Tableau/)
The Tableau workbook included in this example contains a simple input field and two text output fields showing the capitalized text from the two extensions.
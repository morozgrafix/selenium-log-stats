### Simple script to generate some stats and metrics from Selenium Log

run:

`ruby parse_log.rb selenium.log`

sample output:

```
+---------------------+-------+--------+--------+--------+----------+----------+
| Command             | Count | Min(s) | Max(s) | Avg(s) | Total(s) | Total(%) |
+---------------------+-------+--------+--------+--------+----------+----------+
| InitSession         |     1 |  0.823 |  0.823 |  0.823 |    0.823 |   0.601% |
| ExecuteScript       |    54 |  0.002 |  0.037 |  0.005 |    0.253 |   0.185% |
| BetweenCommands*    |   497 |  0.001 |  3.449 |  0.209 |  103.690 |  75.731% |
| SetWindowPosition   |     1 |  0.182 |  0.182 |  0.182 |    0.182 |   0.133% |
| SetWindowSize       |     1 |  0.023 |  0.023 |  0.023 |    0.023 |   0.017% |
| MaximizeWindow      |     1 |  0.054 |  0.054 |  0.054 |    0.054 |   0.039% |
| GetWindows          |    57 |  0.000 |  0.012 |  0.001 |    0.067 |   0.049% |
| GetWindow           |    56 |  0.000 |  0.002 |  0.000 |    0.004 |   0.003% |
| SwitchToFrame       |    56 |  0.000 |  0.007 |  0.002 |    0.122 |   0.089% |
| GetUrl              |     3 |  0.003 |  0.005 |  0.004 |    0.011 |   0.008% |
| Navigate            |     3 |  0.589 |  3.441 |  2.473 |    7.419 |   5.419% |
| AddCookie           |     1 |  0.012 |  0.012 |  0.012 |    0.012 |   0.009% |
| FindElement         |    53 |  0.007 |  0.025 |  0.018 |    0.944 |   0.689% |
| GetElementTagName   |    78 |  0.002 |  0.508 |  0.011 |    0.870 |   0.635% |
| GetElementAttribute |    30 |  0.009 |  0.013 |  0.010 |    0.314 |   0.229% |
| IsElementEnabled    |    48 |  0.003 |  0.040 |  0.007 |    0.346 |   0.253% |
| IsElementDisplayed  |    27 |  0.007 |  0.061 |  0.017 |    0.470 |   0.343% |
| ClearElement        |     8 |  0.024 |  0.030 |  0.027 |    0.214 |   0.156% |
| TypeElement         |     9 |  0.033 |  0.614 |  0.164 |    1.472 |   1.075% |
| IsElementSelected   |     1 |  0.011 |  0.011 |  0.011 |    0.011 |   0.008% |
| ClickElement        |     4 |  0.045 |  9.928 |  4.869 |   19.476 |  14.224% |
| FindChildElements   |     2 |  0.018 |  0.018 |  0.018 |    0.036 |   0.026% |
| GetElementText      |     3 |  0.021 |  0.025 |  0.023 |    0.069 |   0.050% |
| UploadFile          |     1 |  0.037 |  0.037 |  0.037 |    0.037 |   0.027% |
+---------------------+-------+--------+--------+--------+----------+----------+
24 unique commands took 136.919 seconds plus 0.541 seconds of pre start, totalling 137.46 seconds to execute
Note: BetweenCommands is time spent when one command has finished and another hasn't started
ClickElement command may include page navigation time if click triggersbrowser navigation
```
# Overview

`cmplot` is a developed packages for create confusion matrix graph for Optimizing Probability Thresholds.

# Installation

You can install the development version of `cmplot` using:

```
# install.packages("remotes")
remotes::install_github("ahmadhusain/cmplot")
```

# Examples

```
library(dplyr)
library(caret)
library(tidyr)
library(ggplot2)
library(plotly)
library(cmplot)

load("data-raw/churn_prediction.RData")
```

Save the probability results from your model and actual data in the following format:

```
head(data_pkg)
```

| probability | churn_status |
|-------------|--------------|
| 0.294       | Yes          |
| 0.794       | Yes          |
| 0.275       | No           |
| 0.161       | No           |
| 0.00769     | No           |
| 0.555       | No           |


```
confmat_plot(data_pkg$probability, data_pkg$churn_status, "Yes", "No")
```

![]('data-raw/plotly.gif')

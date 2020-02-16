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

load("data-raw/churn_prediction.RData")
```

```
head(data_pkg)
```


```
confmat_plot(data_pkg$probability, data_pkg$churn_status, "Yes", "No")
```

![]('data-raw/index.html')

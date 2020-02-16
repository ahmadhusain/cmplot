#' Confusion Matrix plot for Optimizing Probability Thresholds
#'
#' @param prob A result probabilities from model
#' @param ref Actual target set
#' @param postarget Character positive levels
#' @param negtarget Character negative levels
#' @return Confusion Matrix plot using \code{ggplotly}
#' @examples
#' dat <- tibble(
#'   "probability" = c(0.53, 0.64, 0.23, 0.1, 0.8)
#'   "churn_status" = as.factor(c("No","Yes", "No", "No", "Yes"))
#' )
#'
#' dat %>% confat_plot(probability, churn_status, "Yes", "No")
#' @importFrom caret confusionMatrix
#' @import dplyr
#' @import ggplot2
#' @import plotly
#' @export
confmat_plot <- function(prob, ref, postarget, negtarget)
{
  co <- seq(0.01,0.80,length=100)
  result <- matrix(0,100,4)

  for (i in 1:100) {

    predict <- factor(ifelse(prob >= co[i], postarget, negtarget))
    conf <- confusionMatrix(predict , ref, positive = postarget)
    acc <- conf$overall[1]
    rec <- conf$byClass[1]
    prec <- conf$byClass[3]
    spec <- conf$byClass[2]
    mat <- t(as.matrix(c(rec , acc , prec, spec)))
    result[i,] <- mat

    colnames(result) <- c("recall", "accuracy", "precicion", "specificity")

  }

  perf_table <- tibble("Recall" = result[,1],
                       "Accuracy" = result[,2],
                       "Precision" = result[,3],
                       "Specificity" = result[,4],
                       "Cutoff" = co) %>%
    gather(key = "performa", value = "value", 1:4)

  p1 <- perf_table %>%
    ggplot(aes(x = Cutoff, y = value, col = performa)) +
    geom_line(lwd = 1.5) +
    scale_color_manual(values = c("firebrick", "dodgerblue4", "dark green", "gold")) +
    scale_y_continuous(breaks = seq(0,1,0.1), limits = c(0,1)) +
    scale_x_continuous(breaks = seq(0,1,0.1)) +
    labs(title = "Tradeoff model perfomance",
         col = "Metrics",
         x = "Probability Cut-off",
         y = "Value") +
    theme_minimal() +
    theme(legend.position = "top",
          panel.grid.minor.y = element_blank(),
          panel.grid.minor.x = element_blank())

  ggplotly(p1) %>%
    config(displayModeBar = F)
}

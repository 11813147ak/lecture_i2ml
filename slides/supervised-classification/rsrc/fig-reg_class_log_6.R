 
library(knitr)
library(mlbench)
library(mlr)
library(OpenML)

library(ggplot2)
library(viridis)
library(gridExtra)
library(ggrepel)
library(repr)

library(data.table)
library(BBmisc)


library(party)
library(kableExtra)
library(kknn)
library(e1071)

options(digits = 3, width = 65, str = strOptions(strict.width = "cut", vec.len = 3))


plot_lp = function(...){
  plotLearnerPrediction(...) + scale_fill_viridis_d()
}


pdf("../figure/reg_class_log_6.pdf", width = 8, height = 4)
set.seed(1)
n = 40
x = runif(2 * n, min = 0, max = 7)
x1 = x[1:n]
x2 = x[(n + 1):(2 * n)]
y = x1 + x2 + rnorm(n) > 7
df = data.frame(x1 = x1, x2 = x2, y = y)
task = makeClassifTask(data = df, target = "y", positive = "FALSE")
lrn = makeLearner("classif.logreg", predict.type = "prob")
m = train(lrn, task)
mm = m$learner.model
df$score = -predict(mm)
df$prob = getPredictionProbabilities(predict(m, task = task))
plot_lp(lrn, task = task)
ggsave("../figure/reg_class_log_6.pdf", width = 8, height = 4)
dev.off()


pdf("../figure/reg_class_log_7.pdf", width = 2, height = 2)
set.seed(123)
p2 = ggplot(df, aes(x = score, y = prob)) + geom_line() + geom_point(aes(colour = y), size = 2)
p2 = p2 + theme(legend.position = "none") + xlim(c(-10, 10))
plot(p2)
ggsave("../figure/reg_class_log_7.pdf", width = 2, height = 2)
dev.off()

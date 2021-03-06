 
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

options(digits = 3, width = 65, str = strOptions(strict.width = "cut", vec.len = 3))


set.seed(123)
.h = function(x) 0.6 + 0.4 * sin(2 * pi * x)
h = function(x) .h(x) + .1 * arima.sim(list(ar = .7, ma = 0), length(x)) + rnorm(length(x), sd = .5)

x = seq(0.4, 2, length = 31L)
y = h(x)


#figure 1

pdf("../figure/reg_pol_1.pdf", width= 8, height = 4.5)
line.palette = viridisLite::viridis(4)
baseplot = function() {
  # par(mar = c(2, 2, 1, 1))
  plot(x, y, pch = 19L, ylim = c(-1, 2))
}

p1 = lm(y ~ poly(x, 1, raw = TRUE))
p3 = lm(y ~ poly(x, 5, raw = TRUE))
p10 = lm(y ~ poly(x, 25, raw = TRUE))
mods = list(p1, p3, p10)
x.plot = seq(min(x), max(x), length = 500L)
baseplot()

ggsave("../figure/reg_pol_1.pdf", width = 8, height = 4.5)
dev.off()

#figure 2

pdf("../figure/reg_pol_2.pdf", width= 8, height = 4.5)
baseplot()

for (i in 1) {
  lines(x.plot, predict(mods[[i]], newdata = data.frame(x = x.plot)),
        col = line.palette[i], lwd = 2L)
}
legend("topright", paste(sprintf("f(x) for d = %s", c(1, 5, 25)), c("(linear)", "", "")),
       col = line.palette, lwd = 2L)

ggsave("../figure/reg_pol_2.pdf", width = 8, height = 4.5)
dev.off()


#figure 3

pdf("../figure/reg_pol_3.pdf", width= 8, height = 4.5)
baseplot()

for (i in 1:2) {
  lines(x.plot, predict(mods[[i]], newdata = data.frame(x = x.plot)),
        col = line.palette[i], lwd = 2L)
}
legend("topright", paste(sprintf("f(x) for d = %s", c(1, 5, 25)), c("(linear)", "", "")),
       col = line.palette, lwd = 2L)

ggsave("../figure/reg_pol_3.pdf", width = 8, height = 4.5)
dev.off()


#figure 4

pdf("../figure/reg_pol_4.pdf", width= 8, height = 4.5)
baseplot()

for (i in 1:3) {
  lines(x.plot, predict(mods[[i]], newdata = data.frame(x = x.plot)),
        col = line.palette[i], lwd = 2L)
}
legend("topright", paste(sprintf("f(x) with d = %s", c(1, 5, 25)), c("(linear)", "", "")),
       col = line.palette, lwd = 2L)

ggsave("../figure/reg_pol_4.pdf", width = 8, height = 4.5)
dev.off()


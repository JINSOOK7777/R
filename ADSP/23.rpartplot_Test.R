# 이쁘게 인쇄하기
install.packages("rpart.plot")
library(rpart.plot)
data(ptitanic)
tree <- rpart(survived ~ ., data=ptitanic, cp=.02)
# cp=.02 because want small tree for demo
old.par <- par(mfrow=c(2,2))
# put 4 figures on one page
prp(tree, main="default prp\n(type = 0, extra = 0)")
prp(tree, main="type = 4, extra = 6", type=4, extra=6, faclen=0)
cols <- ifelse(tree$frame$yval == 1, "darkred", "green4")
# green if survived
prp(tree, main="assorted arguments",
    extra=106, # display prob of survival and percent of obs
    nn=TRUE, # display the node numbers
    fallen.leaves=TRUE, # put the leaves on the bottom of the page
    branch=.5, # change angle of branch lines
    faclen=0, # do not abbreviate factor levels
    trace=1, # print the automatically calculated cex
    shadow.col="gray", # shadows under the leaves
    branch.lty=3, # draw branches using dotted lines
    split.cex=1.2, # make the split text larger than the node text
    split.prefix="is ", # put "is " before split text
    split.suffix="?", # put "?" after split text
    col=cols, border.col=cols, # green if survived
    split.box.col="lightgray", # lightgray split boxes (default is white)
    split.border.col="darkgray", # darkgray border on split boxes
    split.round=.5) # round the split box corners a tad
# the old way for comparison
plot(tree, uniform=TRUE, compress=TRUE, branch=.2)
text(tree, use.n=TRUE, cex=.6, xpd=NA) # cex is a guess, depends on your window size
title("plot.rpart for comparison", cex=.6)
par(old.par)
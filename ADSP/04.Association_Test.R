## (1) arules 패키지를 이용한 연관성 분석

# (a) data 탐색

install.packages("arules")
library(arules)

install.packages("arulesViz")
library('arulesViz')

data('Groceries')

#주의) inspect가 안되는 오류 발생시 타 패키지와 충돌 나서 그럴 수 있으므로 R Studio를 닫은 후 다시 열면 해결될 수 있다.
inspect(head(Groceries,n=5))
summary(Groceries)

# (b) apriori function을 이용해 연관규칙 도출
rules<-apriori(Groceries,parameter=list(support=0.001,confidence=0.5))
rules
inspect(head(sort(rules,by='lift'),3))

# (c) 다양한 시각화
plot(rules)
plot(rules, interactive=TRUE)

sel<-plot(rules,measure=c("support","lift"),shading="confidence",interactive=TRUE)
sel
subrules<-rules[quality(rules)$confidence>0.8]
subrules

plot(subrules,method="matrix",measure="lift")
plot(subrules,method="matrix",measure=c("lift","confidence"))
plot(subrules,method="matrix3D",measure="lift")
plot(rules,method="grouped")
subrules2<-head(sort(rules,by="lift"),10)     
plot(subrules2,method="graph",control=list(type="items"))

## (2) arulesSequences 패키지를 이용한 순차연관성 분석

# (a) data 탐색
install.packages("arulesSequences")
library(arulesSequences)
data(zaki)
? zaki
str(zaki)

summary(zaki)
inspect(head(zaki))
as(zaki,"data.frame")

length(zaki)
ncol(zaki)

# (b) cspade function을 이용해 순차연관규칙 도출
z_arules_Seq <- cspade(zaki, parameter = list(support=0.4),control=list(verbose=TRUE))
str(z_arules_Seq)
summary(z_arules_Seq)
as(z_arules_Seq,"data.frame")
as(zaki,"data.frame")

# zaki의 sequenceID는 사람, eventID는 장을 본 순서, size는 장본 물건개수, items은 그날 산 물건으로 생각하면 됨.
# 1번 transaction은 1번인 사람이 10일에 2개 물건 "C"와 "D"를 구매함.
# 2번 transaction은 1번인 사람이 15일에 3개 물건 "A", "B"와 "C"를 구매함.

# Rule 설명:
# Rule #1: sequenceID=1~4가 eventID 4개 중에 "A"를 샀나요? 1,2,3,4 모두 샀음.
# Rule #3: sequenceID=1~4가 eventID 4개 중에 "D"를 샀나요? 1,4만 샀음.
# Rule #18: sequenceID=1이 eventID 4개 중에 "D", "B", "A"를 순서대로 샀나요?

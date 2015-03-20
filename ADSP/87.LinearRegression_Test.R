##############################################################
#########  단순선형회귀분
##############################################################
data(cars)
cars

plot(cars$speed, cars$dist)

# Correlations
# p-value 구하는 함수
# 여기서 얻은 p-value는 lm(변수1 ~ 변수2) 같이 단순회귀분석에서 얻은 p-value와 동일
cor.test(cars$speed, cars$dist)

# liner modeling 
m <- lm(dist~speed, data=cars)
summary(m)

# std. 별표가 많은 것이 유의미한 변수,
# Multiple R-squared는 높을 수록 좋음, p-value는 낮을 수록 좋음. 

# test
par(mfrow=c(2,2))
plot(m)
par(mfrow=c(1,1))

# plot 도표 검증
# Residuals가 중요함 이것에 따라 linear modeling이 제대로 되었는지를 확인할 수 있음.
# Normal Q-Q가 선 사이에 모여 있고 0근처에 몰려 있어야 정상
# Scale-Location은 밑으로 내려갈 수록 좋음
# Residuals vs Leverage가 0.5 아래로 모여 있어야 랜덤하게 생성되어 유의미하다고 볼 수 있다.

##############################################################
#########  최적회귀방정식의 선택
##############################################################
data(mtcars)

# 처음엔 변수가 없고 변수를 하나씩 추가하면서 모델링
# forward selection
step(lm(disp~1,data=mtcars), direction="forward",scope=(~mpg+cyl+hp+drat+wt))

# 없는 것부터 시작해서 필요한 변수 하나씩 추가하여 유의미 변수 도출

# 처음엔 변수가 없고 변수를 하나씩 제하면서 모델링
# backward selection
step(lm(disp~mpg+cyl+hp+drat+wt,dat=mtcars),direction="backward")

# 처음엔 변수가 없고 변수를 하나씩 추가하거나 제거하면서 모델링
# both
step(lm(disp~mpg+cyl+hp+drat+wt,dat=mtcars),direction="both")거


##############################################################
# 최적회귀방정식의 선택은 환율 예측에 활용된 적이 있음. 
# 회귀분석에 모든 변수를 반영한다고 좋은 건 아니다. 그러므로 최적회귀방식 선택으로 최적의 변수를 선택하는 게 중요하다.


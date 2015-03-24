# TSA는 반드시 시간의 변수가 있어야 하고 수치가 있어야 함.
# TSA의 주요요인은 오직 시간 뿐임. 
# ARIMA는 과거 데이터는 잘 맞추나 예측은 범위가 크게 나와서 적철치 않음.


# data load
data(lynx)
head(lynx)

# data 탐색
ts.plot(lynx)

# 위 아래 주기가 있으면 트렌드가 있는 
acf(lynx)


# log를 
ts.plot(log(lynx))
acf(log(lynx))

# pacf
# Y t 는 yt-1과 연관이 있느냐, yt-2와 연관이 있느냐... 등등을 acf를 통해 흐름 확인
# 파란선을 빠져 나가는 애들ㄹ이 연관이 있는 것들임.
acf(log(lynx),type="partial")

# AR 모델 생성
#
llynx.ar <- ar.yw(log(lynx))

# 결과 확인 
names(llynx.ar)
llynx.ar$order.max


# 모델의 차수를 결정
ts.plot(llynx.ar$aic, main"AIC for LOg(Lynx)")
llynx.ar$order    # 영향을 미치는 레코드로 여기서는 11개임.  파란선 안에 들어오는 것의 범위값 정도
llynx.ar$ar

# 시각화

# 교재 p451 참조



#### 분해 시계열(decompose)
# frequency=250emddmf wnjdi gka.

#코스피 예측
library(zoo)


#




# 책 예제는 오류가 많아 https://github.com/Bart6114/simmer의 예제로 실행함

# library(devtools)
# devtools::install_github("Bart6114/simmer")
# 
# library(simmer)
# t1 <- read.table(header=T,text=
#   "event_id description resource  amount  duraion successor
#   1 intake  nurse 1 rnorm(1,4,2)  2
#   2 consultation  doctor 1 rnorm(1,10,7)  3
#   3 injection  nurse 1 rnorm(1,3,1) 4
#   4 planning  administration 1 rnorm(1,3,2)  5
#   5 move  walk 1 rnorm(1,10,5)  6
#   6 drug  drugs 1 rnorm(1,10,3)  NA
#   ")
# 
# library(magrittr)
# sim<-
#   create_simulator("SuperDuperSim") %>%
#   add_resource("nurse", 1) %>%
#   add_resource("doctor", 1) %>%
#   add_resource("administration", 1) %>%
#   add_resource("walk", 100) %>%
#   add_resource("drugs", 1)
# 
# sim<-
#   sim %>%
#   create_trajectory("Trajectory1",t1) %>%
#   add_entities_with_interval(n=10, name_prefix="patient", trajectory_name="Trajectory1", interval=10)
# 
# sim<-
#   sim %>%
#   add_entity(name="individual_entity", trajectory_name="Trajectory1", early_start=100)
# 
# sim<-
#   sim %>%
#   replicator(10)
# 
# sim<-
#   sim %>%
#   simmer(until=110)
# 
# plot_resource_utilization(sim)
# plot_resource_usage(sim, "doctor")
# plot_resource_usage(sim, "doctor", 6)
# plot_evolution_entity_times(sim, type="activity_time")
# plot_evolution_entity_times(sim, type="waiting_time")
# plot_evolution_entity_times(sim, "flow_time")

library(devtools)
devtools::install_github("Bart6114/simmer")

library(simmer)

t0<-
  create_trajectory("my trajectory") %>%
  ## add an intake event 
  add_seize_event("nurse",1.0) %>%
  add_timeout_event(15) %>%
  add_release_event("nurse",1.0) %>%
  ## add a consultation event
  add_seize_event("doctor",1.0) %>%
  add_timeout_event(20) %>%
  add_release_event("doctor",1.0) %>%
  ## add a planning event
  add_seize_event("administration",1.0) %>%
  add_timeout_event(5) %>%
  add_release_event("administration",1.0)

t1<-
  create_trajectory("my trajectory") %>%
  ## add an intake event 
  add_seize_event("nurse",1.0) %>%
  add_timeout_event("rnorm(1,15)") %>%
  add_release_event("nurse",1.0) %>%
  ## add a consultation event
  add_seize_event("doctor",1.0) %>%
  add_timeout_event("rnorm(1,20)") %>%
  add_release_event("doctor",1.0) %>%
  ## add a planning event
  add_seize_event("administration",1.0) %>%
  add_timeout_event("rnorm(1,5)") %>%
  add_release_event("administration",1.0)

sim<-
  create_simulator("SuperDuperSim", n = 100, until = 80) %>%
  add_resource("nurse", 1) %>%
  add_resource("doctor", 2) %>%
  add_resource("administration", 1)

sim<-
  sim %>%
  add_entities_with_interval(trajectory = t1, n = 10, name_prefix = "patient", interval =  "rnorm(1, 10, 2)")

sim<-
  sim %>%
  add_entity(trajectory = t1, name = "separate_patient" , activation_time =  100)

sim <-
  sim %>%
  simmer()

t2<-
  create_trajectory("trajectory with a skip event") %>%
  ## add a skip event - (50 - 50 chance that the next event is skipped)
  add_skip_event(number_to_skip = "sample(c(0,1),1)") %>%
  add_timeout_event(15) %>%
  add_timeout_event(5)

plot_resource_utilization(sim, c("nurse", "doctor","administration"))
plot_resource_usage(sim, "doctor")
plot_resource_usage(sim, "doctor", 6)

head(
  get_resource_monitor_values(sim, "nurse")
)

plot_evolution_entity_times(sim, type = "flow_time")

head(
  get_entity_monitor_values(sim, aggregated = TRUE)
)

head(
  get_entity_monitor_values(sim, aggregated = T)
)

library(simmer)

t0<-
  create_trajectory("my trajectory") %>%
  # 프로세스를 그대로 나열하면 됨. 
  # 환자가 오면 간호사를 15분 만나고 의사를 20분 만나고 어드민을 5분 만나고 종결이면 아래처럼 기술하고
  # 중간에 어드민 만나기 전 간호사를 다시 만나면 간호사 몇분을 추가 기술하면 된다.
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

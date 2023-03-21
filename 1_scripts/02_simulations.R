## Simulate occupancy, abundance, and detection data 


# 'frequency' = the regularity at which a drumming male ruffed grouse may be heard (maximum frequency = daily)  
# 'rate' = interval between drums for an individual grouse  
# 'intensity' = the percentage of grouse participating in drumming activity on a given morning or evening  

# Mine the data to find: 

# Peak period of drumming activity daily and seasonally. 
#  - Timing of snow melt has little influence on peak seasonal drumming activity, but does affect intensity.  
#  - Winter severity has a big affect on intensity.  

# Distribution of number of surveys among all sites.  

# To make the sumulations applicable to our data, we need to use a sumilar distrubtuion of number of surveys per site. Then, get time of day and day of year distributions. Surveys are pretty much uniformly distributed between April 20 (day 110) and May 30 (day 150). 

library(EnvStats)
surv.dist <- sapply(1:nrow(y), function(x) length(which(!is.na(y[x, ]))))

gam <- egamma(surv.dist) # The gamma distribution parameters (shape and scale)

hist(visits$doy)
hist(visits$hr)


hour = as.numeric(hour(dat$recording_date) + minute(dat$recording_date)/60)



night <- visits %>% filter(hr <= 2) 
day <- data.frame(visits %>% filter(hr > 2)) 


naive <- rowSums(occ.data@y, na.rm = TRUE)
naive[naive > 0] <- 1 

dat1 <- dat[which(hour > 2), ]

occ.data <- wt_format_occupancy(data = dat1, species = "RUGR")



nsite <- 1000 

# Use the gamma parameters to simulate number of surveys at each site, capping them at 87
nsurv <- round(rgamma(n = nsite, shape = gam$parameters[1], scale = gam$parameters[2]), 0)
nsurv <- ifelse(nsurv > 87, 87, nsurv)  

long <- do.call(rbind, lapply(1:length(nsurv), function(x) data.frame(site = x, surv = seq(1:nsurv[x]))))





# Now we need to simulate occupancy, density, and drumming behaviour at each site throughout the season. 



psi <- inv.logit(rnorm(nsite)) 

lam <- -log(-psi + 1)
abund <- rpois(nsite, lam)

occ <- abund
occ[occ > 0] <- 1 


mean.pct.active <- mean(c(29,49,31,30))
sd.pct.active <-  mean(11,18,20,14)

pct.active <- function(x) {rnorm(1, mean.pct.active, sd.pct.active)} 

active.day <- sapply(1:max(nsurv), pct.active)

long$no.active <- sapply(1:nrow(long), function(x) rbinom(1, abund[long$site[x]], active.day[long$surv[x]]/100)) 

long$drum.min <- sapply(1:nrow(long), function(x){
  a <- long$no.active[x]
  if(a > 0){
    d <- sum(sapply(1:a, function(i){
       p <- rgamma(1, shape = 9, scale = 0.4)
       p <- ifelse(p < 1, 1, p)
       return(rbinom(1, 1, 1/p))
    }))
  }else{
    d <- 0
  }
  return(d)
})

long$det <- ifelse(long$drum.min > 1, 1, 0) 

wide <- long %>% select(site, surv, det) %>% spread(surv, value = det) 

naive.sim <- rowSums(wide[, -1], na.rm = TRUE)
naive.sim[naive.sim > 1] <- 1














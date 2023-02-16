- <a href="#overview" id="toc-overview">1 Overview</a>
- <a href="#example-project" id="toc-example-project">2 Example
  Project</a>
  - <a href="#create-database" id="toc-create-database">2.1 Create
    database</a>
- <a href="#references" id="toc-references">3 References</a>

# 1 Overview

# 2 Example Project

**Project description** The Objective of this project is to use estimate
Ruffed Grouse (*Bonasa umbellus*) population size in Alberta using data
collected with autonomous recording units (ARUs).

## 2.1 Create database

Below are the instructions and code for getting data from wildtrax that
was developed by Elly Knight. The original rScripts are available
[here](https://github.com/baynelab-research/aru-data-processing-code).

*See the wildRtrax article here for more details on authentication:*
<https://abbiodiversity.github.io/wildRtrax/articles/authenticating-into-wt.html>

1.  **Load packages**

``` r
#install.packages("remotes")
#remotes::install_github("ABbiodiversity/wildRtrax")
library(wildRtrax)
library(tidyverse)
```

2.  **Login to WildTrax**

NOTE: If you have not done this yet, first, open a blank R document and
add the following text to it:

``` r
 Sys.setenv(WT_USERNAME = 'your wildtrax username', WT_PASSWORD = 'your wildtrax password')  
```

Then save the file to “1_scripts/functions/login.R”, and ensure that it
will not be pushed to github by adding the file path (without the
quotes) to your .gitignore file (in the main project directory)

``` r
config <- "login.R"
source(config)
wt_auth()
```

3.  **Get list of projects from WildTrax**

``` r
projects <- wt_get_download_summary(sensor_id = 'ARU')
```

4.  **Download RUGR dataset summary report**

``` r
dat.rugr <- wt_download_report(project_id = 1321, sensor_id = 'ARU', weather_cols = T, report = "summary")
```

5.  **Download RUGR task report to check coordinate buffering**

``` r
task.rugr <- wt_download_report(project_id = 1321, sensor_id = 'ARU', report = "task")
table(task.rugr$buffer)
```

# 3 References

<div id="refs">

</div>

<!--chapter:end:index.Rmd-->

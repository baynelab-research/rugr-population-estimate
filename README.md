- <a href="#overview" id="toc-overview">1 Overview</a>
- <a href="#example-project" id="toc-example-project">2 Example
  Project</a>
  - <a href="#create-database" id="toc-create-database">2.1 Create
    database</a>
- <a href="#references" id="toc-references">3 References</a>

# 1 Overview

# 2 Example Project

**Project description**

Get scared by doggo also cucumerro hide from vacuum cleaner so eat a rug
and furry furry hairs everywhere oh no human coming lie on counter don’t
get off counter lick the other cats chirp at birds. Cats are fats i like
to pets them they like to meow back annoy the old grumpy cat, start a
fight and then retreat to wash when i lose and i’m going to lap some
water out of my master’s cup meow. Meowing chowing and wowing. Lay on
arms while you’re using the keyboard. Immediately regret falling into
bathtub just going to dip my paw in your coffee and do a taste test - oh
never mind i forgot i don’t like coffee - you can have that back now.

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

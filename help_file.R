# generate fodlers for stire
rmarkdown::render_site()

# delete 

## help code to move public file to Cpanel
if (file.exists('_site.zip')) {
  file.remove('_site.zip')
}
files2zip <- dir('_site', full.names = TRUE)
zip(zipfile = "_site", files = files2zip)

# send public.zip to server
library(RCurl)
ftpUpload("C:/Users/Mislav/covidrh/_site.zip", 
          "ftp://ftp.odvjetnistvo-sagovac.hr/_site.zip", 
          userpwd = "rh-dash@rh-dash.contentio.biz:Theanswer0207")

# unzip, and rename
library(pbdRPC)
m <- machine(hostname = "91.234.46.219", 
             user = "odvjet12",
             pport = 22L,
             priv.key.ppk = 'D:/data/R/CroEconSite/id_rsa.ppk')
# .pbd_env$RPC.CT$use.shell.exec <- FALSE
rpc(
  m, 
  'cd public_html; rm -rf rh-dash.contentio.biz; unzip _site.zip; mv _site rh-dash.contentio.biz; rm -rf _site.zip'
)

# 
# setwd("D:/data/R/CroEconSite")
# files2zip <- dir('public', full.names = TRUE)
# zip(zipfile = "public", files = files2zip)
# 
# # send public.zip to server
# library(RCurl)
# ftpUpload("D:/data/R/CroEconSite/public.zip", 
#           "ftp://ftp.odvjetnistvo-sagovac.hr/public.zip", 
#           userpwd = "croecon.contentio.biz@odvjetnistvo-sagovac.hr:Theanswer0207")
# 
# # unzip, and rename
# library(pbdRPC)
# m <- machine(hostname = "91.234.46.219", 
#              user = "odvjet12",
#              pport = 22L,
#              priv.key.ppk = 'D:/data/R/CroEconSite/id_rsa.ppk')
# # .pbd_env$RPC.CT$use.shell.exec <- FALSE
# rpc(
#   m, 
#   'cd public_html; rm -rf croecon.contentio.biz; unzip public.zip; mv public croecon.contentio.biz; rm -rf public.zip'
# )


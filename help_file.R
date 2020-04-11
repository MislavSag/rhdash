# generate fodlers for stire
rmarkdown::render_site()

## help code to move public file to Cpanel
if (file.exists('_site.zip')) {
  file.remove('_site.zip')
}
files2zip <- dir('_site', full.names = TRUE)
files2zip <- setdiff(files2zip, '_site/data_temp')
zip(zipfile = "_site", files = files2zip)

# send public.zip to server
library(RCurl)
ftpUpload("C:/Users/Mislav/rhdash/_site.zip", 
          "ftp://ftp.odvjetnistvo-sagovac.hr/_site.zip", 
          userpwd = "rh-dash@rh-dash.contentio.biz:Theanswer0207")

# unzip, and rename
library(pbdRPC)
m <- machine(hostname = "91.234.46.219", 
             user = "odvjet12",
             pport = 22L,
             priv.key.ppk = 'D:/data/R/CroEconSite/id_rsa.ppk')
rpc(
  m,
  'cd public_html; rm -rf rh-dash.contentio.biz; unzip _site.zip; mv _site rh-dash.contentio.biz; rm -rf _site.zip'
)

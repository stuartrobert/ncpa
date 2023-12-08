# params for ncpa
class ncpa::params {
  $allowed_hosts        = []
  $service_state        = 'running'
  $service_enable       = true
  $manage_service       = true
  $package_source       = 'https://assets.nagios.com/downloads/ncpa'
  $package_name         = 'NCPA'
  $download_destination = 'c:/temp'
  $proxy_url            = undef
  $api_token            = 'A_STRONG_token'
  $package_version      = '3.0.0'
}

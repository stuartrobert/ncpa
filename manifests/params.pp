# params for ncpa
class ncpa::params {
  $allowed_hosts           = []
  $service_state           = 'running'
  $service_enable          = true
  $package_source          = 'https://assets.nagios.com/downloads/ncpa'
  $package_name            = 'NCPA'
  $download_destination    = 'c:/temp'
  $config_template         = 'ncpa/ncpa.cfg.epp'
  $install_path            = 'C:\Program Files (x86)\Nagios\NCPA'
  $proxy_url               = undef
  $api_token               = 'A_STRONG_token'
  $chocolatey_provider     = false
  $chocolatey_package_name = 'ncpa'

  if $chocolatey_provider {
    $package_version = 'latest'
  } else {
    $package_version = '2.3.1'
  }
}

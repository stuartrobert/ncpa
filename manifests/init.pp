# module that installs ncpa
class ncpa (
  $allowed_hosts                       = $ncpa::params::allowed_hosts,
  $service_state                       = $ncpa::params::service_state,
  Boolean $service_enable              = $ncpa::params::service_enable,
  String $package_source_location      = $ncpa::params::package_source_location,
  String $package_source               = $ncpa::params::package_source,
  String $package_name                 = $ncpa::params::package_name,
  $download_destination                = $ncpa::params::download_destination,
  Optional[String[1]] $package_version = $ncpa::params::package_version,
  Optional[String[1]] $proxy_url       = $ncpa::params::proxy_url,
) inherits ncpa::params {

  class { 'ncpa::install': }
  class { 'ncpa::config': }

  service { 'ncpalistener':
    ensure  => $service_state,
    enable  => $service_enable,
    require => Class['ncpa::config'],
  }

}

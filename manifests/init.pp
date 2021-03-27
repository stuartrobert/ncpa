# module that installs ncpa
class ncpa (
  Array $allowed_hosts                 = $ncpa::params::allowed_hosts,
  String $service_state                = $ncpa::params::service_state,
  Boolean $service_enable              = $ncpa::params::service_enable,
  String $package_source               = $ncpa::params::package_source,
  String $package_name                 = $ncpa::params::package_name,
  String $download_destination         = $ncpa::params::download_destination,
  String $config_template              = $ncpa::params::config_template,
  Optional[String] $config_content     = undef,
  Optional[String[1]] $package_version = $ncpa::params::package_version,
  Optional[String[1]] $proxy_url       = $ncpa::params::proxy_url,
) inherits ncpa::params {

  class { 'ncpa::install':
  }
  class { 'ncpa::config':
    require => Class['ncpa::install'],
  }

  service { 'ncpalistener':
    ensure  => $service_state,
    enable  => $service_enable,
    require => Class['ncpa::config'],
  }

}

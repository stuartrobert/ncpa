# module that installs ncpa
class ncpa (
  Array $allowed_hosts                 = $ncpa::params::allowed_hosts,
  String $service_state                = $ncpa::params::service_state,
  Boolean $service_enable              = $ncpa::params::service_enable,
  String $package_source               = $ncpa::params::package_source,
  String $package_name                 = $ncpa::params::package_name,
  String $download_destination         = $ncpa::params::download_destination,
  String $api_token                    = $ncpa::params::api_token,
  Optional[String] $config_content     = undef,
  Optional[String[1]] $package_version = $ncpa::params::package_version,
  Optional[String[1]] $proxy_url       = $ncpa::params::proxy_url,
) inherits ncpa::params {

  if versioncmp($package_version, '3.0.0') >= 0 {
    $config_template = 'ncpa/ncpa.cfg-v3.epp'
    $service_names = ['NCPA']
    $install_path = 'C:\Program Files\Nagios\NCPA'
  } else {
    $config_template = 'ncpa/ncpa.cfg-v2.epp'
    $service_names = ['ncpalistener', 'ncpapassive']
    $install_path = 'C:\Program Files (x86)\Nagios\NCPA'
  }

  class { 'ncpa::install':
  }
  class { 'ncpa::config':
    require => Class['ncpa::install'],
  }

  service { $service_names:
    ensure  => $service_state,
    enable  => $service_enable,
    require => Class['ncpa::config'],
  }

}

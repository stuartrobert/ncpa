# NCPA service
class ncpa::config (
  $allowed_hosts   = $ncpa::allowed_hosts,
  $config_content  = $ncpa::config_content,
  $config_template = $ncpa::config_template,
  $install_path    = $ncpa::install_path,
  $api_token       = $ncpa::api_token,
) {
  assert_private("You're not supposed to do that!")

  if $config_content {
    $real_content = $config_content
  } else {
    $real_content = epp($config_template)
  }

  case downcase($facts['os']['family']) {
    'windows': {
      file { "${install_path}\\etc\\ncpa.cfg":
        ensure  => file,
        owner   => 'SYSTEM',
        content => $real_content,
        notify  => Service[$ncpa::service_names],
      }

    }
    default: {
      fail('This module only works on Windows based systems.')
    }
  }
}

# install NCPA
class ncpa::install {
  assert_private("You're not supposed to do that!")

  $file_name = "ncpa-${package_version}"

  case downcase($facts['os']['family']) {
    'windows': {
      if $ncpa::chocolatey_provider {
        package { $ncpa::params::chocolatey_package_name:
          ensure   => $ncpa::package_version,
          provider => 'chocolatey',
        }
      }
      else {
        if ! defined(File[$ncpa::download_destination]) {
          file { $ncpa::download_destination:
            ensure => directory,
          }
        }

        download_file { $file_name:
          url                   => "${ncpa::package_source_location}/${file_name}",
          destination_directory => $ncpa::download_destination,
          proxy_address         => $ncpa::proxy_url,
          require               => File[$ncpa::download_destination],
        }

        package { $ncpa::package_name:
          ensure          => $ncpa::package_version,
          source          => "${ncpa::download_destination}/${file_name}",
          provider        => 'windows',
          install_options => [
            '/quiet',
            {
              'INSTALLLOCATION' => $ncpa::install_path,
            },
          ],
          require         => Download_file[$file_name],
        }
      }
    }
    default: {
      fail('This module only works on Windows based systems.')
    }
  }
}

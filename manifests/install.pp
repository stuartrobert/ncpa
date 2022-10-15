# install NCPA
class ncpa::install {
  assert_private("You're not supposed to do that!")

  case downcase($facts['os']['family']) {
    'windows': {
      if $ncpa::use_chocolatey {
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

        $file_name = "ncpa-${ncpa::package_version}.exe"
        download_file { $file_name:
          url                   => "${ncpa::package_source}/${file_name}",
          destination_directory => $ncpa::download_destination,
          proxy_address         => $ncpa::proxy_url,
          require               => File[$ncpa::download_destination],
        }

        package { $ncpa::package_name:
          ensure          => $ncpa::package_version,
          source          => "${ncpa::download_destination}/${file_name}",
          provider        => 'windows',
          # doc ref: https://assets.nagios.com/downloads/ncpa/docs/Installing-NCPA.pdf
          install_options => [
            '/S',
            '/TOKEN=THIS_doesnt_matter',
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

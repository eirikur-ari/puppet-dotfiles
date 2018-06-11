# my_workstation_setup/manifests/init.pp

class my_workstation_setup (

) inherits my_workstation_setup::params {

  anchor { 'my_workstation_setup::begin': }
  -> class { 'my_workstation_setup::install': }
  -> class { 'my_workstation_setup::config': }
  -> anchor { 'my_workstation_setup::end': }

}
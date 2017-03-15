#!/usr/bin/env bats
. ../nextfreeport

@test "should print the next free port to stdout" {
  run nextfreeport 21000
  [ $output = "21000" ]

  run nc -l 21000&
  run nextfreeport 21000
  [ $output = "21001" ]
}

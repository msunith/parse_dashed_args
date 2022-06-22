#!/usr/bin/env bash

setup() {
  base_dir="$(dirname $(dirname $(realpath $BATS_TEST_FILENAME)))"
  source $base_dir/pda

  load 'helper/bats-support/load'
  load 'helper/bats-assert/load'
}

@test "pda with int args" {
  pda --abc 123 --def 456
  [ "$abc" -eq 123 ]
  [ "$def" -eq 456 ]
}

@test "pda with str args" {
  pda --abc 123 --def xyz
  [ "$def" == "xyz" ]
}

@test "pda with str arg with spaces" {
  pda --abc 123 --def "uvw xyz"
  [ "$def" == "uvw xyz" ]
}
@test "pda with bool flag" {
  pda --abc 123 --bool 0 --def_bool
  [ "$bool" -eq 0 ]
  [ "$def_bool" -eq 1 ]
}

@test "pda error" {
  run pda --abc 123 --def --456
  assert_failure
}

@test "pda debugs" {
  PDA_DEBUG=1 run pda --abc 123 --def xyz
  assert_line "PDA: Parsing dashed args: --abc 123 --def xyz"
  assert_line "PDA: Setting abc to '123'"
  assert_line "PDA: Setting def to 'xyz'"
}

@test "pda debugs with error" {
  PDA_DEBUG=1 run pda --abc 123 --def --456
  assert_failure
  assert_line "PDA: Error parsing arg: '--456'"
}

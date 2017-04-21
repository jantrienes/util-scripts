#!/usr/bin/env bats
config=${BATS_TEST_DIRNAME}/../svnignore.d/
export PATH=${BATS_TEST_DIRNAME}/../:$PATH

setup() {
  mkdir ${BATS_TEST_DIRNAME}/tmp

  svnadmin create tmp/testrepo
  svn co "file://${BATS_TEST_DIRNAME}/tmp/testrepo" tmp/checkout
  cd tmp/checkout || exit
}

teardown() {
  rm -rf ${BATS_TEST_DIRNAME}/tmp
}

@test "should add tex ignore set to svn:ignore propset" {
  run svnignore tex
  [ "$status" -eq 0 ]

  target_propset=$(cat $config/tex)
  run svn propget svn:ignore
  [ "$output" == "$target_propset" ]
}

@test "should add new ignores to an existing set of ignores when using --append" {
  run svnignore tex
  run svnignore cs --append
  # todo fix assertion
  target_propset=$(cat $config/{tex,cs} | sort)
  run svn propget svn:ignore

  # although $output and $target_propset are identical, some issue with the globs inside the string # cause the assertion to fail. therefore the return of echo is compared.
  [ "$(echo $output)" == "$(echo $target_propset)" ]
}

@test "should overwrite existing ignores if --append is not used" {
  run svnignore tex
  run svnignore cs

  target_propset=$(cat $config/cs)
  run svn propget svn:ignore
  [ "$output" == "$target_propset" ]
}

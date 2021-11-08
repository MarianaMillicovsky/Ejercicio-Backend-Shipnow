#!/usr/bin/ruby

#require "readline"    # https://stdgems.org/readline/   useful third-party library, it lets use arrow-keys  
require_relative 'lib/commands/commands'
require_relative 'lib/user'
require_relative 'lib/new_session'
require_relative 'lib/new_session_persisted'
require_relative 'lib/repl'

Repl.new().run
  
#!/usr/bin/env ruby

require 'date'

class Paya
  VERSION_PREFIX = "Paya"
  INITIAL_VERSION = "8.0.0"

  def initialize
    @current_version = INITIAL_VERSION
    update_version
  end

  def update_version
    current_date = Date.today
    version_date = Date.new(current_date.year, current_date.month, 1)
    @current_version = increment_version if version_date > last_version_date
  end

  def last_version_date
    Date.parse(File.read('last_version_date.txt')) rescue Date.new(1970, 1, 1)
  end

  def increment_version
    major, minor, patch = @current_version.split('.').map(&:to_i)
    patch += 1
    if patch >= 10
      patch = 0
      minor += 1
    end
    if minor >= 10
      minor = 0
      major += 1
    end
    "#{major}.#{minor}.#{patch}"
  end

  def print_version
    puts "#{VERSION_PREFIX} [V. #{@current_version}]"
    File.write('last_version_date.txt', Date.today.to_s)
  end
end

paya = Paya.new
paya.print_version

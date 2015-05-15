require "bundler/setup"

begin
  require 'ant'
rescue
  puts("error: unable to load Ant, make sure Ant is installed, in your PATH and $ANT_HOME is defined properly")
  puts("\nerror details:\n#{$!}")
  exit(1)
end


desc "run specs"
task :spec do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new
end

TARGET = "out/production/main/"
SRC = "src/main/java"
JAR = "lib/jruby_stdin_channel/jruby_stdin_channel.jar"

task :setup do
  ant.mkdir 'dir' => TARGET
  ant.path 'id' => 'classpath' do
    fileset 'dir' => TARGET
  end
end

desc "compile Java classes"
task :build => [:setup] do |t, args|
  require 'jruby/jrubyc'
  ant.javac(
      :srcdir => SRC,
      :destdir => TARGET,
      :classpathref => "classpath",
      :debug => true,
      :includeantruntime => "no",
      :verbose => false,
      :listfiles => true,
      :source => "1.7",
      :target => "1.7",
  ) {}
end

task :setup_jar do
  ant.delete 'file' => JAR
end

desc "build the jar"
task :jar => [:setup_jar, :build] do
  ant.jar :basedir => TARGET, :destfile => JAR, :includes => "**/*.class"
end

require 'lib/bugherd/bugherd-api'

%w{ bugherd ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

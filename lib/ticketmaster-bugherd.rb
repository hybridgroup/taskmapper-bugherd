#require YOUR_PROVIDER_API
require 'ticketmaster'
%w{ bugherd ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

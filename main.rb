require 'sinatra'
require 'slim'

get '/' do
  slim :index
end

__END__

@@layout
doctype html
html
  head
    meta chatset='utf-8'
    title Just Do It
  body
    h1 Just Do It
    == yield

@@index
h2 My Tasks
ul.tasks
  li Get Milk
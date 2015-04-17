require 'sinatra'
require 'sinatra/activerecord'
require 'slim'

set :database, {adapter: "sqlite3", database: "development.db"}

class Task < ActiveRecord::Base
  belongs_to :lists
  validates_presence_of :name
end

class List < ActiveRecord::Base
  has_many :tasks, :dependent => :destroy
  validates_presence_of :name
end

get '/styles.css' do
  scss :styles
end

get '/' do
  @lists = List.order(:name)
  slim :index
end

post '/:id' do
  List.find(params[:id]).tasks.create params[:task]
  redirect '/'
end

delete '/task/:id' do
  Task.find(params[:id]).destroy
  redirect '/'
end

put '/task/:id' do
  task = Task.find(params[:id])
  task.completed_at = task.completed_at.nil? ? Time.now : nil
  task.save
  redirect '/'
end

post '/new/list' do
  @list = List.new params[:list]
  if @list.save
    redirect '/'
  else
    return 'failed'
  end
end

delete '/list/:id' do
  List.find(params[:id]).destroy
  redirect '/'
end
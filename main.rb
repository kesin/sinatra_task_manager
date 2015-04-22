require 'sinatra'
require 'sinatra/activerecord'
require 'slim'

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
  @task = List.find(params[:id]).tasks.new params[:task]
  if @task.save
    redirect '/'
  else
    return 'Create task failed !'
  end
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
    return 'Create list failed!'
  end
end

delete '/list/:id' do
  List.find(params[:id]).destroy
  redirect '/'
end
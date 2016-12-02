# app.rb
require 'sinatra'
require 'json'
require 'sequel'

db_connection = Sequel.connect('postgres://postgres@my-postgres:5432/trunk_cocoapods_org_development')

get '/' do
  File.read(File.join('html', "search.html"))
end

get '/pods' do
  pod_result  = db_connection[:pods].all
  content_type  :json
  JSON.pretty_generate(pod_result)
end

get '/pods/:name' do
  pod_result  = db_connection[:pods].where(Sequel.ilike(:name, '%' + params[:name] + '%')).all
  content_type  :json
  JSON.pretty_generate(pod_result)
end

get '/pods/:name/latest' do
  pod_result  = db_connection[" SELECT p.name AS name, pv.name AS version FROM pods AS p
                                INNER JOIN 
                                (SELECT id,name,pod_id FROM pod_versions AS pv1 WHERE created_at = (SELECT max(created_at) FROM pod_versions AS pv2                     
                                WHERE pv1.pod_id = pv2.pod_id)) AS pv 
                                ON p.id = pv.pod_id
                                WHERE LOWER(p.name) LIKE LOWER('%' || ? || '%')", params[:name]].all
  content_type  :json
  JSON.pretty_generate(pod_result)
end

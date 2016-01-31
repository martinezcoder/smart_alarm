json.array! @endpoints do |endpoint|
  json.partial! 'endpoints/info', endpoint: endpoint
end

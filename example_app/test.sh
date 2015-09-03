#!/bin/sh
bin/rails runner '
app = ActionDispatch::Integration::Session.new(Rails.application)
app.get("/assets/application.js")

if app.status != 200
  fail "application.js returned #{app.status}"
end

if app.body !~ /Imba.defineTag = /
  fail "application.js does not include Imba runtime"
end

if app.body !~ /Hello Imba!/
  fail "application.js does not include our Imba code"
end

puts "ok"
'


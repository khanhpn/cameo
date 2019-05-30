# Guide

Things you may want to cover:

* Ruby version: 2.6.3

* Rails version: 5.2.3

* Database: Postgresql

* Services (delayed_job)

* Deployment instructions
  + Install dependency `npm install`
  + Run `rails db:create`
  + Run `rails db:migrate`
  + run `rails db:seed`
  + Run delayed_job
    + `RAILS_ENV=production script/delayed_job start`
  
    + `RAILS_ENV=production script/delayed_job stop`
  + Edit credential file, include some environment variables such as:
    + database information
    + basic authentication
    + How to change:
      + Copy file from `master.key.sample` to `master.key` and this file was put in: `config` folder
      + Using this syntax for edit: `EDITOR=vim bin/rails credentials:edit`
  + Start rails server `rails server`

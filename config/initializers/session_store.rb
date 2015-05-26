# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: 'current_donor', expire_after: 60.minutes 
Rails.application.config.session_store :cookie_store, key: 'staff_id', expire_after: 540.minutes
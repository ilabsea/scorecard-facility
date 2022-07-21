# Pin npm packages by running ./bin/importmap

pin "application", preload: true

pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.3/lib/assets/compiled/rails-ujs.js"

pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.1.0/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin_all_from "app/javascript/controllers", under: "controllers"

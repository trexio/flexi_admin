# FlexiAdmin Rails

Steps required to get FlexiAdmin working with a Rails app:

**Gemfile**

1. add `gem 'flexi_admin', git: 'https://github.com/landovsky/flexi_admin.git', branch: 'main'` to the `Gemfile`

**Stylesheets**

2. add `@import "flexi_admin.scss";` to the `app/assets/stylesheets/application.scss` file

**JavaScript**

3. add `import "flexi_admin";` to the `app/javascript/application.js` file

# Temporary (workaround) requirements

- can't get stylesheets to load from gem, so adding to host app:

```scss
// Production
// @import "flexi_admin.scss";
// Local dev
// @import "../../flexi_admin/app/assets/stylesheets/flexi_admin";
```

- add modals controller:

```
# frozen_string_literal: true

class ModalsController < AdminController
  include FlexiAdmin::Controllers::ModalsController
end
```

```ruby
  resources :modals, only: [] do
    get :show, on: :collection
  end
```

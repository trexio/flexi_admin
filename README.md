# FlexiAdmin Rails

Steps required to get FlexiAdmin working with a Rails app:

**Gemfile**

1. add `gem 'flexi_admin', git: 'https://github.com/landovsky/flexi_admin.git', branch: 'main'` to the `Gemfile`

**Stylesheets**

2. add `@import "flexi_admin.scss";` to the `app/assets/stylesheets/application.scss` file

**JavaScript**

3. add `import "flexi_admin";` to the `app/javascript/application.js` file

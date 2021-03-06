#rails new blog -m app_template.rb
class AppBuilder < Rails::AppBuilder
  def readme
    create_file "README.md", "TODO"
  end

  def test
    @generator.gem 'rspec-rails', group: [:test, :development]
    @generator.gem 'cucumber-rails', group: [:test]
    @generator.gem 'database_cleaner', group: [:test]
    @generator.gem 'capybara', group: [:test]
    run 'bundle install'
    generate 'rspec:install'
  end

  def leftovers
    if yes? "Do you want to generate a root controller?"
      name = ask("What should it be called?").underscore
      generate :controller, "#{name} index"
      route "root to: '#{name}\#index'"
      remove_file "public/index.html"
    end

    git :init
    append_file ".gitignore", "config/database.yml"
    run "cp config/database.yml config/example_database.yml"
    run "mkdir features"
    git add: ".", commit: "-m 'initial commit'"
  end
end

---
layout: post
title: Starting a Ruby on Rails project from existing data
date: 2013-10-23 12:10:45 +0200
categories:
- Technical
- Ruby on Rails
---
<p>Ideally when you are starting a Ruby on Rails project you're starting from scratch and most tutorials and guides you'll find on the Internet assume this. I found very little information about starting a project from existing data and I thought I'd share the solution which I found and consider the simplest.</p>
<p>So, we're supposing the already existing database is called <em>library_development</em> and you can access it with the <em>joe</em> user having password <em>secret</em> and that you have created a new rails app which should be able to connect to a mysql database.</p>
<p>The first thing you should do is configure your database, by editing the development section of config/database.yml to look something like the following (please note that the highlighted lines have the same values as above):</p>
<p>[code highlight="5,7,8"]development:<br />
  adapter: mysql2<br />
  encoding: utf8<br />
  reconnect: false<br />
  database: library_development<br />
  pool: 5<br />
  username: joe<br />
  password: secret<br />
  socket: /var/run/mysqld/mysqld.sock[/code]</p>
<p>You are now ready to dump the schema (structure) of your database by issuing:</p>
<p><code>rake db:schema:dump</code></p>
<p>This will generate db/schema.rb. Now you need to copy the contents of this file and save it as your first migration. So let's create an empty migration file. Run:</p>
<p><code>rails generate migration create_database_structure</code></p>
<p>Move the contents of db/schema.rb into the up method of this first migration. Now whenever you will run your migration the database's structure will be created. But the database will still be empty. So let's populate it with your existing data.</p>
<p>I found the best option for this task to be the <a href="https://github.com/ludicast/yaml_db">yaml_db gem</a>. Let's add it to your project. Edit your Gemfile and add the following line:</p>
<p>[code]gem 'yaml_db'[/code]</p>
<p>Now run:</p>
<p><code>bundle install</code></p>
<p>The yaml_db gem should now be installed. Try running:</p>
<p><code>rake db:data:dump</code></p>
<p>If all goes well you should have a db/data.yml file containing your data. Now we want to restore this data by a migration, so let's create your second migration:</p>
<p><code>rails generate migration import_data</code></p>
<p>This second migration's up method should be the following:</p>
<p>[ruby]Rake::Task['db:data:load'].invoke[/ruby]</p>
<p>And you're all set!</p>
<p>Take a deep breath and reset your existing database and run the migrations. If by any chance something goes horribly wrong you still have the original database dump file stored somewhere safe, right?</p>
<p><code>rake db:reset<br />
rake db:migrate</code></p>
<p>Tadaaa, your database should look just as it did before you reset it.</p>
<p>Now you can go ahead and create your models. Bonus tip: once you created your models, use the <a href="https://github.com/ctran/annotate_models">annotate gem</a> to add the structure of the associated tables as handy comments at the beginning of your model files.</p>
<p>Reference: <a href="http://blog.joelberghoff.com/2013/02/06/ruby-on-rails-tutorial-creating-a-rails-instance-from-an-existing-mysql-db/">Creating a Rails Instance from an Existing MySQL DB</a>.</p>
<p>PS. As a test, I also <a href="https://medium.com/p/7dda5044c85f">posted</a> this article to Medium.</p>

# rb-tumble
Ruby implementation of Tumble


# API

## Web UI Parts

 * `get /:number` - Page number
 * `get /:hotshit` - Get last week's hot shit. (not yet implemented)
 * `post /search` - Search for stuff (not yet implemented)

## Quote

 * `get /quote/:id` - return a quote (not yet implemented)
 * `post /quote`  - upload new quote. Requires `quote` and `author` to post.
 * `delete /quote/:id` - remove quote. (not yet implemented)

# Link

  * `get /link/:id` - visit link and increment counter for hot shit
  * `post /link` - upload new link. Requires `url` and `user` to post.
  * `delete /link/:id` - delete a link. (not yet implemented)


# Development
  
  * Edit the `config/database.yml` change `weburi` to your host info.
  * Build docker container `make image`
  * Edit `Makefile` with your mounts under `run task`
  * Run container `make run`
  * Inside the container `bundle`
  * Inside the container `rake db:migrate` will set up the database. It's best to mount that in.
  * Inside contianer `rake app` will run the app.
  * `rake shell` from secondary termainl windows will give more shell access to the container.


# Deployment
TBD

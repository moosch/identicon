# Identicon

When learning something it's good to build stuff.
Learning more about Elixir, here's an [identicon](https://en.wikipedia.org/wiki/Identicon) generator.

This was initially part of [Stephen Grider's](https://github.com/StephenGrider) [Udemy course](https://www.udemy.com/course/the-complete-elixir-and-phoenix-bootcamp-and-tutorial) but I wanted to make it a service.

## Things covered

- Doctests
- Exposing an endpoint with [Plug](https://github.com/elixir-plug/plug) and [Cowboy](https://github.com/ninenines/cowboy)
- [Poison](https://github.com/devinus/poison) for a JSON response
- [Erlang egd](https://github.com/erlang/egd) to generate images

Feel free to have a play around with it.

To generate docs for the functions included run `mix docs` and open `doc/index.html`

## Get Started

Prerequisites are you have to have [Elixir](https://elixir-lang.org/install.html) installed.

Pull down this repo, cd into `/identicon` and run `mix deps.get`. Then run `mix run --no-halt`
Open up your browser to [mix run --no-halt](http://localhost:8080)
To generate an Identicon go to [http://localhost:8080/moosch](http://localhost:8080/moosch) or whatever string you want to use.

## Getting started with Docker

Test it all works locally by building the release with `MIX_ENV=prod mix release identicon_generator`.
Then run `PORT=8080 _build/prod/rel/identicon_generator/bin/identicon_generator start` and to go [http://localhost:8080](http://localhost:8080)

If all working, build the docker image using `docker build -t identicon-generator .`
Once built you can run it with `docker run --env PORT=4000  --publish 4000:4000 identicon-generator:latest`

## License

MIT Licensed. Use all you like at your own risky fun. Go nuts.

Happy coding λ

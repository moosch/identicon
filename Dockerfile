FROM bitwalker/alpine-elixir:1.9.1 as build

ARG app_name=identicon_generator
ARG build_env=prod

ENV MIX_ENV=${build_env} TERM=xterm

WORKDIR /opt/app

RUN apk update \
    && mix local.rebar --force \
    && mix local.hex --force

# TODO: Cleanup here - don't include everything, do mix deps.get --only prod, or use .dockerignore file
COPY . .

RUN mix do deps.get, compile

RUN mix release ${app_name} \
    && mv _build/${build_env}/rel/${app_name} /opt/release \
    && mv /opt/release/bin/${app_name} /opt/release/bin/start_server

ENTRYPOINT ["/opt/release/bin/start_server"]
CMD ["start"]

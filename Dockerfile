# FROM plangora/alpine-elixir-phoenix:otp-22.0.4-elixir-1.9.0 as phx-builder
FROM bitwalker/alpine-elixir:1.9.1 as build

ENV PORT=4000 MIX_ENV=prod

ADD . .

# Run frontend build, compile, and digest assets, and set default to own the directory
RUN mix deps.get && mix do compile, release

FROM bitwalker/alpine-erlang:22.0.4

EXPOSE 4000
ENV PORT=4000 MIX_ENV=prod

COPY --from=build /opt/app/_build/prod/rel/identicon_generator/ /opt/app/
RUN chown -R default /opt/app/

USER default

CMD ["/opt/app/bin/identicon_generator", "start"]







#===========
#Build Stage
#===========
# FROM bitwalker/alpine-elixir:1.9.1 as build

# #Copy the source folder into the Docker image
# COPY . .

# #Install dependencies and build Release
# RUN export MIX_ENV=prod && \
#     rm -Rf _build && \
#     mix deps.get && \
#     mix release

# #Extract Release archive to /rel for copying in next stage
# RUN APP_NAME="identicon_generator" && \
#     RELEASE_DIR=`ls -d _build/prod/rel/$APP_NAME/releases/*/` && \
#     mkdir /export && \
#     tar -xf "$RELEASE_DIR/$APP_NAME.tar.gz" -C /export

# #================
# #Deployment Stage
# #================
# FROM pentacent/alpine-erlang-base:latest

# #Set environment variables and expose port
# EXPOSE 4000
# ENV REPLACE_OS_VARS=true \
#     PORT=4000

# #Copy and extract .tar.gz Release file from the previous stage
# COPY --from=build /export/ .

# #Change user
# USER default

# #Set default entrypoint and command
# ENTRYPOINT ["/opt/app/bin/identicon_generator"]
# CMD ["foreground"]
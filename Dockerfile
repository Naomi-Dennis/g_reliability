FROM bitwalker/alpine-elixir-phoenix
ADD . ./app

WORKDIR ./app
EXPOSE 4000

ENV MIX_ENV prod

RUN mix local.rebar --force
RUN mix local.hex --force
RUN mix deps.get
RUN mix compile
RUN mix phx.digest
RUN mix release --overwrite


CMD _build/prod/rel/mind_the_gapp/bin/mind_the_gapp start

#!/bin/sh
set -e
mix deps.get
mix deps.compile
mix ecto.create
mix ecto.migrate
mix phx.server
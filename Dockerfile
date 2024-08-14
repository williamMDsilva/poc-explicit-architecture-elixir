# Reference to use in docker-file and docker compose 
# https://dev.to/maiquitome/elixir-dockerizando-aplicacoes-phoenix-19gg
# https://medium.com/@hex337/running-a-phoenix-1-3-project-with-docker-compose-d82ab55e43cf
FROM elixir:1.14.4

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . /app

WORKDIR /app

EXPOSE 4000
RUN chmod +x run.sh

CMD ["./run.sh"]
# CMD ["mix", "phx.server"]

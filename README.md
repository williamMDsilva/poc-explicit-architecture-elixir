# Explicit Architecture POC

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## archtectural concepts based on Explicit Architecture

<a href="https://herbertograca.com/2017/11/16/explicit-architecture-01-ddd-hexagonal-onion-clean-cqrs-how-i-put-it-all-together/">

## Workflow

<img src="./Flowchart.png" />

## Resorces API - reference book

<a href="./lib/app/notification/notification-subscribe.md">POST /notification/subscribe</a>
<a href="./lib/app/notification/notification-send.md">POST /notification/send/all</a>
<a href="./lib/app/notification/notification-send.md">POST /notification/send/:push_token</a>

## Local configs

- Run infra:
  ```sh
   docker-compose up -d
  ```
- Database migrations
  ```sh
   mix ecto.migrate
  ```
- Run server
  ```sh
  mix phx.server
  ```

## Reference to build new modules

<img src="https://butovo.zone/clean_and_hexagonal.png" />

## Run runing tests

```sh
 mix test ./test/**/*.ex
```

## Run on docker-composer

Build image

```sh
docker build -t app/expo-project .
```

Run container

```sh
docker run -p 4000:4000 app/expo-project
```

Docker composer command

```sh
docker-compose up
```

or

```sh
docker-compose up -d
```

## ROADMAP

- [X] POST /notification/subscribe
- [ ] DELETE /notification/subscribe
- [X] POST /notification/send/all
- [X] POST /notification/send/:push_token
- [ ] gRPC impl
- [ ] Create flavors to dev and prod

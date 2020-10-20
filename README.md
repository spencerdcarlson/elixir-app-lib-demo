# DemoApp

Example application that demonstrate how applications are isolated. 

## Run
* `mix deps.get && iex -S mix phx.server`
* See [localhost:4000/api/swagger](http://localhost:4000/api/swagger) to test endpoints

## Details
There is a nested "hex package" under the [demo_lib](./demo_lib) folder that this phoenix application uses.
See [controller.ex](./lib/demo_app_web/controllers/controller.ex) for more details on how DemoLib functions are used.

The idea is to demonstrate how the `:demo_lib` application crashing, or running into errors affects or does not affect 
this phoenix application depending on how the `:demo_lib` application is used.

Play with `start_permanent: true` in [mix.exs](./mix.exs) to see different behaviors after hitting `/api/lib/crash` 

## DemoLib
You can modify and rebuild `:demo_lib` by executing `cd demo_lib && mix compile`
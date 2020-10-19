defmodule DemoLib do
  @moduledoc """
  Documentation for DemoLib.
  """

  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, %{value: nil}, name: __MODULE__)
  end

  @impl GenServer
  def init(args) do
    initial_state = Map.take(args, [:value])
    {:ok, initial_state}
  end

  # Client
  def kill do
    # If a supervised process dies more then 4 times in less than
    # See Supervisor options :max_restarts (default 3) and :max_seconds (Default 5)
    # We can kill the supervisor by exceding these defaults for a child that it is supevising
    raise_after(:timer.seconds(1))
    raise_after(:timer.seconds(2))
    raise_after(:timer.seconds(3))
    raise_after(:timer.seconds(4))
  end

  def raise_after(ms \\ :timer.seconds(1)), do: Process.send_after(__MODULE__, {:raise_after}, ms)

  def put_secret(value), do: GenServer.cast(__MODULE__, {:put_value, value})

  def get_secret, do: GenServer.call(__MODULE__, {:get_value})

  # Server
  @impl GenServer
  def handle_info({:raise_after}, _state), do: raise "There was a rare issue processing data"

  @impl GenServer
  def handle_info(_args, state), do: {:noreply, state}

  @impl GenServer
  def handle_cast({:put_value, value}, state) do
    new_state = %{state | value: value}
    IO.inspect(new_state, label: "new_state")
    IO.inspect(value, label: "value")
    {:noreply, new_state}
  end

  @impl GenServer
  def handle_call({:get_value}, _from, state = %{value: value}) do
    {:reply, value, state}
  end


end

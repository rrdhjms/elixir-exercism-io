defmodule RobotSimulator do
  defstruct [:position, :direction]

  defguardp is_direction(direction)
            when direction in [:north, :east, :south, :west]

  defguardp is_position(position)
            when is_tuple(position) and
                   tuple_size(position) == 2 and
                   is_integer(elem(position, 0)) and
                   is_integer(elem(position, 1))

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _) when not is_direction(direction), do: {:error, "invalid direction"}
  def create(_, position) when not is_position(position), do: {:error, "invalid position"}
  def create(direction, position), do: %RobotSimulator{position: position, direction: direction}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce_while(robot, fn instruction, robot ->
      case apply_instruction(robot, instruction) do
        {:error, _} = error -> {:halt, error}
        robot -> {:cont, robot}
      end
    end)
  end

  defp apply_instruction(robot, instruction) when instruction in ["L", "R"] do
    %{robot | direction: turn(robot.direction, instruction)}
  end

  defp apply_instruction(robot, "A") do
    %{robot | position: advance(robot.position, forward(robot.direction))}
  end

  defp apply_instruction(_, _), do: {:error, "invalid instruction"}

  defp turn(:north, "L"), do: :west
  defp turn(:north, "R"), do: :east
  defp turn(:east, "L"), do: :north
  defp turn(:east, "R"), do: :south
  defp turn(:south, "L"), do: :east
  defp turn(:south, "R"), do: :west
  defp turn(:west, "L"), do: :south
  defp turn(:west, "R"), do: :north

  defp advance({oldx, oldy}, {forwardx, forwardy}) do
    {oldx + forwardx, oldy + forwardy}
  end

  defp forward(:north), do: {0, 1}
  defp forward(:east), do: {1, 0}
  defp forward(:south), do: {0, -1}
  defp forward(:west), do: {-1, 0}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end

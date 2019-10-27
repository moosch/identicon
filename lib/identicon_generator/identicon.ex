defmodule IdenticonGenerator.Identicon do

  @doc """
  Hashes a string input and returns the hash within the Image struct as hex

  ## Examples

      iex> hash = IdenticonGenerator.Identicon.hash_input("banana")
      iex> Map.get(hash, :hex)
      [114, 179, 2, 191, 41, 122, 34, 138, 117, 115, 1, 35, 239, 239, 124, 65]

  """
  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list()

    %IdenticonGenerator.Image{hex: hex}
  end

  @doc """
  Picks a color based on the first three numbers of list as RGB values

  ## Examples

      iex> color = IdenticonGenerator.Identicon.pick_color(%IdenticonGenerator.Image{hex: [200, 201, 202, 100, 123, 123, 255]})
      iex> Map.get(color, :color)
      {200, 201, 202}

  """
  def pick_color(%IdenticonGenerator.Image{hex: [r, g, b | _tail ]} = image) do
    %IdenticonGenerator.Image{image | color: {r, g, b}}
  end

  @doc """
  Takes a Image struct and returns an updated struct with grid as hex array chunked by 3 and mirrored, then each item is placed in a tuple with it's list index

  ## Examples

      iex> grid = IdenticonGenerator.Identicon.build_grid(%IdenticonGenerator.Image{hex: [200, 201, 202, 100, 123, 124, 255]})
      iex> Map.get(grid, :grid)
      [{200, 0}, {201, 1}, {202, 2}, {201, 3}, {200, 4}, {100, 5}, {123, 6}, {124, 7}, {123, 8}, {100, 9}]

  """
  def build_grid(%IdenticonGenerator.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %IdenticonGenerator.Image{ image | grid: grid }
  end

  @doc """
  Takes a list and appends the second and first elements to the end of the list

  ## Examples

      iex> IdenticonGenerator.Identicon.mirror_row([200, 201, 202])
      [200, 201, 202, 201, 200]

  """
  def mirror_row(row) do
    [ r, g | _tail ] = row
    row ++ [g, r]
  end

  @doc """
  Filters only even tuple values of the grid provided

  ## Examples

      iex> grid = IdenticonGenerator.Identicon.filter_even_squares(%IdenticonGenerator.Image{grid: [{200, 0}, {201, 1}, {202, 2}, {201, 3}, {200, 4}]})
      iex> Map.get(grid, :grid)
      [{200, 0}, {202, 2}, {200, 4}]

  """
  def filter_even_squares(%IdenticonGenerator.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end

    %IdenticonGenerator.Image{ image | grid: grid }
  end

  @doc """
  Builds a pixel map of squares to be colored
  """
  def build_pixel_map(%IdenticonGenerator.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({ _code, index }) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = { horizontal, vertical }
      bottom_right = { horizontal + 50, vertical + 50 }

      {top_left, bottom_right}
    end

    %IdenticonGenerator.Image{ image | pixel_map: pixel_map }
  end

  @doc """
  Builds an image binary based on the Image struct pixel_map and selected color
  """
  def draw_image(%IdenticonGenerator.Image{ color: color, pixel_map: pixel_map }) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each pixel_map, fn({ start, stop }) ->
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end

  @doc """
  Generates Identicon
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_even_squares
    |> build_pixel_map
    |> draw_image
  end

end

defmodule Identicon do

  def main(input_string) do

    input_string
    |> hash_string
    |> pick_colour_from_hash
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input_string)

  end

  def hash_string(input_string) do
    hash = :crypto.hash(:md5,input_string)
    |> :binary.bin_to_list
    %Identicon.Image{hash: hash}
  end

  def pick_colour_from_hash(%Identicon.Image{hash: [r,g,b | _tail]} = image_struct) do
    %Identicon.Image{image_struct | colour: {r,g,b}}
  end

  def build_grid(%Identicon.Image{hash: hash} = image_struct) do
    grid =
      hash
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
    %Identicon.Image{image_struct | grid: grid}
  end

  def mirror_row([first,second,_tail] = row) do
      row ++ [second,first]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image_struct) do
    grid = Enum.filter grid, fn({x,_index}) ->
      rem(x, 2) == 0
    end
    %Identicon.Image{image_struct | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image_struct) do
    pixel_map = Enum.map grid, fn({_hex,index}) ->
       horz = rem(index, 5) * 50
       vert = div(index, 5) * 50
       top_left = {horz, vert}
       bottom_right = { horz + 50, vert + 50 }
       {top_left, bottom_right}
    end
    %Identicon.Image{image_struct | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{colour: colour, pixel_map: pixel_map}) do

    image = :egd.create(250,250)
    fill = :egd.color(colour)
    Enum.each pixel_map, fn({start,stop}) ->
        :egd.filledRectangle(image, start, stop, fill)
    end
    :egd.render(image)
  end

  def save_image(image,filename) do
    File.write("#{filename}.png", image)
  end

end

class MineSweeper
  def self.transform(matrix)
    grids = read(matrix)
    strings = []
    grids.each_with_index do |grid, index|
      strings.push(["Field ##{index + 1}:\n"])
      strings.push(parse(grid))
    end

    result = strings.join('')
    result[0..result.length - 2]
  end

  def self.parse(grid)
    result = []
    grid.each_with_index do |str, i|
      row = []
      str.each_char.with_index do |char, j|
        if char == "*"
          row << char
        else
          row << count(grid, i, j)
        end
      end
      result.push(row.join('') << "\n")
    end
    result[result.length - 1] << "\n"
    result
  end

  def self.count(grid, i, j)
    count = 0
    (i - 1..i + 1).each do |row|
      (j - 1..j + 1).each do |col|
        count += 1 if bounds(grid, row, col) && grid[row][col] == '*'
      end
    end
    count
  end

  def self.bounds(grid, row, col)
    !(row.negative? || col.negative? || row >= grid.length || col >= grid[0].length)
  end

  def self.read(matrix)
    rows = matrix.split("\n")
    n = 0
    grids = []
    grid = []
    rows.each do |row|
      if n.zero?
        grids.push(grid) unless grid.empty?
        n, = row.split(' ').map(&:to_i)
        grid = []
        next
      end

      grid.push(row)
      n -= 1
    end

    grids
  end
end

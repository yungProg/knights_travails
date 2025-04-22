class KnightTravails
  MOVES = [
    [2,1], [1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2],[2,-1]
  ]
  def initialize
    @board_size = 8
  end

  def knight_moves(start, destination)
    return [start] if start == destination

    queue = [start]
    visited = Set.new(start)
    parent_map = {}

    until queue.empty?
      current = queue.shift
      MOVES.each do |dx, dy|
        new_position = [current[0] + dx, current[1] + dy]
        next unless in_bounds?(new_position) && !visited.include?(new_position)

        visited.add(new_position)
        parent_map[new_position] = current
        queue << new_position

        if new_position == destination
          return build_path(start, destination, parent_map)
        end
      end
    end
    []
  end

  def in_bounds?(position)
    position.all? { |coordinates| coordinates.between?(0, @board_size - 1) }
  end

  def build_path(start, destination, parent_map)
    path = destination
    while path.first != start
      path.unshift(parent_map[path.first])
    end
    path
  end
end

require 'set'
finder = KnightTravails.new
path = finder.knight_moves([0,0], [3,3])
puts "You made it in #{path.length - 1} moves!"
path.each { |step| p step}
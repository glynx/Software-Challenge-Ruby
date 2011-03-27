
class Node
  attr_accessor :type
  attr_accessor :index
  attr_accessor :neighbours # Is a hash because of performance when searching!

  def initialize(type, id, neighbours)
    @type = type
    @index = id.to_i
    @neighbours = {}
    if neighbours.is_a? Array
      neighbours.each{|n| @neighbours[n.to_i] = true}
    else
      @neighbours[neighbours.to_i] = true
    end
  end

  def grass?
    @type == "GRASS"
  end

  def home?
    @type == "HOME1" or @type == "HOME2"
  end

  def save?
    @type == "SAVE"
  end

  def home_of?(player)
    @type == "HOME#{player.positon}"
  end

  def home_of_opponent?(player)
    @type == "HOME#{player.to_i == 1 ? 2 : 1}"
  end
  
  def has_neighbour?(ne)
     !!neighbours[ne.is_a? Node ? ne.index : ne]
  end

  def to_i
    @index
  end

end


class Board
  attr_accessor :nodes


  def initialize(nodes)
    @nodes = []
    for node in nodes
      @nodes[node['ID'].to_i] = Node.new(node['type'], node['ID'], node['neighbours'])
    end
  end

  def calculate_distance(from,to)
    f = (from.is_a?(Integer) ? from : from.index)
    t = (to.is_a?(Integer) ? to : to.index)
    $distances[f][t]
  end 
end


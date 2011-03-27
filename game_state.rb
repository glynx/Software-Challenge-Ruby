class Player
  attr_accessor :displayName, :color, :munchedFlowers, :stolenSheeps, :state, :sheeps, :position
  def initialize(args, state)
    @state = state
    @sheeps = []
    @displayName = args['displayName']
    @color = args['color']
    @position = @color == "RED" ? 1 : 2
    @munchedFlowers = args['munchedFlowers']
    @stolenSheeps = args['stolenSheeps']
  end

  def first_player?
    @color == "RED"
  end

  def second_player?
    @color == "BLUE"
  end

  def to_i
    @position
  end

end

class Sheep
  attr_accessor :index, :node, :sheeps1, :sheeps2, :target, :owner, :state
  
  def initialize(args, state)
    @state = state
    @index = args['index'].to_i if args['index']
    @node = args['node'].to_i if args['node']
    @sheeps1 = args['sheeps1'].to_i if args['sheeps1']
    @sheeps2 = args['sheeps2'].to_i if args['sheeps2']
    @target = args['target'].to_i if args['target']
    @owner = args['owner'] == "RED" ? 1 : 2 if args['owner']
    @dog = args['dog'] if args['dog']
  end

  def has_dog? 
    !!@dog
  end

  def dog_active?
    @dog == "ACTIVE"
  end

  def dog_passive?
    @dog == "PASSIVE"
  end

  def to_i
    index
  end

end

class Flower
  attr_accessor :amount, :node, :state
  def initialize(elements,state)
    @state = state
    @amount = elements['amount'].to_i if elements['amount']
    @node = elements['node'].to_i if elements['node']
  end
end

class GameState
  attr_accessor :players, :dog, :sheeps, :flowers, :dice, :state, :board, :sheeps_at_nodes, :turn
  def parse_input(elements, board)
    
    @players = {} # 1 => Player1, 2 => Player2
    @sheeps = {}  # SheepIndex => Sheep
    @sheeps_at_nodes = {} # Node => Sheep[]
    @flowers = {} # Node => Flower
    @dice = [] # [1,2,3] 
    @board = board # the board we are playing at!

    for el in elements
      case el[0]
        when "CURRENT"
          @turn = el[1]['turn'].to_i
	  @current_player = (el[1]['player'] == "RED" ? 1 : 2)
        when "PLAYER"
	  p = Player.new(el[1], self)
          @players[p.position] = p
	when "SHEEP"
          s = Sheep.new(el[1], self)
          @sheeps[s.index] = s
	  add_sheep_at_node(s,s.node)
	when "FLOWERS"
	  f = Flower.new(el[1], self)
          @flowers[f.node] = f 
        when "DIE"
          @dice << el[1]['value'].to_i
	end
      end

     @sheeps.values.each do |s|
       if s.owner
          @players[s.owner].sheeps << s
       elsif s.has_dog?
          @dog = s
       end
     end

  end
    
  def die?(eye_count)
   dice.include? eye_count?
  end

  def current_player
    @players[@current_player]
  end

  def sheep_at(node)
    n_id = node.to_i
    @sheeps_at_nodes[n_id]
  end

  def sheep_at?(node)
    s = sheep_at(node) 
    not (s.nil? or s.empty?)
  end

  def flower_at(node)
    n_id = node.to_i
    flowers[n_id]
  end

  def player_has_sheep_at?(player,node)
    sheeps = @sheeps_at_nodes[node.to_i] || []
    for sheep in sheeps
       return true if player == sheep.owner
    end
    return false
  end

  # Checks if a node is reachable with the current dice
  def node_reachable?(sheep,node,dice=@dice)
    n_id = node.to_i
    dist = @board.calculate_distance(sheep.node,n_id)
    dice.include? dist
  end
  
  def move_possible?(sheep,node, dice = @dice)
    return false unless node_reachable? sheep,node,dice
    return false if player_has_sheep_at?(sheep.owner,node) 
    return false if sheep_at?(node) and node.save? and not sheep.dog_active?
    return false if node.home_of_opponent? @players[sheep.owner]
    return false if sheep.node == node.to_i
    return true
  end

 protected
  def add_sheep_at_node(sheep,node)
   @sheeps_at_nodes[node] = [] if not @sheeps_at_nodes[node] 
   @sheeps_at_nodes[node] << sheep
  end
    
end
  

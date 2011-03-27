class SimpleLogic < AbstractLogic
  def move_requested
     @state.current_player.sheeps.each do |sheep|
       @board.nodes.each_value do |target|
         if @state.move_possible?(sheep, target) and @state.might_be_safe_move?(sheep,target)
           puts "Found save Move: #{sheep.index} from #{sheep.node} to #{target.to_i}"
	   return [sheep,target] 
	 end
       end
     end 

    puts "No safe positions found, falling back!"
    return iterative_fallback
   end

   def iterative_fallback
     @state.current_player.sheeps.each do |sheep|
     @board.nodes.each_value do |target|
       return [sheep,target] if @state.move_possible? sheep, target
      end
     end 
   end
end


class GameState
  def might_be_safe_move?(sheep,node)
    used_die = @board.calculate_distance(sheep.node,node)
    dice = @dice.clone
    dice.delete(used_die)
    current_opponent.sheeps.each do |o_sheep|
      if node_reachable?(o_sheep,node,dice)
         if (not node.save?) or o_sheep.dog_active?
           return false
         end
      end
    end
    return true
  end

  def safe_move_for_sheep?(sheep,node,die)
    current_opponent.sheeps.each do |o_sheep|
      return false if @board.calculate_distance(o_sheep.node, sheep.node) <= 6 
    end
    return true
  end

  def current_opponent
    @current_player == 1 ? @players[1] : @players[2]
  end
end

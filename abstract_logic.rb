class AbstractLogic
  attr_accessor :board, :state, :client

  def initialize(client)
   @client = client
  end

  def update
    @state = client.state
    @board = client.board
  end

  def handle_move_request!
    update
    move = move_requested()
    @client.send_move! move[0], move[1]
  end
  
  # IMPLEMENT move_requested method in your logic! This should return an Array: [Sheep,TargetNode]
end

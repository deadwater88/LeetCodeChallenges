class BinaryTreeNode
  attr_reader :parent, :value, :children
  def initialize(value = nil)
    @value = value
    @parent = nil
    @left = nil
    @right = nil
  end

end

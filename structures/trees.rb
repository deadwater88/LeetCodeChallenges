
class PolyTreeNode
  attr_reader :parent, :value, :children
  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    return if node.nil?
    @parent.children << self if not @parent.children.include? self
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Given node is not a child" if !self.children.include? child_node
    child_node.parent = nil
  end


  def dfs(target)
    return self if @value == target
    @children.each do |child|
     candidate = child.dfs(target)
     return candidate if candidate
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      cnode = queue.shift
      return cnode if cnode.value == target
      queue += cnode.children
    end
    nil
  end
end

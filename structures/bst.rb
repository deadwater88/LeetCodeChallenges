

class BSTNode
  attr_accessor :value, :left, :right, :parent

  def initialize(value)
    @value = value
  end

end
#root
#insert(value, [,node])
#find(value, [,node])
#delete(value)
#maximum(node)
#is_balanced()
#in_order_traversal, returns array.

class BinarySearchTree
  attr_accessor :root

  def initialize(node=nil)
    @root = node
  end

  def insert(value, node=@root)
    return @root = BSTNode.new(value) if node.nil?
    if value <= node.value
      node.left ? insert(value, node.left) : node.left = BSTNode.new(value);
    else
      node.right ? insert(value, node.right) : node.right = BSTNode.new(value);
    end
  end


  def find(value, node=@root)
    output = find_with_parent(value, node)
    output ? output[:child] : nil
  end

  def delete(value)
    return @root = nil if @root.value == value
    object = find_with_parent(value)
    target, parent, relation = object[:child], object[:parent], object[:relation]
    if !target.left && !target.right
      parent.instance_variable_set(relation, nil)
    elsif target.left && target.right
      maxobj = max_with_parent(target.left, parent)
      max, max_parent, = maxobj[:max], maxobj[:max_parent]
      parent.instance_variable_set(relation, max)
      max_parent.right = max.left
      max.left = target.left
    else
      promotee = target.left || target.right
      parent.instance_variable_set(relation, promotee)
    end
  end

  def find_with_parent(value, node=@root)
    child = false
    until child
      if !node.left && !node.right
        return false
      elsif node.left && node.left.value == value
        child = node.left
        relation = :@left
      elsif node.right && node.right.value == value
        child = node.right
        relation = :@right
      else
        node = value <= node.value ? node.left : node.right
      end
    end
    return {parent: node, child: child, relation: relation}
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    output = max_with_parent(tree_node)
    output ? output[:max] : false
  end

  def max_with_parent(tree_node = @root, parent=nil)
    return false unless tree_node
    tree_node.right ? max_with_parent(tree_node.right, tree_node) :
    {max: tree_node, max_parent: parent}
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil?
    return 0 if !tree_node.left && !tree_node.right
    return 1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    depth(tree_node.left) - depth(tree_node.right) <= 1 &&
    (is_balanced?(tree_node.left) && is_balanced?(tree_node.right))
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr.push tree_node.value
    in_order_traversal(tree_node.right, arr)
    arr
  end


  private
  # optional helper methods go here:

end

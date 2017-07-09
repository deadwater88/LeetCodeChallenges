class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(store= [], &prc)
    prc ||= Proc.new{|a,b| a <=> b}
    @store = store
    @prc = prc
  end

  def count
    @store.length
  end

  def extract(len = @store.length)
    @store[0], @store[-1] = @store[-1], @store[0]
    output = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, len - 1, &@prc )
    output
  end

  def _extract(i)
    max = @store[0]
    @store[0], @store[i] = @store[i], @store[0]
    BinaryMinHeap.heapify_down(@store, 0, i, &@prc)
    max
  end

  def peek
    @store[0]
  end

  def push(val, len = @store.length)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, len, len + 1, &@prc)
  end

  def _push(i)
    BinaryMinHeap.heapify_up(@store, i, i + 1, &@prc)
  end


  public
  def self.compare(array, idx1, idx2, &prc)
    prc.call(array[idx1], array[idx2])
  end

  def self.child_indices(len, parent_index)
    child_index = parent_index * 2 + 1
    [child_index, child_index + 1].select{|i| i < len}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    output =  (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc||= Proc.new {|a,b| a <=> b}
    children = self.child_indices(len, parent_idx)
    if children.empty? || children.all? {|child| prc.call(array[child], array[parent_idx]) > 0}
      return array
    else
      if children.length == 1
        swapper = children[0]
      else
        swapper = prc.call(array[children[0]], array[children[1]]) > 0 ? children[1] : children[0]
      end
      # debugger if array.length == 3
      array[swapper], array[parent_idx] = array[parent_idx], array[swapper]
      self.heapify_down(array, swapper, len, &prc)
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc||= Proc.new {|a,b| a <=> b}
    parent_idx = self.parent_index(child_idx)
    if prc.call(array[child_idx], array[parent_idx]) > 0
      array
    else
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    end
  end
end

class Array
  def heap_sort!
    heap = BinaryMinHeap.new(self) { |b, a| (a <=> b) }
    (1...length).each { |i| heap._push(i) }
    (length - 1).downto(1) { |i| heap._extract(i) }
  end
end

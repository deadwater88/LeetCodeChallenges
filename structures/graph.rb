#Unidirectional

class Vertex
  attr_accessor :value, :in_edges, :out_edges
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_accessor :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    @cost = cost
    @from_vertex.out_edges.push(self)
    @to_vertex.in_edges.push(self)
  end

  def destroy!
    @from_vertex.out_edges.delete(self)
    @to_vertex.in_edges.delete(self)
    @from_vertex, @to_vertex = nil, nil
  end
end

def topological_sort(vertices)
  in_edges = {}
  result = []
  queue = vertices.select do |vertex|
    in_edges[vertex] = vertex.in_edges.length
    vertex.in_edges.empty?
  end

  until queue.empty?
    vertex = queue.pop
    result.push(vertex)
    vertex.out_edges.map(&:to_vertex).each do |vertex|
      in_edges[vertex] -= 1
      queue.unshift(vertex) if in_edges[vertex] == 0
    end
  end
  in_edges.all?{|vertex,count| count == 0} ? result : []

end

class Node
 
    attr_accessor :left_child, :right_child
    attr_reader :data

    def initialize(data, left_child = nil, right_child = nil)
        @data = data
        @left_child = nil
        @right_child = nil
    end

end

class Tree

    attr_accessor :root

    def initialize(array = nil) # Constructs a balanced search tree from an array

        root = build_tree(array)

    end

    def build_tree(array)

        return nil if array == nil # Nil Case

        array = array.sort.uniq
        @root_index = (array.length() / 2) # The middle of the array

        @root = Node.new(array[@root_index]).data != nil ? Node.new(array[@root_index]) : nil

        @left_child = array[array[0]..array[@root_index - 1]]
        @right_child = array[array[@root_index + 1]..array.last()]
    
        # Construct the left subtree recursively and make it a child of the root.
        @node.left_child = build_tree(@left_child)

        # Construct the right subtree recursively and make it a child of the node
        @node.right_child = build_tree(@right_child)

        @node

    end

    #ef pretty_print(node = @root, prefix="", is_left = true)
    #     pretty_print(node.right_child, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right_child
    #    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    #    pretty_print(node.left_child, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left_child
    #end

    def insert(data)
        inserted_node = Node.new(data)
    end

end

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
testy = Tree.new(test_array)
#p testy.pretty_print
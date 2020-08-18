class Node
 
    attr_accessor :left_child, :right_child, :data
  
    def initialize(data)
      @data = data
      @left_child = nil
      @right_child = nil
    end
  
  end
  
  class Tree
  
    attr_accessor :root
  
    def initialize(array) # Constructs a balanced search tree from an array
  
      @root = build_tree(array)
  
    end
  
    def build_tree(array)
  
      array = array.sort.uniq
      root_index = array.length / 2 # The middle of the array
   
      # Adjust for nil case
      root = Node.new(array[root_index]).data != nil ? Node.new(array[root_index]) : nil
  
      return root if array.length <= 1 # Base case
      
      root.left_child = build_tree(array[0..root_index - 1])
      root.right_child = build_tree(array[root_index + 1..array.length - 1])
  
      return root
    end
  
    def insert(node = @root, number)
      return node.data if node.data == number # Base case
  
      if number < node.data
        if node.left_child === nil
          node.left_child = Node.new(number)
        else
          insert(node.left_child, number)
        end
      else
        if node.right_child === nil
          node.right_child = Node.new(number)
        else
          insert(node.right_child, number)
        end
      end
    end
  
    def delete(node = @root, number)
      return if node == nil # Base case
  
      if node.left_child && node.left_child.data == number
        child_node = node.left_child
        is_left_child_node = true
      elsif node.right_child && node.right_child.data == number
        child_node = node.right_child
        is_left_child_node = false
      end
  
      if child_node != nil
        if child_node.left_child == nil && child_node.right_child == nil
          child_node = nil
        elsif child_node.left_child == nil
          if child_node.right_child == nil
            node.left_child = nil
          else
            child_node = child_node.right_child
          end
        elsif child_node.right_child == nil
          if child_node.left_child == nil
            node.left_child = nil
          else
            child_node = child_node.left_child
          end
        else
          child_node.data = child_node.left_child.data
          child_node.left_child = nil
        end
      else
        delete(node.left_child, number)
        delete(node.right_child, number)
      end
  
      if [true, false].include? is_left_child_node 
          is_left_child_node ? node.left_child = child_node : node.right_child = child_node
      end
    end
  
    def find(node = @root, number)
      return node if node.data == number
  
      if node.left_child && node.left_child.data == number
        node = node.left_child
      elsif node.right_child && node.right_child.data == number
        node = node.right_child
      elsif number < node.data
        find(node.left_child, number)
      else
        find(node.right_child, number)
      end
    end
  
    def level_order(node = @root, level_array = [], queue = [@root])
      return level_array if queue.length < 1
  
      level_array << queue[0].data
  
      if node && node.left_child
        queue << node.left_child
      end
  
      if node && node.right_child
        queue << node.right_child
      end
  
      queue.shift
      node = queue[0]
      level_order(node, level_array, queue)
  
    end
  
    def preorder(node = @root, level_array = [])
      return level_array if node == nil
  
      array << node.data
  
      return level_array if node.left_child == nil && node.right_child == nil
  
      preorder(node.left_child, level_array)
      preorder(node.right_child, level_array)
    end
  
    def inorder(node = @root, level_array = [])
      return level_array if node == nil
  
      inorder(node.left_child, level_array)
      level_array << node.data
      inorder(node.right_child, level_array)
    end
  
    def postorder(node = @root, level_array = [])
      return level_array if node == nil
  
      inorder(node.left_child, level_array)
      inorder(node.right_child, level_array)
      level_array << node.data
    end
  
    def height(node = @root, count = 0)
      return count if node.left_child == nil && node.right_child = nil
  
      count += 1
  
      leaf1 = (height(node.left_child, count) if node.left_child).to_i
      leaf2 = (height(node.right_child, count) if node.right_child).to_i
  
      leaf1 > leaf2 ? leaf1 : leaf2
    end
  
    def depth(node, current_node = @root, count = 0)
      return count if current_node.data == node.data
  
      count += 1
  
      if node.data < current_node.data
        depth(node, current_node.left_child, count)
      else
        depth(node, current_node.right_child, count)
      end
    end
  
    def balanced?
      diff = (height(@root.left_child) - height(@root.right_child)).abs
  
      diff <= 1 ? true : false
    end
  
    def rebalance
        new_array = level_order(@root)
        @root = build_tree(new_array)
    end
  
    def pretty_print(node = @root, prefix="", is_left = true)
      pretty_print(node.right_child, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right_child
      puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
      pretty_print(node.left_child, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left_child
    end
  
  end
  
  test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
  testy = Tree.new(test_array)
class Node
  attr_accessor :name, :parent, :children

  def initialize(name, parent=nil)
    @name = name
    @parent = parent
    @children = []
  end

  def size
    raise NotImplementedError.new 'call size on DirNode or FileNode instance instead'
  end

  def directory?; false; end
  def file?; false; end
end

class DirNode < Node
  def size
    children.map { |node| node.size }.sum # might not work :)
  end

  def to_s
    "DirNode (name: #{name} | parent: #{parent.name rescue 'parentless'} | size: #{size})"
  end

  def directory?; true; end
end

class FileNode < Node
  attr_accessor :size

  def initialize(name, parent, size)
    @size = size
    super(name, parent)
  end

  def to_s
    "FileNode (name: #{name} | parent: #{parent.name rescue 'parentless'} | size: #{size})"
  end

  def file?; true; end
end

input = File.readlines('input').map &:strip
root = DirNode.new('/')
current = root

input.each do |line|
  # parse command
  if line[0] == '$'
    # if cd
    #   change the node we're looking at
    # if ls
    #   nothing :)
    #   we're going to build the tree with
    #   each node we list in ls
    _, command, arg = line.split(' ')
    if command == 'cd'
      if arg == '..'
        current = current.parent
      elsif current.children.empty?
        # stay put
        # we haven't built this part of the tree yet
        # should only happen on the first command ($ cd /)
      else
        current = current.children.find { |node| node.name == arg }
      end
    end
  else
    # build tree from output
    # if dir
    #   add new dir node
    # if num
    #   add new file node
    x, name = line.split(' ')
    if x == 'dir'
      current.children << DirNode.new(name, current)
    else
      size = x.to_i
      current.children << FileNode.new(name, current, size)
    end
  end
end

def directories_of_max_size(node, max_size)
  directories = []
  directories << node if node.size <= max_size
  node.children.filter(&:directory?).each do |child|
    directories += directories_of_max_size(child, max_size)
  end
  directories
end

def directories_of_min_size(node, min_size)
  directories = []
  directories << node if node.size >= min_size
  node.children.filter(&:directory?).each do |child|
    directories += directories_of_min_size(child, min_size)
  end
  directories
end

# part 1
puts directories_of_max_size(root, 100000).map(&:size).sum

DISK_SPACE = 70000000
SPACE_NEEDED = 30000000

directory_size = root.size
target_disk_space = SPACE_NEEDED - (DISK_SPACE - directory_size)

puts directories_of_min_size(root, target_disk_space).map(&:size).sort.first

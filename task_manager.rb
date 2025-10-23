require 'json'

FILE_PATH = 'tasks.json'

# Read the JSON
def load_tasks
  if File.exist?(FILE_PATH)
    JSON.parse(File.read(FILE_PATH))
  else
    []
  end
end

# Save a task
def save_tasks(tasks)
  File.write(FILE_PATH, JSON.pretty_generate(tasks))
end

# Task List
def list_tasks(tasks)
  if tasks.empty?
    puts "No tasks found."
  else
    tasks.each_with_index do |task, index|
      status = task['done'] ? '[X]' : '[ ]'
      puts "#{index + 1}. #{status} #{task['title']}"
    end
  end
end

# Add New Task
def add_task(tasks)
  print "Enter task title: "
  title = gets.chomp
  task = { 'title' => title, 'done' => false }
  tasks << task
  save_tasks(tasks)
  puts "Task added!"
end

# Mark Task as Done
def complete_task(tasks)
  list_tasks(tasks)
  print "Enter the number of the task to mark as done: "
  index = gets.chomp.to_i - 1
  if tasks[index]
    tasks[index]['done'] = true
    save_tasks(tasks)
    puts "Task marked as done!"
  else
    puts "Invalid task number."
  end
end

# Delete Task
def delete_task(tasks)
  print "Enter the number of the task to delete: "  
      index = gets.chomp.to_i - 1
  if index.between?(0, tasks.length - 1)
    removed = tasks.delete_at(index)
    save_tasks(tasks)
    puts "Task deleted: #{removed['title']}"
  else
    puts "Invalid task number."
  end
end

# Main Menu
tasks = load_tasks
loop do
  puts "\nTask Manager"
  puts "1. List tasks"
  puts "2. Add task"
  puts "3. Complete task"
  puts "4. Delete task"
  puts "5. Exit"
  print "Choose an option: "
  
  choice = gets.chomp

  case choice
  when "1"
    list_tasks(tasks)
  when "2"
    add_task(tasks)
  when "3"
    complete_task(tasks)
  when "4"
    delete_task(tasks)
  when "5"
    puts "Bye!"
    break
  else
    puts "Invalid option. Try again."
  end
end

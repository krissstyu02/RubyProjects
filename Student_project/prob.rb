require 'mysql2'

# Создаем соединение с базой данных
client = Mysql2::Client.new(
  :host => 'localhost',
  :username => 'root',
  :password => 'Kris110902Star',
  :database => 'student_db'
)

# Выполняем SELECT-запрос
results = client.query('SELECT * FROM students')

# Выводим результаты на экран
results.each do |row|
  puts row.inspect
end



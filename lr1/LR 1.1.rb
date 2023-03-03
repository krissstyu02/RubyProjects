#1
puts "Hello world!!!!"

#2
user_name = ARGV[0]
puts "Привет.Как тебя зовут?, #{user_name}"
input = STDIN.gets
name = input.chomp
puts "#{name}, какой твой любимый язык?"

lang = STDIN.gets.chomp
case lang
when "ruby","Ruby"
  puts "Ты подлиза!"
when "python","Python"
  puts "Уважаю"
when "c++","C++"
  puts "Привет,первокурсник"
when "F#","f#"
  puts "Чувствую тебе понравится Ruby!"
else
  puts "Скоро будет ruby.."
end

#3
puts "#{name},Еще раз привет!Введи команду ruby))"
rcommand = STDIN.gets.chomp
system "ruby -e \"#{rcommand}\""
puts "#{name}, Чтоб ты не скучал введи мне еще команду ОС"
oscommand = STDIN.gets.chomp
system "#{oscommand}"
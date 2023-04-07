class Bird
  def initialize
    @is_alive = true
  end

  def walk
    puts "I'm walking."
  end
end

class Flyer
  def fly
    puts "I'm flying!"
  end
end

class Eagle
  def initialize
    @bird = Bird.new
    @flyer = Flyer.new
  end

  def do_something
    if @bird.is_alive
      @flyer.fly
    else
      puts "I'm dead."
    end
  end
end

class Penguin
  def initialize
    @bird = Bird.new
  end

  def do_something
    if @bird.is_alive
      @bird.walk
    else
      puts "I'm dead."
    end
  end
end
# frozen_string_literal: true


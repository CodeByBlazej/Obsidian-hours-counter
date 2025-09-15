require "date"

class HourCounter

  def initialize
    @date_from = nil
    @date_to = nil 
    @all_hours = 0
    @all_minutes = 0
    @final_hours = 0
    @final_minutes = 0
  end

  BASE_DIR  = "C:/Users/HP/Desktop/Coding Journey/All Daily Notes" # <-- change me
  DATE_FMT  = "%d-%m-%Y"

  def start
    dates_from
    date_to
    scan
    count_time
    display
  end

  def dates_from
    puts "Type starting day"
    day = gets.chomp

    puts "Type starting month"
    month = gets.chomp

    puts "Type starting year"
    year = gets.chomp

    @date_from = "#{day}-#{month}-#{year}"
  end

  def date_to
    puts "Type ending day"
    day = gets.chomp

    puts "Type ending month"
    month = gets.chomp

    puts "Type ending year"
    year = gets.chomp

    @date_to = "#{day}-#{month}-#{year}"
  end

  def scan
    (@date_from..@date_to).each do |date|
      filename = "#{date.strftime(DATE_FMT)}.md"
      path = File.join(BASE_DIR, filename)

      unless File.file?(path)
        warn "Missing file: #{filename}"
        next
      end

      first_line = File.open(path, &:gets).to_s.strip
      hours, minutes = parse_hours_minutes(first_line)

      if hours.nil?
        warn "Unrecognized first line in #{filename}: #{first_line.inspect}"
      else
        @all_hours += hours
        @all_minutes += minutes
      end
    end
  end

  def count_time
    total_minutes = (@all_hours || 0) * 60 + (@all_minutes || 0)

    hours, minutes = total_minutes.divmod(60)

    @final_hours = hours
    @final_minutes = minutes
  end

  def display
    puts "#{@final_hours} hours and #{@final_minutes}"
  end

  private

  def parse_hours_minutes(line)
    text = line.strip

    h = text[/(\d+)\s*(?:h|hr|hrs|hour|hours)\b/i, 1]&.to_i
    m = text[/(\d+)\s*(?:m|min|mins|minute|minutes)\b/i, 1]&.to_i

    if h || md
      return [h || 0, m || 0]
    end


  end

end

# 1st class to call all other classes
# 2nd class to ask player for dates FROM, TO
# 3rd class to actually loop throught particular
# files and create variables and close file
# 4th class to count all minutes from variables
# and give result
# 

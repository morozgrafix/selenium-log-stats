require 'terminal-table'

# Simple Selenium Log Parser to get stats and metrics output in a nice way.
class SeleniumLogParser
  # Regexp to match things in the Selenium Log
  REGEXP = /\[(\d+.\d+)\]\[.*\]: (COMMAND|RESPONSE) *(\w*) */

  def initialize(path)
    fail ArgumentError unless File.exist?(path)
    @log = File.open(path)
  end

  def stats
    @commands = {}
    rows = []
    total_run_time = 0.0
    @log.each_line do |line|
      match = line.match(REGEXP)

      next unless match
      # puts "#{match[1]} - #{match[2]} - #{match[3]}"

      case match[2]
      when 'COMMAND'
        @preint = match[1].to_f if @log.lineno == 1
        @commands[match[3]] = [] unless @commands.key?(match[3])
        @time_start = match[1].to_f
        time_btw_commands
      when 'RESPONSE'
        @time_end = match[1].to_f
        time_diff = @time_end - @time_start
        # puts "#{@log.lineno} - #{match[1]} - #{match[3]} -> "\
        #   "#{@time_start}:#{@time_end} -> #{time_diff.round(3)}"
        @commands[match[3]] << time_diff
      end
    end

    # need to get total_run_time
    @commands.each { |_name, timings| total_run_time += sum(timings) }

    @commands.each do |name, timings|
      row_data = [name, \
                  timings.length, \
                  format('%3.3f', timings.min), \
                  format('%3.3f', timings.max), \
                  format('%3.3f', mean(timings)), \
                  format('%3.3f', sum(timings)), \
                  format('%3.3f%', percentage(sum(timings), total_run_time))
                 ]

      rows << row_data
    end

    table = Terminal::Table.new(
      headings: %w(Command Count Min(s) Max(s) Avg(s) Total(s) Total(%)),
      rows: rows
    )

    # no good way to align entire table, doing it for all rows starting from 2nd
    (2..table.number_of_columns).each do |col|
      table.align_column(col - 1, :right)
    end

    puts table

    puts "#{@commands.length} unique commands took #{total_run_time.round(3)} "\
      "seconds plus #{@preint} seconds of pre start, totalling " \
      "#{(total_run_time + @preint).round(3)} seconds to execute"

    puts 'Note: BetweenCommands is time spent when one command has finished '\
      "and another hasn't started\n" \
      'ClickElement command may include page navigation time if click triggers'\
       'browser navigation'
  end

  private

  def time_btw_commands
    if !@time_end.nil? && @time_start >= @time_end
      unless @commands.key?('BetweenCommands*')
        @commands['BetweenCommands*'] = []
      end
      time_diff = @time_start - @time_end
      @commands['BetweenCommands*'] << time_diff
    end
  end

  def mean(arr)
    sum(arr) / arr.size
  end

  def sum(arr)
    arr.inject(0.0) { |a, e| a + e }
  end

  def percentage(part, total)
    part.to_f / total.to_f * 100
  end
end

parser = SeleniumLogParser.new(*ARGV)

parser.stats { |l| puts l }

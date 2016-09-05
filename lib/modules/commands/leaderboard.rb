module DrawBot
  module DiscordCommands
    # View the Bank leaderboard!
    module Leaderboard
      extend Discordrb::Commands::CommandContainer
      command :leaderboard do |event|
        break unless event.user.id == CONFIG.owner
        place = 0
        stats = Database::Bank.all
                              .map(&:stats)
                              .sort_by { |s| s[:total] }
                              .reverse
                              .collect do |s|
                                place += 1
                                [
                                  place,
                                  s[:owner],
                                  s[:hearts],
                                  s[:salt],
                                  s[:total]
                                ]
                              end
        stats = stats.take 10
        headings = [
          '#',
          'Name',
          'Hearts',
          'Salt',
          'Total'
        ]
        table = Terminal::Table.new(rows: stats,
                                    headings: headings)
        event << '```hs'
        event << table
        event << '```'
      end
    end
  end
end

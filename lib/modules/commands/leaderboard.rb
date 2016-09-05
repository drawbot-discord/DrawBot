module DrawBot
  module DiscordCommands
    # View the Bank leaderboard!
    module Leaderboard
      extend Discordrb::Commands::CommandContainer
      command :leaderboard do |event, kind|
        break unless event.user.id == CONFIG.owner
        kind ||= :total
        kind = if [:hearts, :salt, :total].include? kind.to_sym
                 event << "**DrawBot Leaderboard** sorted by: `#{kind}`"
                 kind.to_sym
               else
                 event << '**DrawBot Leaderboard** sorted by: `total`'
                 :total
               end
        place = 0
        stats = Database::Bank.all
                              .map(&:stats)
                              .sort_by { |s| s[kind] }
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

module References

bot.command(:r,
            description: 'Lists artistic reference galleries',
            usage: '~references (topic)') do |event, *args|
  args = args.join(' ')
  unless args.empty?
    #finds the ref listed with the arg you use
    ref = $db['refs'].find { |r| r['title'].casecmp(args).zero? }
    unless ref.nil?
      event << "#{ref['title']}"
      event << "#{ref['url']}"
      return
    end
    event << 'I couldn\'t find that reference..'
  end
  #this is for when you don't have arguments, to find the list of refs
  event << 'List of available references:'
  event << $db['refs'].collect { |r| "`#{r['title']}`" }.join(', ')
  end
end

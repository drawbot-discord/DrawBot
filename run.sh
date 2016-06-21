while true
do
    echo "starting DrawBot.."
    echo "updating from repo"
    git pull
    ruby drawbot.rb 
done
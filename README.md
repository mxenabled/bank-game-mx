## Bank! (AI competition)

Bank is a fun dice game. If you've never played it then watch the [video](https://www.youtube.com/watch?v=KuXX9qmcIro). This program is designed to automate the game process programmatically and allow others to come up with a strategy and write it into code and compete against other people's strategies to see who has the best strategy. An example of a very simple strategy would be: If the dice has been rolled 5 times then call "Bank" (cash out). This is the strategy of player `dummy` that you can view in `players/dummy.rb` as an example of how to start writing your own strategy.

### Write your own strategy
To write your own strategy all you need to do is follow the pattern of the `dummy.rb` file in the `/players` directory. It's important that your class name and file name are the same. When the game runs it will automatically load all the strategies from the `/players` directory and make them compete against each other, so you don't need to worry about changing any code anywhere else.

### Run the game
You can run the game via bash with `./play.sh` or `ruby bank.rb`.

### The data
You can run any number of games in a series and it will calculate the win rate, score($$) at the end of the game, and the average placement_score which is calculated by how well you placed on the leaderboard (higher is better). See `bank.rb` to see how to run a GameSeries.

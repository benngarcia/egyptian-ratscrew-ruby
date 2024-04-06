# Egyptian Rafter Game Simulation

## Setup Instructions

To simulate new strategies in the Egyptian Rafter game, follow these steps:

1. **Clone the repository**
2. Run `bundle install` to install the required dependencies.

## Running the Simulation

To run the simulation, use the following rake task with your desired options:

```bash
rake game:simulate [options]
```

### Options

- `--playercount=[num players]`: Specify the number of players in the game.
- `--probablistic=[true|false]`: Enable or disable probabilistic game behavior.
- `--specialplayers=[list of players]`: Provide a comma-separated list of special players (no spaces). See the list of available special players below.
- `--gameiterations=[numgames]` *(optional)*: Set the number of game iterations. Default is 100,000.
- `--winpercentage=[0-100]` *(optional)*: Set the win percentage threshold. Default is 75, only relevant if `probablistic=true`.
- `--burnamount=[numcardstoburn]` *(optional)*: Specify the number of cards to burn. Default is 1.

### List of Available Special Players

1. `Strategies::QUALITATIVE::ALL_FACES`: Slap on every card played after any face card is played.
2. `Strategies::QUALITATIVE::JACK_THROUGH_KING`: Slap on every card played after J-K is played.
3. `Strategies::QUANTITATIVE::TWOCARD`: Slap on every card after 2 cards have been played.
4. `Strategies::QUANTITATIVE::THREECARD`: Slap on every card after 3 cards have been played.
5. `Strategies::QUANTITATIVE::FOURCARD`
6. `Strategies::QUANTITATIVE::FIVECARD`
7. `Strategies::QUANTITATIVE::SIXCARD`

*Note: The difference in `--playercount` and number of special players listed will be filled in with reflexive players.*

### Example Command

```bash
rake game:simulate -- --playercount=4 --probablistic=true --specialplayers=Strategies::QUALITATIVE::ALL_FACES,Strategies::QUANTITATIVE::THREECARD --gameiterations=100 --winpercentage=90 --burnamount=2
```

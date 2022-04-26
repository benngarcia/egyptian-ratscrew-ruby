Egyptian Rafter game in Ruby. Used for simulating new strategies. If you'd like to implement a new strategy - dm me on twitter
To run:

1. Clone
2. bundle install

run rake game:simulate [options]

options: 
  --playercount=num players 
  
  --probablistic=true or false
  
  --specialplayers=comma-seperated (no spaces) list of players (list of available special players below)
  
  --gameiterations=numgames *optional (default 100,000)
  
  --winpercentage=0-100 *optional (default 75, only relevant if probabilistic=true)
  
  --burnamount=numcardstoburn *optional (default 1)
 
 
 List of available players
  1. Strategies::QUALITATIVE::ALL_FACES
  2. Strategies::QUALITATIVE::JACK_THROUGH_KING
  3. Strategies::QUANTITATIVE::TWOCARD
  4. Strategies::QUANTITATIVE::THREECARD
  5. Strategies::QUANTITATIVE::FOURCARD
  6. Strategies::QUANTITATIVE::FIVECARD
  7. Strategies::QUANTITATIVE::SIXCARD
  * Note - The difference in --playercount and number of special players listed will be filled in with reflexive players
   
example command
  ```
  rake game:simulate -- --playercount=4 --probablistic=true --specialplayers=Strategies::QUALITATIVE::ALL_FACES,Strategies::QUANTITATIVE::THREECARD --gameiterations=100 --winpercentage=90 --burnamount=2
  ```

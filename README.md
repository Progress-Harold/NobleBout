# NobleBout
Noble Bout is a Rock, Paper, Scissors based fighting game.

### For code changes:
(For full details on this see our [Engineering Docs](https://noblesword.atlassian.net/wiki/spaces/NO/pages/2228225/Engineering+Guidelines#3.-Create-a-new-branch.).
- Create your branch using the Jira card number and your name like harold/NB2-49 using git checkout -b <branch_name_here>. That way on git the we can search through each other changes quickly.

Example:

```
git checkout harold/NB2-49
```

## Commit your changes.
Committing changes means you are saving your changes with a comment. This helps us keep track of what changes happened where… Plus you have to commit your changes in order to push your branch up to the server for an eventual code review.

### The command is git commit
There are two ways to commit your changes:
- One is with one line in the Terminal using `-m` after the command followed by a messes in quotes `"”`.

### Example:
The commit message should have the Jira card number NB2-## then followed by a description of what your change was preferably one sentence… or even just the title of the card.

```
git commit -m "NB2-55-EngineeringDocsAdded"
```

- The other is just typing `git commit` then you will be in what we call the Visual Editor within the `Terminal` app.
  - To start typing a message type `i` on your keyboard. Then type what you want.
  - To cancel or NOT save (commit) this message and the work just type `:q!`. That will quit and get you out of the visual editor.
  - To save your message just type`:wq`. That stands for “write“ and “quit“.
  
  
# Prototype Known Bugs:

- When a choice is made the label the reslt is calculated and the label updates
- When the timer is up if the choices cause a draw, then the game will no longer function.
    - Expected: that the timer will run again like normal.
-  Restart button is not tapable at all times 
-  Title screen button is not tapable at all times

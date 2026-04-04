<p align="center">
<img width="700" height="333" alt="logo_sm" src="https://github.com/user-attachments/assets/73afbd62-fc3c-4bc9-aeba-0bb69d3584c7" />
<br/><strong>Your AI CLI helper a keystroke away</strong>
</p>

**Zummoner**, part of the [DAY50](https://day50.dev) suite of open-source tools for AI workflows, allows you to describe the command you wish to run, in whole or in part, at the command line, in English, and then have it get swapped out with the actual command. You can edit and modify it before invoking.

It can use any model and any endpoint, including local.

![zummoner](https://github.com/user-attachments/assets/f639fa9c-a28c-41a1-9d1a-f6ff7faab15e)

**You Use Bash?** No Problem! `Bummoner.bash` works the same as `Zummoner.zsh`. It's right here in the repo. Clone away!


## Features

* **Command Conjuration:** Describe your task in plain English, and Zummoner generates the command. ✨
* **System Aware:** Knows your system (`uname -a`) and user for tailored spells. 🤖
* **Modern Magic:** Prefers modern tools like `homectl`, `ip`, `systemctl`, and `journalctl`. 🚀
* **Customizable LLM:** Pick your favorite LLM model, even local. 🧠
* **Seamless Integration:** Works directly within your Zsh shell. 🐚

## Installation
You can zplug, zinit, zgen it ... it's the right format or manually:

   ```bash
   git clone https://github.com/day50-dev/zummoner.git $HOME/.local/zummoner
   echo source \$HOME/.local/zummoner/zummoner.zsh >> $HOME/.zshrc
   source $HOME/.zshrc
   
   ```

**Keybinding:**  Zummoner uses `^Xx` (Ctrl+x, then x) by default.  It'll let you know if that key is already taken!

## Usage

1. Type what you want to do (e.g., "list all files in the current directory sorted by size").
2. Press `^Xx`.
3. Zummoner will show the command!
4. Press Enter to execute. 💥

## Incremental Spellcasting

Set the variable before inclusion!
```bash
ZUMMONER_SPELL=1
```
And you will get commented spell casts that you can incrementally modify like below!



## Caveats 

Zummoner can use either [Simon w's llm](https://github.com/simonw/llm) or DAY50's [llcat](https://github.com/day50-dev/llcat).

For `llcat` set the: 
  * model with `LLC_MODEL`
  * server with `LLC_SERVER`
  * key with `LLC_KEY`
  * mcpfile (if you want) with `LLC_MCP`



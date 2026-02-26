
# Zummoner: ✨ The Zsh Spellbook ✨

**Invoke the power of the command line with a whisper!**

Tired of remembering complex commands? 

🧙‍♂️ Zummoner is a Zsh plugin that *summons* the right command for you, using the magic of LLMs. Just describe what you want to do, and Zummoner does the rest!

**You Use Bash?** No Problem! `Bummoner.bash` works the same as `Zummoner.zsh`. It's right here in the repo. Clone away!

![440177965-01488c16-fb68-4fdb-a7ea-76e12499641d](https://github.com/user-attachments/assets/e272d159-66c9-445a-8f82-4f545a5ddae6)


## Features - The Enchantments 🪄

* **Command Conjuration:** Describe your task in plain English, and Zummoner generates the command. ✨
* **System Aware:** Knows your system (`uname -a`) and user for tailored spells. 🤖
* **Modern Magic:** Prefers modern tools like `homectl`, `ip`, `systemctl`, and `journalctl`. 🚀
* **Customizable LLM:** Pick your favorite LLM model, even local. 🧠
* **Seamless Integration:** Works directly within your Zsh shell. 🐚

## Installation - Binding the Spirit 🔗
You can zplug, zinit, zgen it ... it's the right format orrrr manually:

   ```bash
   git clone https://github.com/day50-dev/zummoner.git $HOME/.local/zummoner
   echo source \$HOME/.local/zummoner/zummoner.zsh >> $HOME/.zshrc
   source $HOME/.zshrc
   
   ```

**Keybinding:**  Zummoner uses `^Xx` (Ctrl+x, then x) by default.  It'll let you know if that key is already taken!

## Usage - Uttering the Incantation 🗣️

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

![zummoner](https://github.com/user-attachments/assets/f639fa9c-a28c-41a1-9d1a-f6ff7faab15e)

## Caveats - A Little Magic Caution ⚠️

Zummoner can use either [Simon w's llm](https://github.com/simonw/llm), [LMStudio](https://lmstudio.ai/), or DAY50's [llcat](https://github.com/day50-dev/llcat).

For `llcat` set the:
  * model with `LLC_MODEL`
  * server with `LLC_SERVER`
  * key with `LLC_KEY`
  * mcpfile (if you want) with `LLC_MCP`

For LMStudio, set the model with `LMS_MODEL` (optional - defaults to first available model):
  ```bash
  LMS_MODEL="local-model-name"
  ```

### Backend Selection

By default, Zummoner auto-detects backends in priority order: llcat > lms > llm. You can override this:

  ```bash
  ZUMMONER_BACKEND=auto    # Auto-detect (default)
  ZUMMONER_BACKEND=llcat   # Force llcat
  ZUMMONER_BACKEND=llm     # Force Simonw's llm
  ZUMMONER_BACKEND=lms     # Force LMStudio CLI
  ```


There's also bummoner.sh in here which is the bash version of zummoner.

## The future!

This project was a prototype [for something much more ambitious](https://news.ycombinator.com/item?id=44112949) of what is now called [ono](https://onolang.com/).


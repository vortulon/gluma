# gluma
simple, minimal and easy to use lua based text editor

## installation

### what you need

- **lua** get it from ur package manager or from luas website

### steps

1. **download**:  
   - copy the `gluma.lua` script from this repository or create a new file and paste the provided code into it.  

2. **make the script executable**:  
   - run the following command to make the script executable:  
     ```bash  
     chmod +x gluma.lua  
     ```  

3. **run gluma**:  
     ```bash  
     lua gluma.lua  
     ```  

4. **optional: add to path**:  
   - to use gluma from anywhere, move it to a directory in your path (e.g., `/usr/local/bin`):  
     ```bash  
     sudo mv gluma.lua /usr/local/bin/gluma  
     ```  
   - now you can run it simply by typing `gluma` in your terminal.
   - havent tested gluma in macos or windows so let me know if it doesnt work
---
### commands (:h)

| Command       | Description                                      |
|---------------|--------------------------------------------------|
| `:q`          | Quit the editor (prompts to save if modified).   |
| `:w`          | Save the file.                                   |
| `:w <file>`   | Save the file with a new name.                   |
| `:l`          | List all lines.                                  |
| `:l N`        | List line N.                                     |
| `:l N-M`      | List lines N to M.                               |
| `:e N <text>` | Edit line N with the provided text.              |
| `:i N <text>` | Insert text at line N.                           |
| `:d N`        | Delete line N.                                   |
| `:d N-M`      | Delete lines N to M.                             |
| `:h`          | Show the help screen.                            |

---

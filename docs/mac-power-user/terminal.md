# Terminal Basics

## 10 Essential Commands

1. **`ls -lA`:** List all files including hidden ones (but excluding `.` and `..`) with permissions, ownership, size, and modification date. `-A` shows dotfiles without the redundant current and parent directory entries that `-a` includes.

2. **`cd`:** Change directory. `cd ~` goes home, `cd -` returns to the previous directory, `cd ..` goes up one level.

3. **`pwd`:** Print working directory. Shows the absolute path of the current location in the file system.

4. **`mkdir -p`:** Create a directory and any missing parent directories in one command. `mkdir -p a/b/c` creates all three levels at once.

5. **`cp -r`:** Copy files or directories recursively. `-r` is required for directories.

6. **`mv`:** Move or rename files and directories. `mv old.txt new.txt` renames, `mv file.txt ~/Documents/` moves.

7. **`rm -rf`:** Remove files and directories recursively and forcefully. No confirmation, no Trash, hence permanent. Use with care.

8. **`find . -name "*.md"`:** Recursively search for files matching a pattern from the current directory. Supports filters by type, size, modification date, and more.

9. **`grep -r "pattern" .`:** Recursively search file contents for a pattern. `-i` for case-insensitive, `-n` to show line numbers, `-l` to show only filenames.

10. **`chmod +x`:** Make a file executable. Essential for shell scripts before they can be run directly.

## Terminal-Created Folder Structure

![Terminal Folder Structure](../../assets/onboarding/Screenshot%202026-05-29%20at%202.42.45 AM.png)

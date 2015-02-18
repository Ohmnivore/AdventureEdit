# AdventureEdit
AdventureEdit is a 2D sprite-based editor I'm writing for a game I'm working on. The game in question doesn't use tiles,
just sprites, so I tried the GLEE2D editor. Unfortunately it generates very bulky XML files, and lacks something akin to
Ogmo's entity system. To me, AdventureEdit is a clone of Ogmo Editor (in terms of functionality) adapted to sprite-based games. It combines Ogmo's entity system with a quick and intuitive image system. The UI is also very similar to Ogmo's.

# Should you use this?
Use at your own risk. The UI, while generally mimicking Ogmo Editor, differs in many places. It might also sometimes be unintuitive. Furthermore, AdventureEdit is pretty young so bugs are to be expected. I will soon provide Windows and maybe even Linux binaries, but you can easily compile the project yourself for Windows, Linux, and Mac targets. Compilation requires the dev version of flixel, flixel-ui, and flixel-addons, as well as systools.

# TODO
* Relative paths for saving image paths
* Custom fields for entities in EditProj
* Rectangle entities
* Layer visibility
* Undo
* Redo
* Nodes

# Features that may be added in the future
* Sprite color tinting
* Set sprite origin
* Roatate sprite
* Flip sprite vertically and/or horizontally

# Keyboard shortcuts
| Name                  | Keys                       |
|-----------------------|----------------------------|
| **Tools**             |                            |
| Add tool              | 1                          |
| Remove tool           | 2                          |
| Select tool           | 3                          |
| Move tool             | 4                          |
| **Level**             |                            |
| Edit level properties | Ctrl+l                     |
| New level             | Ctrl+n                     |
| Open level            | Ctrl+o                     |
| Save level            | Ctrl+s                     |
| Save level as         | Ctrl+Shift+s               |
| Close level           | Ctrl+w                     |
| **Edit**              |                            |
| Undo                  | Ctrl+z                     |
| Redo                  | Ctrl+y                     |
| Cut                   | Ctrl+x                     |
| Copy                  | Ctrl+c                     |
| Paste                 | Ctrl+v                     |
| Select all            | Ctrl+a                     |
| Deselect all          | Ctrl+d                     |
| **View**              |                            |
| Toggle grid           | Ctrl+g                     |
| Center view           | Ctrl+Tab                   |
| Move view             | Hold spacebar + move mouse |
| Zoom in               | Mouse wheel                |
| Zoom out              | Mouse wheel                |

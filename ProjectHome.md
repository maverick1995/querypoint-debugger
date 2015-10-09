Querypoint debugging applies dynamic code analysis with user-interaction to debug code without requiring breakpoints or log statements. For example, the developer asks for the last change of an object property and re-executes the code: the querypoint debugger gives the line and value of the last change.

This project creates an installable Chrome browse extension from these projects:
  * [devtoolsExtended](https://github.com/google/devtoolsExtended), a fork of Chrome devtools aka WebInspector,
  * [qpp](https://github.com/google/qpp), a devtoolsExtended extension implementing Querypoint debugging,
  * [johnjbarton-devtools-save](https://code.google.com/r/johnjbarton-devtools-save/), a fork of devtools-save for saving edits made under devtools.

[Downloads](https://code.google.com/p/querypoint-debugger/downloads/list) from this project act like a 'dev' channel for the Querypoint debugger project: weekly updates for the extension hosted in the Chrome Web Store.
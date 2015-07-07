# Kanban

Initially based on the simple Kanban example from the ActionScript Developer's Guide to Robotlegs
by Joel Hooks

it is now a strongly extended versions with some useful functionality.

####Some features are
* Multiple boards
* Categories for each board (which defines name and color for the postIts)
* Add/delete columns for each board.
* Update maxItems for columns
* Drag postIts to another board
* Deleting a column moves the tasks inside to the backlog.
* Deleting a category gives the tasks back the default color/category

etc.

It uses Flex SDK 4.14.1 and Robotlegs v 2.1

PinIcons by http://www.fuzzimo.com/free-vector-post-it-notes-push-pins/

It uses a local sqlite db, there is no remote db connection or cloud service in the moment.

Some dependencies for some skins and components with:
(https://github.com/MichaPau/Flex-lib)

Screenshot:

<img src='https://github.com/MichaPau/Kanban/blob/master/docs/img/screenshot_01.png'/>



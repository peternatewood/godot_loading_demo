# Godot Loading Demo

My attempt to implement the interactive loader in Godot 3. Currently, this does not work properly if any scripts in the scene reference other nodes. It seems that once a node is loaded, the `_ready` method triggers immediately, whether the rest of the scene is loaded or not.

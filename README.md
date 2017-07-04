# Flipbook Surface Shader for Unity

![](http://i.imgur.com/ezGY1yf.gif)

This is a surface shader solution for flipbook animation with spritesheets in Unity. I've been using this so that I can add shadows to flipbook animations without going through Unity's sprite system. 

Setup is relatively simple:
1. Create a spritesheet with even spacing between sprites. For my spritesheets I've been using: https://www.johnwordsworth.com/projects/photoshop-sprite-sheet-generator-script/ and generating source sprite images in 3d Studio MAX. This makes it especially easy to get normal information for renderings. 
2. Plug in your spritesheets to a new material with Custom/SurfaceSpriteSheet
3. Set the number of rows / columns and then the number of overall frames.
    --- I count the number of overall frames in case of incomplete rows ---
4. Set it loose! You can use the animator to set the frame number over time or make it loop using the built in animation speed variable! 

Improvements / suggestions for other variations:

For foliage -- blend the bottom of the geometry with the ground by orienting the normals to the surface. This is easiest for flat surfaces with which you can just set the normals to point upward in a vertex shader.

Try implimenting billboarding -- In the past I've used this solution to good effect: https://gist.github.com/renaudbedard/7a90ec4a5a7359712202, note that it won't batch correctly out of the box. 

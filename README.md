![](title.jpg)


# Fire Glow for Defold

A shader to create a magical glow that you can use in your games, for example to highlight objects or GUI elements, and to create a portal effect.

Based on: [https://www.shadertoy.com/view/4dSfDK](https://www.shadertoy.com/view/4dSfDK)

## Setup

### Dependency

To integrate the **Fire Glow** extension into your own project, add this project as a [dependency](https://www.defold.com/manuals/libraries/) in your **Defold** game. Open your `game.project` file and add the following line to the dependencies field under the project section:

> [https://github.com/ufgo/fire_glow/archive/master.zip](https://github.com/ufgo/fire_glow/archive/master.zip)  


### Shader parameters
**fire_params:**  
fire_params.x = 1.0 - standard fire size  
fire_params.x > 1.0 - larger fire  
fire_params.x < 1.0 - smaller fire  
fire_params.y = 1.0 - standard line thickness  
fire_params.y > 1.0 - thicker lines  
fire_params.y < 1.0 - thinner lines  
fire_params.z = 1.0 - standard red/orange colour  
fire_params.z > 1.0 - red/orange enhancement  
fire_params.z < 1.0 - red/orange weakening  
fire_params.w = 1.0 - standard blue component  
fire_params.w > 1.0 - more blue fire  
fire_params.w < 1.0 - less blue fire  

**rect_params:**   
rect_params.x -  width  
rect_params.y -  height  
rect_params.z - corner radius  


### Online demo [here](https://on.itch.io/fire-glow)

### Note: 
This shader does not work on the mobile version of HTML5. If you know how to fix it, please submit a pull request.

## License
![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png)

# XPS_A3
eXtensible Project System for Arma 3
 
An Arma 3 Framework Mod

[ [Road Map](https://xps-group.notion.site/6182e1ad293b4572bec60726a997e279?v=58732b82ad9f4ea2a6e86446ea4031fd&pvs=4) ] 
[ [Wiki](https://xps-group.notion.site/0f5270147d434c9387d49a3b16311a75?v=6b8b37e55002438893964177eec15bca&pvs=4) ] 
[ [Discord](https://discord.gg/ryXZjDY7En) ] 
[ [Source Documentation](https://xps-group.github.io/) ] 

### UPDATE Oct 2023 - 2.14 has been released to stable branch for some time now, yet some bugs in the createhashmapobject command exist
  - #base is limited to only Arrays as passing a Hashmap causes a CTD
  - #create fails to properly assign _self variable in a scheduled environment (works fine if called unscheduled via #flags or in unscheduled environment)

## Features:
  - Bring an Object-Oriented Structure to your Mod
    - Interface Contracts
    - Type Definition Preprocessor
    - Type Definition Caching Support
    - Optional Unit Testing framework
    - Singleton / Static type creation
    - Common Core Object Libraries
  - Use Built-in library types for common utiltiies
    - A* Searching
    - Job Scheduling
    - Collections
    - Delegates and Multicast Delegates
    
    WIP Library Objects :
    - Map and Road Pathfinding
    - Hex Grids

  AI Features  
  - Add Behaviour Trees to AI (AI Entities or 'behind-the-scenes' Scripted AI)
  - WIP - Use Action Planning / Utility AI for short or long term planning
  - WIP - Replace the Danger/Formation FSM behaviors

#History
This project started as the eXtensible Planning System - a mod to introduce Behaviour Trees, Utility AI, and Goal-Oriented Action Planning. I was using Hashmaps to create
a simple OO-design prior to the introduction of HashmapObjects.

Since the announcement to introduce a new hashmap command 'createHashmapObject' for v2.14, this project has been rewritten to include additional features to the framework:
  - A better and standardized OOP approach (an example is to include an Interface-style contract system for building objects) and a general framework to foster Mod compatibility at the scripting level using those objects.

 
Ultimately, it is my hope and goal to provide more creativity in the community. All constructive criticism and ideas are welcome here.
 
 -Crashdome

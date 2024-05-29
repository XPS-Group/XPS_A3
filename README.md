# XPS_A3
eXtensible Project System for Arma 3
 
An Arma 3 Framework Mod
 - For users: the base of many XPS mods to come
 - For Developers: an extensible platform and library set to reduce the time to develop common OOP objects

[ [Road Map](https://xps-group.notion.site/6182e1ad293b4572bec60726a997e279?v=58732b82ad9f4ea2a6e86446ea4031fd&pvs=4) ] 
[ [Wiki](https://xps-group.notion.site/0f5270147d434c9387d49a3b16311a75?v=6b8b37e55002438893964177eec15bca&pvs=4) ] 
[ [Discord](https://discord.gg/ryXZjDY7En) ] 
[ [Source Documentation](https://xps-group.github.io/) ] 

## Features:
  - Bring an Object-Oriented Structure to your Mod
    - Interface Contracts
    - Type Definition Preprocessor
    - Type Definition Caching Support
    - Optional Unit Testing framework
    - Singleton / Static type creation
    - Common Core Object Libraries   
  - Use Built-in OOP library types for common utiltiies
    - A* Searching
    - Job Scheduling
    - Collections
    - Events, Delegates, and Multicast Delegates
    - Type Safe Enumerations
    - Exceptions and Exception Handling
    
  WIP Library Objects :
  - Map and Road Pathfinding
  - Hex or Square Map Grids

  AI Features  
  - Add Behaviour Trees to AI (AI Entities or 'behind-the-scenes' Scripted AI)
  - WIP - Use Action Planning / Utility AI for short or long term planning
  - WIP - Replace the Danger/Formation FSM behaviors

# History
This project started as the eXtensible Planning System - a mod to introduce Behaviour Trees, Utility AI, and Goal-Oriented Action Planning. I was using Hashmaps to create a simple OO-design pattern prior to the introduction of Hashmap Objects.

Since the announcement to introduce a new hashmap command 'createHashmapObject' for v2.14, this project has been rewritten to include additional features to the framework:
  - A Preprocessor and Type Builder to add additional features to hashmap objects.
  - A better and standardized OOP approach (an example is to include an Interface-style contract system for building objects) and a general framework to foster better Mod compatibility at the scripting level when using those objects.
  - Unit Testing UI and framework 

 
Ultimately, it is my hope and goal to provide more creativity in the community. All constructive criticism and ideas are welcome here.
 
 -Crashdome

# License
Copyright (C) 2023  XPS Group 

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.


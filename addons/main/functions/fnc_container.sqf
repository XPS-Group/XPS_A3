#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: xps_fnc_container

Description:
    Creates and returns a new <Container> which breaks down an item into categorical properties.
    Think of it as taking an item such as an array which might be [Name,Type,Value] and seperating
    each element into three lists: [Names], [TypeByName], and [ValueByName]. Useful for quick lookup
    of a single property or value.
    This differs from a <Collection> in that a <Collection> stores a complete item within it.
    Typically in it's [Items] store.

    They are, however, structurally similar as simply a base <HashMap>. It is up to the implementation
    function to treat them as they are so labelled.

Parameters: 
    type - <String> - a unique type label 
    name - <String> - a descriptive name for the container - the shorter the better

Returns: 
    <Container>

Examples:
    --- Code
    _myContainer = call xps_fnc_container;
    ---

Author:
    CrashDome

---------------------------------------------------------------------------- */
if !(params [["_type",nil,[""]],["_name",nil,[""]]]) exitwith {nil;};

createhashmapfromarray [["Type",_type],["Name",_name]];
# Jerializer
 A serialization module in Jai.

A simple module whose main purpose is to experiment with metaprogramming in jai.


## Install
``git submodule add https://github.com/Qwendu/Jerialize.git <your modules folder``
``git submodule update --init --recursive``


## Usage
See example/main.jai for a working example.

### Overview:
to serialize a struct 
``bytes := jerialize(*<struct lvalue here>);``

this returns a string

to deserialize a struct
``dejerialize(*<struct lvalue here>, source = bytes);``

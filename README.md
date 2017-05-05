# Hack Assembler - assembler for Hack assembly language

Hack Assembler is an assembler written in Ruby. This is for Hack assembly language and Hack computer which applies Harvard Architecture.


## Installation

First clone this repository to your local machine:

    $ git clone git@github.com:shuheiktgw/hack_assembler.git


And then execute:

    $ bundle install

## Usage
All you need to do is just run assemble.rb, which is located at the root level of this repository and give it Hack assembly file path.


    $ ruby assemble.rb ~/Desktop/some_assembly.asm

Then it will output the translated file at the same place with `.hack` extension.
 
## Licence
Hack Assembler is distributed under MIT license.

Copyright (c) 2017 Shuhei Kitagawa

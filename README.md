# 6502 Computer

Tools and code for a computer based on the [Ben Eater 6502 Computer Kit](https://eater.net/6502).

## Assembling EEPROM Bin Files

Assembler files can be compiled using [vasm](http://sun.hasenbraten.de/vasm/). Binary files of vasm compiled for Linux, Mac and Windows and set up for the 6502 CPU can be found at <http://sun.hasenbraten.de/vasm/>.

### Compiling vasm from source

Source files for vas can be found at <http://sun.hasenbraten.de/vasm/index.php?view=relsrc>.

``` bash
wget http://sun.hasenbraten.de/vasm/release/vasm.tar.gz
tar xvzf vasm.tar.gz
cd vasm
make CPU=2502 SYNTAX=oldstyle
cp vasm6502_oldstyle /usr/bin
cp vobjdump /usr/bin
```

### Compiling assembler files with vasm

Vasm requires a flag to set the output format. For binary files use `-Fbin`.
To assemble the files in this repository the dotdir syntax has to be enabled with `-dotdir`.
An output filename can be added with the `-o` flag, otherwise the output will be saved as **a.out**.

``` bash
vasm6502_oldstyle -Fbin -dotdir -o binary.out assembler.s
```

Hexdump can be used to check the output file.

``` bash
hexdump -C binary.out
```

## Writing the EEPROM

I have created a (very slow) [EEPROM programmer](https://github.com/lukeshiner/eeprom.git) that can be used to write the **AT28C256 EEPROM** used in the **6502 Computer Kit**.

Note that this is currently very much a work in progress.

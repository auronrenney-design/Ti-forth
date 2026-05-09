# Ti-forth Compiler

A Forth-to-Z80 compiler for the TI-84 Plus (monochrome) that compiles Forth code into continuous hex strings.

## Overview

**Input:** Forth source code in `Str0`  
**Output:** Continuous hex string (Z80 machine code) in `Str1`  
**Language:** TI-BASIC  
**Target:** TI-84 Plus monochrome

### Example

```
Input (Str0):  DUP DROP
Output (Str1): 51D1
```

Each pair of hex digits represents one Z80 machine code byte.

## Architecture

The compiler consists of three main phases:

1. **Tokenizer** - Parse Forth words from input string
2. **Compiler** - Convert tokens to Z80 hex opcodes
3. **Formatter** - Output continuous hex string to Str1

## Supported Forth Words

See `docs/forth-words.md` for the complete list of supported Forth operations and their corresponding Z80 hex opcodes.

## Usage

1. Store your Forth code in `Str0`
2. Run the main compiler program
3. Check output in `Str1`

## File Structure

- `FORTH` - Main compiler program (TI-BASIC)
- `docs/` - Documentation and reference tables
  - `z80-opcodes.md` - Z80 machine code reference
  - `forth-words.md` - Supported Forth words and mappings
  - `ti84-format.md` - TI-84 Plus binary format notes
- `examples/` - Example Forth programs

## Notes

- The stack is implemented on the calculator itself
- Hex output is a continuous string with no separators or formatting

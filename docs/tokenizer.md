# Tokenizer Documentation

## Overview

The tokenizer parses Forth code from `Str0` and splits it into individual words/tokens using the **→ (store)** character as the delimiter.

## Input Format

```
Str0: DUP→DROP→SWAP→2→+
```

## Tokenizer Process

1. **Read** `Str0`
2. **Split** on → character
3. **Trim** whitespace from each token
4. **Store** tokens in a list or process sequentially
5. **Pass** to compiler

## Implementation Strategy (TI-BASIC)

### Option A: Sequential Processing (Memory Efficient)
- Process each token immediately as found
- Convert to hex opcode
- Append to output string `Str1`
- No need to store all tokens

### Option B: Two-Pass (Clearer Logic)
- First pass: Split all tokens into `List1`
- Second pass: Convert each token to hex
- Join results into `Str1`

### Recommended: Option A (Sequential)

Since TI-84 Plus has limited string/list memory, process tokens one-by-one:

```
1. pos ← 1
2. WHILE pos ≤ length(Str0)
3.   Find next → delimiter
4.   Extract token between pos and delimiter
5.   Look up token in dictionary → get hex opcode
6.   Append hex to Str1
7.   Move pos past delimiter
8. END WHILE
```

## Delimiter Handling

- **Delimiter:** → (store character, code: `STO→`)
- **Whitespace:** Trim before and after each token
- **Empty tokens:** Skip (e.g., `DUP→→DROP` results in empty token, ignore)

## Pseudocode

```
Input: Str0 = "DUP→DROP→SWAP"
Output: Str1 = compiled hex string

Position ← 1
Str1 ← ""

WHILE Position ≤ length(Str0)
  nextDelim ← find(→, Str0, Position)
  
  IF nextDelim = 0 THEN
    nextDelim ← length(Str0) + 1
  END IF
  
  token ← mid(Str0, Position, nextDelim - Position)
  token ← trim(token)  // remove spaces
  
  IF token ≠ "" THEN
    hex ← lookup(token)  // get hex from dictionary
    Str1 ← Str1 + hex
  END IF
  
  Position ← nextDelim + 1
END WHILE

DISP Str1
```

## TI-BASIC Implementation Notes

### Finding Delimiter Position
```
inString(Str0, "→", start)  // Returns position or 0 if not found
```

### Extracting Substrings
```
sub(Str0, start, length)    // Extract substring
```

### Trimming Whitespace
```
While sub(token, 1, 1) = " "
  token ← sub(token, 2, length(token)-1)
End
```

## Error Handling

- **Unknown token:** Display error and stop
- **Empty input:** Return empty string
- **Malformed tokens:** Skip or warn user

## Testing Scenarios

| Input | Expected Tokens | Notes |
|-------|-----------------|-------|
| `DUP→DROP` | `["DUP", "DROP"]` | Basic case |
| `DUP → DROP` | `["DUP", "DROP"]` | Spaces around delimiter |
| `DUP→→DROP` | `["DUP", "DROP"]` | Empty token (skip) |
| ` DUP→DROP ` | `["DUP", "DROP"]` | Leading/trailing spaces |
| `DUP` | `["DUP"]` | No delimiter |

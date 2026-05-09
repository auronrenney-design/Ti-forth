prgmFORTH

// Main Forth Compiler Program
// Input: Str0 (Forth code with → delimiters)
// Output: Str1 (Continuous hex string)

ClrHome
Disp "FORTH COMPILER v0.1"
Disp "Input in Str0"
Disp "Output to Str1"
Pause

// Initialize
"" → Str1
1 → P

// Main tokenizer loop
While P ≤ length(Str0)
  inString(Str0, "→", P) → D
  
  If D = 0 Then
    length(Str0) + 1 → D
  End
  
  sub(Str0, P, D - P) → T
  
  // Trim leading spaces
  While length(T) > 0 and sub(T, 1, 1) = " "
    sub(T, 2, length(T) - 1) → T
  End
  
  // Trim trailing spaces
  While length(T) > 0 and sub(T, length(T), 1) = " "
    sub(T, 1, length(T) - 1) → T
  End
  
  // Process non-empty tokens
  If T ≠ "" Then
    T2Hex(T) → H
    
    If H = "ERROR" Then
      ClrHome
      Disp "ERROR: Unknown word"
      Disp T
      Pause
      Stop
    End
    
    Str1 + H → Str1
    Disp T + " → " + H
  End
  
  D + 1 → P
End

ClrHome
Disp "Compilation Complete"
Disp "Result in Str1"
Disp length(Str1) + " hex chars"
Pause
Disp Str1

// ===== HEX LOOKUP FUNCTION =====

Define T2Hex(T$) = 
  If T$ = "DUP" Then
    Return "D1"
  Else If T$ = "DROP" Then
    Return "C1"
  Else If T$ = "SWAP" Then
    Return "D9"
  Else If T$ = "ROT" Then
    Return "E3"
  Else If T$ = "OVER" Then
    Return "F5"
  Else If T$ = "+" Then
    Return "C601"
  Else If T$ = "-" Then
    Return "D601"
  Else If T$ = "*" Then
    Return "CB07"
  Else If T$ = "/" Then
    Return "CB3F"
  Else If T$ = "MOD" Then
    Return "D301"
  Else If T$ = "=" Then
    Return "BD"
  Else If T$ = "<" Then
    Return "B8"
  Else If T$ = ">" Then
    Return "B9"
  Else If T$ = "<=" Then
    Return "BA"
  Else If T$ = ">=" Then
    Return "BB"
  Else If T$ = "@" Then
    Return "3600"
  Else If T$ = "!" Then
    Return "77"
  Else If T$ = "C@" Then
    Return "46"
  Else If T$ = "C!" Then
    Return "70"
  Else If T$ = "0" Then
    Return "AF"
  Else If T$ = "1" Then
    Return "3E01"
  Else If T$ = "-1" Then
    Return "3EFF"
  Else If T$ = "IF" Then
    Return "C2"
  Else If T$ = "THEN" Then
    Return "C3"
  Else If T$ = "BEGIN" Then
    Return "18"
  Else If T$ = "UNTIL" Then
    Return "20"
  Else
    Return "ERROR"
  End
End

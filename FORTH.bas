prgmFORTH

ClrHome
"" → Str1
1 → P
length(Str0) → L

Lbl MAIN
If P > L
  Goto DONE
End

inString(Str0, "→", P) → D
If D = 0
  L + 1 → D
End

sub(Str0, P, D - P) → T

Goto TRIM

Lbl TRIMMED
If T ≠ ""
  Goto LOOKUP
End

Lbl HEXED
D + 1 → P
Goto MAIN

Lbl TRIM
While sub(T, 1, 1) = " "
  sub(T, 2, length(T) - 1) → T
End
While sub(T, length(T), 1) = " "
  sub(T, 1, length(T) - 1) → T
End
Goto TRIMMED

Lbl LOOKUP
"" → H

If T = "DUP"
  "D1" → H
End
If T = "DROP"
  "C1" → H
End
If T = "SWAP"
  "D9" → H
End
If T = "ROT"
  "E3" → H
End
If T = "OVER"
  "F5" → H
End
If T = "+"
  "C601" → H
End
If T = "-"
  "D601" → H
End
If T = "*"
  "CB07" → H
End
If T = "/"
  "CB3F" → H
End
If T = "MOD"
  "D301" → H
End
If T = "="
  "BD" → H
End
If T = "<"
  "B8" → H
End
If T = ">"
  "B9" → H
End
If T = "<="
  "BA" → H
End
If T = ">="
  "BB" → H
End
If T = "@"
  "3600" → H
End
If T = "!"
  "77" → H
End
If T = "C@"
  "46" → H
End
If T = "C!"
  "70" → H
End
If T = "0"
  "AF" → H
End
If T = "1"
  "3E01" → H
End
If T = "-1"
  "3EFF" → H
End
If T = "IF"
  "C2" → H
End
If T = "THEN"
  "C3" → H
End
If T = "BEGIN"
  "18" → H
End
If T = "UNTIL"
  "20" → H
End

If H = ""
  ClrHome
  Disp "ERROR: Unknown"
  Disp T
  Goto END
End

Str1 + H → Str1
Goto HEXED

Lbl DONE
ClrHome
Disp "Result:"
Disp Str1
Pause

Lbl END

;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<user>(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\"(?:(?:[^\"\\\r\n])|(?:\\.))*\"))(?:\.(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\"(?:(?:[^\"\\\r\n])|(?:\\.))*\")))*)@(?<domain>(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\[(?:(?:[^\[\]\\\r\n])|(?:\\.))*\]))(?:\.(?:(?:[^ \t\(\)\<\>@,;\:\\\"\.\[\]\r\n]+)|(?:\[(?:(?:[^\[\]\\\r\n])|(?:\\.))*\])))*)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u008B}\u00A9\x1E\u00AEj\x14^@[]"
(define-fun Witness1 () String (seq.++ "\x8b" (seq.++ "}" (seq.++ "\xa9" (seq.++ "\x1e" (seq.++ "\xae" (seq.++ "j" (seq.++ "\x14" (seq.++ "^" (seq.++ "@" (seq.++ "[" (seq.++ "]" ""))))))))))))
;witness2: "\u00F8\u00E1\x8\u0089.\"\"@\u0098\x1D\u00D6.\u009E"
(define-fun Witness2 () String (seq.++ "\xf8" (seq.++ "\xe1" (seq.++ "\x08" (seq.++ "\x89" (seq.++ "." (seq.++ "\x22" (seq.++ "\x22" (seq.++ "@" (seq.++ "\x98" (seq.++ "\x1d" (seq.++ "\xd6" (seq.++ "." (seq.++ "\x9e" ""))))))))))))))

(assert (= regexA (re.++ (re.++ (re.union (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\xff"))))))))))))) (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "!")(re.union (re.range "#" "[") (re.range "]" "\xff"))))) (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.range "\x22" "\x22")))) (re.* (re.++ (re.range "." ".") (re.union (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\xff"))))))))))))) (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "!")(re.union (re.range "#" "[") (re.range "]" "\xff"))))) (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.range "\x22" "\x22")))))))(re.++ (re.range "@" "@") (re.++ (re.union (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\xff"))))))))))))) (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "Z") (re.range "^" "\xff")))) (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.range "]" "]")))) (re.* (re.++ (re.range "." ".") (re.union (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "!")(re.union (re.range "#" "'")(re.union (re.range "*" "+")(re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "Z") (re.range "^" "\xff"))))))))))))) (re.++ (re.range "[" "[")(re.++ (re.* (re.union (re.union (re.range "\x00" "\x09")(re.union (re.range "\x0b" "\x0c")(re.union (re.range "\x0e" "Z") (re.range "^" "\xff")))) (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.range "]" "]")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

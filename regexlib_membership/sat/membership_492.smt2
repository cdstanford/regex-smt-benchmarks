;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^<\s*(td|TD)\s*(\w|\W)*\s*>(\w|\W)*</(td|TD)>$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<TD\u00A0i\u00B5></TD>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "T" (seq.++ "D" (seq.++ "\xa0" (seq.++ "i" (seq.++ "\xb5" (seq.++ ">" (seq.++ "<" (seq.++ "/" (seq.++ "T" (seq.++ "D" (seq.++ ">" "")))))))))))))
;witness2: "<TD \u0085>\u008A</td>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "T" (seq.++ "D" (seq.++ " " (seq.++ "\x85" (seq.++ ">" (seq.++ "\x8a" (seq.++ "<" (seq.++ "/" (seq.++ "t" (seq.++ "d" (seq.++ ">" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (str.to_re (seq.++ "t" (seq.++ "d" ""))) (str.to_re (seq.++ "T" (seq.++ "D" ""))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.* (re.union (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))) (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range ">" ">")(re.++ (re.* (re.union (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))) (re.union (re.range "\x00" "/")(re.union (re.range ":" "@")(re.union (re.range "[" "^")(re.union (re.range "`" "`")(re.union (re.range "{" "\xa9")(re.union (re.range "\xab" "\xb4")(re.union (re.range "\xb6" "\xb9")(re.union (re.range "\xbb" "\xbf")(re.union (re.range "\xd7" "\xd7") (re.range "\xf7" "\xf7"))))))))))))(re.++ (str.to_re (seq.++ "<" (seq.++ "/" "")))(re.++ (re.union (str.to_re (seq.++ "t" (seq.++ "d" ""))) (str.to_re (seq.++ "T" (seq.++ "D" ""))))(re.++ (re.range ">" ">") (str.to_re "")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

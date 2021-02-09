;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([A-Z][\w\d\.\-]+)(?:(?:\+)([\w\d\.\-]+))?@([A-Z0-9][\w\.-]*[A-Z0-9]\.[A-Z][A-Z\.]*[A-Z])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xE\x16I\x13\u009DBl+7@R99.TM\u00AD"
(define-fun Witness1 () String (seq.++ "\x0e" (seq.++ "\x16" (seq.++ "I" (seq.++ "\x13" (seq.++ "\x9d" (seq.++ "B" (seq.++ "l" (seq.++ "+" (seq.++ "7" (seq.++ "@" (seq.++ "R" (seq.++ "9" (seq.++ "9" (seq.++ "." (seq.++ "T" (seq.++ "M" (seq.++ "\xad" ""))))))))))))))))))
;witness2: "K_\u00B5\u00B5+H\u00AAZ.@UR.V.ZJ"
(define-fun Witness2 () String (seq.++ "K" (seq.++ "_" (seq.++ "\xb5" (seq.++ "\xb5" (seq.++ "+" (seq.++ "H" (seq.++ "\xaa" (seq.++ "Z" (seq.++ "." (seq.++ "@" (seq.++ "U" (seq.++ "R" (seq.++ "." (seq.++ "V" (seq.++ "." (seq.++ "Z" (seq.++ "J" ""))))))))))))))))))

(assert (= regexA (re.++ (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.opt (re.++ (re.range "+" "+") (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))))(re.++ (re.range "@" "@") (re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ (re.* (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))(re.++ (re.union (re.range "0" "9") (re.range "A" "Z"))(re.++ (re.range "." ".")(re.++ (re.range "A" "Z")(re.++ (re.* (re.union (re.range "." ".") (re.range "A" "Z"))) (re.range "A" "Z"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

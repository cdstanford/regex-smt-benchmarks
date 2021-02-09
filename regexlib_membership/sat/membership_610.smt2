;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-z\s.\-_'])*<\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B2B1\x1\u00A0x<\u00C9@\u00AAB-\u00BA.\u00B5>"
(define-fun Witness1 () String (seq.++ "\xb2" (seq.++ "B" (seq.++ "1" (seq.++ "\x01" (seq.++ "\xa0" (seq.++ "x" (seq.++ "<" (seq.++ "\xc9" (seq.++ "@" (seq.++ "\xaa" (seq.++ "B" (seq.++ "-" (seq.++ "\xba" (seq.++ "." (seq.++ "\xb5" (seq.++ ">" "")))))))))))))))))
;witness2: "<\u00C27@\u00AA.H\u00AA\u00C1>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "\xc2" (seq.++ "7" (seq.++ "@" (seq.++ "\xaa" (seq.++ "." (seq.++ "H" (seq.++ "\xaa" (seq.++ "\xc1" (seq.++ ">" "")))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "-" ".")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))(re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.union (re.range "'" "'")(re.union (re.range "+" "+") (re.range "-" "."))) (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.* (re.++ (re.range "-" ".") (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff"))))))))))))) (re.range ">" ">")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (([A-Za-z0-9_\\-]+\\.?)*)[A-Za-z0-9_\\-]+\\.[A-Za-z0-9_\\-]{2,6}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "-\N\)4h"
(define-fun Witness1 () String (seq.++ "-" (seq.++ "\x5c" (seq.++ "N" (seq.++ "\x5c" (seq.++ ")" (seq.++ "4" (seq.++ "h" ""))))))))
;witness2: "\u00D3oZ\\u00919c\u00EC\x0"
(define-fun Witness2 () String (seq.++ "\xd3" (seq.++ "o" (seq.++ "Z" (seq.++ "\x5c" (seq.++ "\x91" (seq.++ "9" (seq.++ "c" (seq.++ "\xec" (seq.++ "\x00" ""))))))))))

(assert (= regexA (re.++ (re.* (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "\x5c" "\x5c") (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) ((_ re.loop 2 6) (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "([^\\"]|\\.)*"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x13\"\""
(define-fun Witness1 () String (seq.++ "\x13" (seq.++ "\x22" (seq.++ "\x22" ""))))
;witness2: "9\"\\u00D9\u0095\u0089\:\\u00F3q\""
(define-fun Witness2 () String (seq.++ "9" (seq.++ "\x22" (seq.++ "\x5c" (seq.++ "\xd9" (seq.++ "\x95" (seq.++ "\x89" (seq.++ "\x5c" (seq.++ ":" (seq.++ "\x5c" (seq.++ "\xf3" (seq.++ "q" (seq.++ "\x22" "")))))))))))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.union (re.range "\x00" "!")(re.union (re.range "#" "[") (re.range "]" "\xff"))) (re.++ (re.range "\x5c" "\x5c") (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

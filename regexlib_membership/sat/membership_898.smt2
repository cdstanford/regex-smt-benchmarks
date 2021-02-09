;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = "[A-Za-z0-9]{3}"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"k8H\"?\u00C3-"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "k" (seq.++ "8" (seq.++ "H" (seq.++ "\x22" (seq.++ "?" (seq.++ "\xc3" (seq.++ "-" "")))))))))
;witness2: "\u00C82\"89J\""
(define-fun Witness2 () String (seq.++ "\xc8" (seq.++ "2" (seq.++ "\x22" (seq.++ "8" (seq.++ "9" (seq.++ "J" (seq.++ "\x22" ""))))))))

(assert (= regexA (re.++ (re.range "\x22" "\x22")(re.++ ((_ re.loop 3 3) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

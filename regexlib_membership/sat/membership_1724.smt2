;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([ \u00c0-\u01ffa-zA-Z'])+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00F0 \u00D2I"
(define-fun Witness1 () String (str.++ "\u{f0}" (str.++ " " (str.++ "\u{d2}" (str.++ "I" "")))))
;witness2: "\u00FD\u00CA"
(define-fun Witness2 () String (str.++ "\u{fd}" (str.++ "\u{ca}" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "\u{c0}" "\u{ff}")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

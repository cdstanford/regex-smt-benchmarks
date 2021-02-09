;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([ \u00c0-\u01ffa-zA-Z'])+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00F0 \u00D2I"
(define-fun Witness1 () String (seq.++ "\xf0" (seq.++ " " (seq.++ "\xd2" (seq.++ "I" "")))))
;witness2: "\u00FD\u00CA"
(define-fun Witness2 () String (seq.++ "\xfd" (seq.++ "\xca" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "\xc0" "\xff")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

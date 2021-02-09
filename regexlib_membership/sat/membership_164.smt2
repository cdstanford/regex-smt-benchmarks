;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\w_.]{5,12}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E0\u00F2E\u00CD\u00D4"
(define-fun Witness1 () String (seq.++ "\xe0" (seq.++ "\xf2" (seq.++ "E" (seq.++ "\xcd" (seq.++ "\xd4" ""))))))
;witness2: "Ad\u00BA9\u00B5.\u00B5"
(define-fun Witness2 () String (seq.++ "A" (seq.++ "d" (seq.++ "\xba" (seq.++ "9" (seq.++ "\xb5" (seq.++ "." (seq.++ "\xb5" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 5 12) (re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

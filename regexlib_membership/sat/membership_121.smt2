;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]{1,2}(.5)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "88"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "8" "")))
;witness2: "81"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "1" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "1" "9"))(re.++ (re.opt (re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.range "5" "5"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

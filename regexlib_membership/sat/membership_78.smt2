;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([012346789][0-9]{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "17949"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "7" (seq.++ "9" (seq.++ "4" (seq.++ "9" ""))))))
;witness2: "89814"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "1" (seq.++ "4" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "0" "4") (re.range "6" "9")) ((_ re.loop 4 4) (re.range "0" "9"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

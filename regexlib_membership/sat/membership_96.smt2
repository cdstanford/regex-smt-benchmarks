;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d+([.,]?\d+)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "029"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "2" (seq.++ "9" ""))))
;witness2: "9968"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "6" (seq.++ "8" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "," ",") (re.range "." "."))) (re.+ (re.range "0" "9")))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

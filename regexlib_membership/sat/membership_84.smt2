;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(100([\.\,]0{1,2})?)|(\d{1,2}[\.\,]\d{1,2})|(\d{0,2})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "100,00"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "0" (seq.++ "0" (seq.++ "," (seq.++ "0" (seq.++ "0" "")))))))
;witness2: "1"
(define-fun Witness2 () String (seq.++ "1" ""))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (str.to_re (seq.++ "1" (seq.++ "0" (seq.++ "0" "")))) (re.opt (re.++ (re.union (re.range "," ",") (re.range "." ".")) ((_ re.loop 1 2) (re.range "0" "0"))))))(re.union (re.++ ((_ re.loop 1 2) (re.range "0" "9"))(re.++ (re.union (re.range "," ",") (re.range "." ".")) ((_ re.loop 1 2) (re.range "0" "9")))) (re.++ ((_ re.loop 0 2) (re.range "0" "9")) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

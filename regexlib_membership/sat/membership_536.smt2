;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\$((\d{1})\,\d{1,3}(\,\d{3}))|(\d{1,3}(\,\d{3}))|(\d{1,3})?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00ED95"
(define-fun Witness1 () String (seq.++ "\xed" (seq.++ "9" (seq.++ "5" ""))))
;witness2: "\u00C5\u00B5802"
(define-fun Witness2 () String (seq.++ "\xc5" (seq.++ "\xb5" (seq.++ "8" (seq.++ "0" (seq.++ "2" ""))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "$" "$") (re.++ (re.range "0" "9")(re.++ (re.range "," ",")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9"))))))))(re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.++ (re.range "," ",") ((_ re.loop 3 3) (re.range "0" "9")))) (re.++ (re.opt ((_ re.loop 1 3) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

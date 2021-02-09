;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9]{1}$|^[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}$|^9999$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "9999"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" "")))))
;witness2: "9999"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" "")))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.range "1" "9") (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9")(re.++ (re.range "0" "9") (str.to_re "")))))) (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "9" ""))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

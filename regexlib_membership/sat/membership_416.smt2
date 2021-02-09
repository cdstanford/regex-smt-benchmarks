;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1]?[0-9]{1}|2[0-3]{1}):([0-5]{1}[0-9]{1})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "8:38"
(define-fun Witness1 () String (seq.++ "8" (seq.++ ":" (seq.++ "3" (seq.++ "8" "")))))
;witness2: "6:06"
(define-fun Witness2 () String (seq.++ "6" (seq.++ ":" (seq.++ "0" (seq.++ "6" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

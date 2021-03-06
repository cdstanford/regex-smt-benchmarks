;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1]?[0-9]|[2][0-3]):([0-5][0-9])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "10:15"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "0" (seq.++ ":" (seq.++ "1" (seq.++ "5" ""))))))
;witness2: "0:50"
(define-fun Witness2 () String (seq.++ "0" (seq.++ ":" (seq.++ "5" (seq.++ "0" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.range "0" "5") (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

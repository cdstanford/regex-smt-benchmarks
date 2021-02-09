;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[9][7|8][1|0][0-9]{2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "98|97"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "8" (seq.++ "|" (seq.++ "9" (seq.++ "7" ""))))))
;witness2: "9|080"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "|" (seq.++ "0" (seq.++ "8" (seq.++ "0" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "9" "9")(re.++ (re.union (re.range "7" "8") (re.range "|" "|"))(re.++ (re.union (re.range "0" "1") (re.range "|" "|"))(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

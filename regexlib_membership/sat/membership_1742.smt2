;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{2}[0-9]{6}[A-DFM]{1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "HC962849A"
(define-fun Witness1 () String (seq.++ "H" (seq.++ "C" (seq.++ "9" (seq.++ "6" (seq.++ "2" (seq.++ "8" (seq.++ "4" (seq.++ "9" (seq.++ "A" ""))))))))))
;witness2: "FE980783M"
(define-fun Witness2 () String (seq.++ "F" (seq.++ "E" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ "7" (seq.++ "8" (seq.++ "3" (seq.++ "M" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 2 2) (re.range "A" "Z"))(re.++ ((_ re.loop 6 6) (re.range "0" "9"))(re.++ (re.union (re.range "A" "D")(re.union (re.range "F" "F") (re.range "M" "M"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

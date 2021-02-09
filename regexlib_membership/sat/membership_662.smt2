;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{3}(\d|[A-Z]){8,12}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "AARK8ZY44HZX"
(define-fun Witness1 () String (seq.++ "A" (seq.++ "A" (seq.++ "R" (seq.++ "K" (seq.++ "8" (seq.++ "Z" (seq.++ "Y" (seq.++ "4" (seq.++ "4" (seq.++ "H" (seq.++ "Z" (seq.++ "X" "")))))))))))))
;witness2: "TCXU9841XZ8WXV"
(define-fun Witness2 () String (seq.++ "T" (seq.++ "C" (seq.++ "X" (seq.++ "U" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "1" (seq.++ "X" (seq.++ "Z" (seq.++ "8" (seq.++ "W" (seq.++ "X" (seq.++ "V" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "A" "Z"))(re.++ ((_ re.loop 8 12) (re.union (re.range "0" "9") (re.range "A" "Z"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

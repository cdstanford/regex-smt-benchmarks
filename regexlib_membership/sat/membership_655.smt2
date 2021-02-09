;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{4}[1-8](\d){2}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "YZPN878"
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "Z" (seq.++ "P" (seq.++ "N" (seq.++ "8" (seq.++ "7" (seq.++ "8" ""))))))))
;witness2: "UOQJ822"
(define-fun Witness2 () String (seq.++ "U" (seq.++ "O" (seq.++ "Q" (seq.++ "J" (seq.++ "8" (seq.++ "2" (seq.++ "2" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 4 4) (re.range "A" "Z"))(re.++ (re.range "1" "8")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

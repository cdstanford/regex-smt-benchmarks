;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((([7-9])(\d{3})([-])(\d{4}))|(([7-9])(\d{7})))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "7998-8199"
(define-fun Witness1 () String (seq.++ "7" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "-" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "9" ""))))))))))
;witness2: "7565-0307\u00C1\""
(define-fun Witness2 () String (seq.++ "7" (seq.++ "5" (seq.++ "6" (seq.++ "5" (seq.++ "-" (seq.++ "0" (seq.++ "3" (seq.++ "0" (seq.++ "7" (seq.++ "\xc1" (seq.++ "\x22" ""))))))))))))

(assert (= regexA (re.union (re.++ (re.range "7" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9"))))) (re.++ (re.range "7" "9") ((_ re.loop 7 7) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

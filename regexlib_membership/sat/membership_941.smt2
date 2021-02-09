;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[0][5][0]-\d{7}|[0][5][2]-\d{7}|[0][5][4]-\d{7}|[0][5][7]-\d{7}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "054-9439454"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "5" (seq.++ "4" (seq.++ "-" (seq.++ "9" (seq.++ "4" (seq.++ "3" (seq.++ "9" (seq.++ "4" (seq.++ "5" (seq.++ "4" ""))))))))))))
;witness2: "l\u00F3t\u00CC\u00FA052-0853117\u00B2~!"
(define-fun Witness2 () String (seq.++ "l" (seq.++ "\xf3" (seq.++ "t" (seq.++ "\xcc" (seq.++ "\xfa" (seq.++ "0" (seq.++ "5" (seq.++ "2" (seq.++ "-" (seq.++ "0" (seq.++ "8" (seq.++ "5" (seq.++ "3" (seq.++ "1" (seq.++ "1" (seq.++ "7" (seq.++ "\xb2" (seq.++ "~" (seq.++ "!" ""))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "0" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9"))))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "2" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9")))(re.union (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "4" (seq.++ "-" ""))))) ((_ re.loop 7 7) (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "0" (seq.++ "5" (seq.++ "7" (seq.++ "-" "")))))(re.++ ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

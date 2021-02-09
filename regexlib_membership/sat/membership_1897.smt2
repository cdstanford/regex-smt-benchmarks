;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "255.8.29.190"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "5" (seq.++ "5" (seq.++ "." (seq.++ "8" (seq.++ "." (seq.++ "2" (seq.++ "9" (seq.++ "." (seq.++ "1" (seq.++ "9" (seq.++ "0" "")))))))))))))
;witness2: "246.248.1.198"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "4" (seq.++ "6" (seq.++ "." (seq.++ "2" (seq.++ "4" (seq.++ "8" (seq.++ "." (seq.++ "1" (seq.++ "." (seq.++ "1" (seq.++ "9" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "1" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9")))))(re.++ (re.range "." ".")(re.++ (re.union (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "0" "1") ((_ re.loop 2 2) (re.range "0" "9")))(re.union (re.++ (re.range "1" "9") (re.range "0" "9")) (re.range "0" "9"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

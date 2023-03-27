;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<lat>(-?(90|(\d|[1-8]\d)(\.\d{1,6}){0,1})))\,{1}(?<long>(-?(180|(\d|\d\d|1[0-7]\d)(\.\d{1,6}){0,1})))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "90,-158.76"
(define-fun Witness1 () String (str.++ "9" (str.++ "0" (str.++ "," (str.++ "-" (str.++ "1" (str.++ "5" (str.++ "8" (str.++ "." (str.++ "7" (str.++ "6" "")))))))))))
;witness2: "2,94.5"
(define-fun Witness2 () String (str.++ "2" (str.++ "," (str.++ "9" (str.++ "4" (str.++ "." (str.++ "5" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.opt (re.range "-" "-")) (re.union (str.to_re (str.++ "9" (str.++ "0" ""))) (re.++ (re.union (re.range "0" "9") (re.++ (re.range "1" "8") (re.range "0" "9"))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9")))))))(re.++ (re.range "," ",")(re.++ (re.++ (re.opt (re.range "-" "-")) (re.union (str.to_re (str.++ "1" (str.++ "8" (str.++ "0" "")))) (re.++ (re.union (re.range "0" "9")(re.union (re.++ (re.range "0" "9") (re.range "0" "9")) (re.++ (re.range "1" "1")(re.++ (re.range "0" "7") (re.range "0" "9"))))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 1 6) (re.range "0" "9"))))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)

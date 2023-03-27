;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<prov>10)(?<tipo>(AV))?-(?<tomo>\d{1,4})-(?<folio>\d{1,5})|^(?<prov>[1-9])(?<tipo>(AV))?-(?<tomo>\d{1,4})-(?<folio>\d{1,5})|^(?<tipo>(E|N|PE))-(?<tomo>\d{1,4})-(?<folio>\d{1,5})
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "E-9289-8488"
(define-fun Witness1 () String (str.++ "E" (str.++ "-" (str.++ "9" (str.++ "2" (str.++ "8" (str.++ "9" (str.++ "-" (str.++ "8" (str.++ "4" (str.++ "8" (str.++ "8" ""))))))))))))
;witness2: "E-6-9998"
(define-fun Witness2 () String (str.++ "E" (str.++ "-" (str.++ "6" (str.++ "-" (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "8" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "1" (str.++ "0" "")))(re.++ (re.opt (str.to_re (str.++ "A" (str.++ "V" ""))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9"))))))))(re.union (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ (re.opt (str.to_re (str.++ "A" (str.++ "V" ""))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9")))))))) (re.++ (str.to_re "")(re.++ (re.union (re.union (re.range "E" "E") (re.range "N" "N")) (str.to_re (str.++ "P" (str.++ "E" ""))))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 1 4) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 1 5) (re.range "0" "9")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
